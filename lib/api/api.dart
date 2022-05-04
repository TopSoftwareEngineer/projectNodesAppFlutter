import 'package:projectx/api/http_manager.dart';

class Api {
  static Future<dynamic> authenticateWalletAddress({required String address}) async {
    return await httpManager.post(url: 'auth/client', data: {'wallet_address': address,});
  }

  static Future<dynamic> getListNodes() async {
    return await httpManager.get(url: 'nodes/client', authToken: true);
  }

  static Future<dynamic> createNodes({required int amount}) async {
    return await httpManager.post(url: 'nodes/create', data: {'amount': amount}, authToken: true);
  }
}