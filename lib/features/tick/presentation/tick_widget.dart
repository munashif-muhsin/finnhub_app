import 'dart:async';

import 'package:flutter/material.dart';

import '../models/tick_model.dart';
import '../utils/ticker_mixin.dart';

class TickWidget extends StatefulWidget with TickerMixin {
  final String symbol;
  final bool showIcon;

  const TickWidget({
    super.key,
    required this.symbol,
    this.showIcon = true,
  });

  @override
  State<TickWidget> createState() => _TickWidgetState();
}

class _TickWidgetState extends State<TickWidget> {
  StreamSubscription? subscription;
  TickData? lastTick;
  TickData? currentTick;

  Icon _getDirectionalIcon() {
    final iconSize = 30.0;

    if (lastTick?.price == currentTick?.price || lastTick == null) {
      return Icon(
        Icons.minimize_outlined,
        color: Colors.transparent,
        size: iconSize,
      );
    }

    return (lastTick?.price ?? 0) > (currentTick?.price ?? 0)
        ? Icon(
            Icons.keyboard_arrow_down,
            color: Colors.red,
            size: iconSize,
          )
        : Icon(
            Icons.keyboard_arrow_up,
            color: Colors.green,
            size: iconSize,
          );
  }

  @override
  void initState() {
    subscription = widget.tickStream(widget.symbol).listen((TickData tick) {
      setState(() {
        lastTick = currentTick;
        currentTick = tick;
      });
    });
    widget.subscribeToSymbol(widget.symbol);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.showIcon) _getDirectionalIcon(),
        Text(
          currentTick?.price?.toStringAsFixed(2) ?? '--',
          style: TextTheme.of(context).headlineMedium?.copyWith(color: getColor()),
        ),
      ],
    );
  }

  Color getColor() {
    if (lastTick?.price == currentTick?.price || lastTick == null) return Colors.grey;

    return (lastTick?.price ?? 0) > (currentTick?.price ?? 0) ? Colors.red : Colors.green;
  }

  @override
  void dispose() {
    widget.unsubscribeToSymbol(widget.symbol);
    subscription?.cancel();
    super.dispose();
  }
}
