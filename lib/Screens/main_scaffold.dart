

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/riverpod/bottom_bar_riverpod.dart';
import 'package:volunity/utilities/bottom_bar.dart';

class MainScaffold extends ConsumerWidget {
  static const String id = 'Main Scaffold';
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(bottomNavigationBarProvider).currentWidget(),
      bottomNavigationBar: const BottomBar(),
    );
  }
}