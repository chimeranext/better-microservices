import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/browse/browse_screen.dart';
import '../features/product_detail/product_detail_screen.dart';
import '../features/search/search_screen.dart';

/// Application router. Three top-level destinations:
///   /           → browse (default catalog view)
///   /search     → search (full-text + filters)
///   /product/:id → product detail (schema-driven)
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => _RootShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'browse',
          builder: (context, state) => const BrowseScreen(),
        ),
        GoRoute(
          path: '/search',
          name: 'search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: '/product/:id',
          name: 'product_detail',
          builder: (context, state) => ProductDetailScreen(
            productId: state.pathParameters['id']!,
          ),
        ),
      ],
    ),
  ],
);

/// Shared scaffold: bottom nav between browse + search. Product detail keeps
/// the nav bar so users can switch context without losing stack depth.
class _RootShell extends StatelessWidget {
  const _RootShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final selectedIndex = switch (location) {
      '/search' => 1,
      _ => 0,
    };
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (i) {
          switch (i) {
            case 0:
              context.goNamed('browse');
            case 1:
              context.goNamed('search');
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Browse',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
