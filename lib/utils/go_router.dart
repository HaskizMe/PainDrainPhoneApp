// Create your GoRouter with the desired routes.
import 'package:go_router/go_router.dart';

import '../screens/connect_device/connect_to_device.dart';
import '../screens/home/home_screen.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ConnectDevice(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);