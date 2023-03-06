import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/services.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            ref.read(appStateManagerProvider.notifier).isLogout();
            log('appstatemanager isloggedout');
            ref.read(authenticationProvider).signout();
            log('sign out');
          },
        )),
        body: const Center(
          child: Text('HomePage'),
        ),
      ),
    );
  }
}
