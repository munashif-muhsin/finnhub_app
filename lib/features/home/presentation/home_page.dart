import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../forex/presentation/forex_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: AppColors.of(context).background,
        bottomNavigationBar: SafeArea(
          child: TabBar(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            labelColor: Theme.of(context).colorScheme.primary,
            indicator: BoxDecoration(border: Border.all(color: Colors.transparent)),
            tabs: const [
              Tab(
                text: 'Forex',
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [ForexPage()]),
      ),
    );
  }
}
