import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:finnhub_app/features/tick/models/tick_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../main.dart';

class ApiConnection {
  static final ApiConnection instance = ApiConnection._();

  ApiConnection._() {
    initialize();
  }

  late WebSocketChannel _channel;

  // Added a new stream controller as the stream provided by
  // websocket isn't broadcast
  final StreamController<TickData> _tickController = StreamController.broadcast();
  Stream<TickData> get tickStream => _tickController.stream;

  // This stores the count of subscription per id
  // This is done so that we are not subscribing to the same symbol
  // multiple times
  // also makes unsubscribe easier as we know if
  // there is another widget subscribed to the same id
  final Map<String, int> _subscriptions = {};

  // This is used to queue the subscriptions when the connection is not ready.
  List<String> symbolsToSubscribe = [];

  bool isTryingToReconnect = true;

  void subscribeToSymbolsInQueue() {
    for (var symbol in symbolsToSubscribe) {
      subscribeToSymbol(symbol);
    }
    symbolsToSubscribe.clear();
  }

  void initialize() async {
    try {
      final wsUrl = Uri.parse(getUrl());

      // Setting `isTryingToReconnect` to True so we will not run this again
      isTryingToReconnect = true;

      _channel = WebSocketChannel.connect(wsUrl);

      await _channel.ready;
      isTryingToReconnect = false;
      print("connection ready");

      // Resubscribe if connection was disconnected
      if (_subscriptions.values.where((element) => element != 0).isNotEmpty) {
        final keysToSubscribe = _subscriptions.keys;
        for (var key in keysToSubscribe) {
          subscribeToSymbol(key);
        }
      }

      subscribeToSymbolsInQueue();

      _channel.stream.listen(onData, cancelOnError: false, onDone: onClose);
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
    }
  }

  void onClose() {
    log("Connection closed");
  }

  void onData(dynamic message) {
    try {
      final decodedMessage = jsonDecode(message);
      final List response = decodedMessage['data'] ?? [];
      if (response.isEmpty) return;

      final list = List<TickData>.from(response.map((e) => TickData.fromJson(e)));
      for (var element in list) {
        print(element);
        _tickController.add(element);
      }
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
    }
  }

  // These messages will not be resubscribed on disconnection
  // Use this for one time requests
  void addMessage(String message) {
    if (_channel.closeCode == null) {
      print(message);
      _channel.sink.add(message);
    }
  }

  // These messages will be resubscribed on disconnection
  // Use this only for ticks
  void subscribeToSymbol(String symbol) {
    if (isTryingToReconnect) {
      symbolsToSubscribe.add(symbol);
      return;
    }

    int? subscriptionsCount = _subscriptions[symbol];

    // Increment subscriptions count
    if (subscriptionsCount != null) {
      _subscriptions[symbol] = ++subscriptionsCount;
      return;
    }

    _subscriptions[symbol] = 1;
    addMessage(jsonEncode({"type": "subscribe", "symbol": symbol}));
  }

  // Unsubscribe from socket and
  // remove from messages to resubscribe on disconnection
  void unsubscribeFromSymbol(String symbol) {
    int? subscriptionsCount = _subscriptions[symbol];

    // Decrement subscriptions count
    if (subscriptionsCount != null && subscriptionsCount > 1) {
      _subscriptions[symbol] = --subscriptionsCount;
      return;
    }

    // Last subscription, we will have to unsubscribe now
    _subscriptions.remove(symbol);
    addMessage(jsonEncode({"type": "unsubscribe", "symbol": symbol}));
  }

  // Create socket url
  String getUrl() {
    final url = apiUrls.wsUrl;
    final uri = Uri.parse(url);
    final urlWithToken = uri.replace(
      queryParameters: {'token': dotenv.get("API_KEY")},
    );

    return urlWithToken.toString();
  }
}
