import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../forex/presentation/forex_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      body: ForexPage(),
    );
  }
}
