import 'package:flutter/material.dart';
import 'package:projectx/config/router/router_path.dart';
import 'package:projectx/data/models/node.dart';
import 'package:projectx/ui/screens/home_navigationbar_screen.dart';
import 'package:projectx/ui/screens/login/login_screen.dart';
import 'package:projectx/ui/screens/node_detail_screen.dart';
import 'package:projectx/ui/screens/node_list_screen.dart';
import 'package:projectx/ui/screens/node_wallet/node_wallet_screen.dart';
<<<<<<< HEAD
import 'package:projectx/ui/screens/wallet_import/wallet_import_screen.dart';
=======
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3

Route<MaterialPageRoute> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case PxPathCfg.initialScreenPageRoute:
      return MaterialPageRoute(
        builder: (context) => const InitialScreen(),
      );
    case PxPathCfg.homeScreenPageRoute:
      return MaterialPageRoute(
        builder: (context) => const HomeBottomNavigationBarScreen(),
      );
    case PxPathCfg.nodeListScreenPageRoute:
      final map = routeSettings.arguments as Map;
      return MaterialPageRoute(
        builder: (context) => NodeListScreen(
          listNode: map['listNode'] as List<Node>,
          cantNodes: map['cantNodes'] as String,
        ),
      );
    case PxPathCfg.nodeDetailScreenPageRoute:
      final node = routeSettings.arguments as Node;
      return MaterialPageRoute(
        builder: (context) => NodeDetailScreen(
          node: node,
        ),
      );
    case PxPathCfg.nodeWalletScreenPageRoute:
      return MaterialPageRoute(
        builder: (context) => NodeWalletScreen(),
      );
<<<<<<< HEAD
    case PxPathCfg.walletImportScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const WalletImportScreen(),
      );
=======
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text(
              'No path for ${routeSettings.name}',
            ),
          ),
        ),
      );
  }
}
