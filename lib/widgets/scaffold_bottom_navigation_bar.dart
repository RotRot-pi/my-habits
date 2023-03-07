import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_habits/services/settings/routes/routes_constants.dart';
import 'package:my_habits/utils/colors/app_colors.dart';
import 'package:my_habits/widgets/icons.dart';

final bottomNavIndexProvider = StateProvider((ref) => 0);

final tabs = [
  const ScaffoldWithNavBarTabItem(
    initialLocation: Routes.homePagePath,
    icon: NavigationIcons.outlinedHome,
    label: 'Home',
  ),
  const ScaffoldWithNavBarTabItem(
    initialLocation: Routes.progressPagePath,
    icon: NavigationIcons.outlinedProgress,
    label: 'Progress',
  ),
  const ScaffoldWithNavBarTabItem(
    initialLocation: Routes.createPagePath,
    icon: NavigationIcons.outlinedCreate,
    label: 'Create',
  ),
  const ScaffoldWithNavBarTabItem(
    initialLocation: Routes.motivationgPagePath,
    icon: NavigationIcons.outlinedMotivation,
    label: 'Motivation',
  ),
  const ScaffoldWithNavBarTabItem(
    initialLocation: Routes.settingPagePath,
    icon: NavigationIcons.outlinedSettings,
    label: 'Settings',
  ),
];

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem({
    required this.initialLocation,
    required Widget icon,
    String? label,
  }) : super(icon: icon, label: label);

  final String initialLocation;
}

class ScaffoldWithBottomNavBar extends ConsumerWidget {
  const ScaffoldWithBottomNavBar({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.read(bottomNavIndexProvider.notifier).state;
    final goRouter = GoRouter.of(context);

    void onItemTapped(int tabIndex) {
      if (tabIndex != currentIndex) {
        ref.read(bottomNavIndexProvider.notifier).state = tabIndex;
        goRouter.go(tabs[tabIndex].initialLocation);
      }
    }

    return Scaffold(
      
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorPalett.textPrimary2,
        unselectedItemColor: ColorPalett.textSecondary3,
        currentIndex: currentIndex,
        items: tabs,
        onTap: onItemTapped,
      ),
      backgroundColor: ColorPalett.pagePrimary1,
    );
  }
}























// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// //import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:my_habits/services/settings/routes/routes.dart';
// import 'package:my_habits/widgets/icons.dart';

// final scaffoldWithBottomNavBarProvider =
//     Provider.autoDispose((ref) => ScaffoldWithBottomNavBar());

// final scaffoldWithBottomNavBarTabsProvider =
//     Provider<List<ScaffoldWithNavBarTabItem>>((ref) => [
//           ScaffoldWithNavBarTabItem(
//             initialLocation: Routes.homePagePath,
//             icon: NavigationIcons.outlinedHome,
//             label: 'Home',
//           ),
//           ScaffoldWithNavBarTabItem(
//             initialLocation: Routes.progressPagePath,
//             icon: NavigationIcons.outlinedProgress,
//             label: 'Progress',
//           ),
//           ScaffoldWithNavBarTabItem(
//             initialLocation: Routes.createPagePath,
//             icon: NavigationIcons.outlinedCreate,
//             label: 'Create',
//           ),
//           ScaffoldWithNavBarTabItem(
//             initialLocation: Routes.motivationgPagePath,
//             icon: NavigationIcons.outlinedMotivation,
//             label: 'Motivation',
//           ),
//           ScaffoldWithNavBarTabItem(
//             initialLocation: Routes.settingPagePath,
//             icon: NavigationIcons.outlinedSettings,
//             label: 'Settings',
//           ),
//         ]);

// class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
//   const ScaffoldWithNavBarTabItem({
//     required this.initialLocation,
//     required Widget icon,
//     String? label,
//   }) : super(icon: icon, label: label);

//   /// The initial location/path
//   final String initialLocation;
// }

// class ScaffoldWithBottomNavBar extends ConsumerWidget {
//   const ScaffoldWithBottomNavBar({Key? key}) : super(key: key);

//   // getter that computes the current index from the current location,
//   // using the helper method below
//   int _locationToTabIndex(
//       String location, List<ScaffoldWithNavBarTabItem> tabs) {
//     final index =
//         tabs.indexWhere((t) => location.startsWith(t.initialLocation));
//     // if index not found (-1), return 0
//     return index < 0 ? 0 : index;
//   }

//   // callback used to navigate to the desired tab
//   void _onItemTapped(BuildContext context, int tabIndex,
//       List<ScaffoldWithNavBarTabItem> tabs) {
//     final currentIndex =
//         _locationToTabIndex(GoRouter.of(context).location, tabs);
//     if (tabIndex != currentIndex) {
//       // go to the initial location of the selected tab (by index)
//       context.go(tabs[tabIndex].initialLocation);
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final tabs = ref.watch(scaffoldWithBottomNavBarTabsProvider);
//     final currentIndex =
//         _locationToTabIndex(GoRouter.of(context).location, tabs);

//     return Scaffold(
//       body: ref.watch(scaffoldWithBottomNavBarProvider),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         items: tabs,
//         onTap: (index) => _onItemTapped(context, index, tabs),
//       ),
//     );
//   }
// }






















// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:my_habits/services/settings/routes/routes.dart';
// import 'package:my_habits/widgets/icons.dart';

// const tabs = [
//   ScaffoldWithNavBarTabItem(
//     initialLocation: Routes.homePagePath,
//     icon: NavigationIcons.outlinedHome,
//     label: 'Home',
//   ),
//   ScaffoldWithNavBarTabItem(
//     initialLocation: Routes.progressPagePath,
//     icon: NavigationIcons.outlinedProgress,
//     label: 'Progress',
//   ),
//   ScaffoldWithNavBarTabItem(
//     initialLocation: Routes.createPagePath,
//     icon: NavigationIcons.outlinedCreate,
//     label: 'Create',
//   ),
//   ScaffoldWithNavBarTabItem(
//     initialLocation: Routes.motivationgPagePath,
//     icon: NavigationIcons.outlinedMotivation,
//     label: 'Motivation',
//   ),
//   ScaffoldWithNavBarTabItem(
//     initialLocation: Routes.settingPagePath,
//     icon: NavigationIcons.outlinedSettings,
//     label: 'Settings',
//   ),
// ];

// class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
//   const ScaffoldWithNavBarTabItem(
//       {required this.initialLocation, required Widget icon, String? label})
//       : super(icon: icon, label: label);

//   /// The initial location/path
//   final String initialLocation;
// }

// class ScaffoldWithBottomNavBar extends StatefulWidget {
//   const ScaffoldWithBottomNavBar({Key? key, required this.child})
//       : super(key: key);
//   final Widget child;

//   @override
//   State<ScaffoldWithBottomNavBar> createState() =>
//       _ScaffoldWithBottomNavBarState();
// }

// class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
//   // getter that computes the current index from the current location,
//   // using the helper method below
//   int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

//   int _locationToTabIndex(String location) {
//     final index =
//         tabs.indexWhere((t) => location.startsWith(t.initialLocation));
//     // if index not found (-1), return 0
//     return index < 0 ? 0 : index;
//   }

//   // callback used to navigate to the desired tab
//   void _onItemTapped(BuildContext context, int tabIndex) {
//     if (tabIndex != _currentIndex) {
//       // go to the initial location of the selected tab (by index)
//       context.go(tabs[tabIndex].initialLocation);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: widget.child,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         items: tabs,
//         onTap: (index) => _onItemTapped(context, index),
//       ),
//     );
//   }
// }
