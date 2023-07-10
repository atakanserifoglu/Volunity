import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/riverpod/bottom_bar_riverpod.dart';
import 'package:volunity/riverpod/profile_screen_riverpod.dart';
import 'package:volunity/utilities/bottom_bar.dart';

class MainScaffold extends ConsumerWidget {
  static const String id = 'Main Scaffold';
  MainScaffold({super.key});

  bool _isOrganizer = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(profileScreenProvider);
    _isOrganizer = watch.isOrganizer;
    return _isOrganizer == true ? OrganizerMainScaffold() : PersonelMainScaffold();
  }
}

class OrganizerMainScaffold extends ConsumerWidget {
  const OrganizerMainScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(bottomNavigationBarOrgProvider).currentWidget(),
      bottomNavigationBar: const BottomOrgBar(),
    );
  }
}

class PersonelMainScaffold extends ConsumerWidget {
  const PersonelMainScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(bottomNavigationBarPersProvider).currentWidget(),
      bottomNavigationBar: const BottomPersBar(),
    );
  }
}
