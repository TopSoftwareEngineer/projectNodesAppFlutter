import 'dart:convert';

import 'package:projectx/config/strings.dart';
import 'package:projectx/data/models/node.dart';
import 'package:http/http.dart' as http;
import 'package:projectx/data/models/response.dart';

class NodeRepository {
  static const String urlApi =
      "https://nodeapi.projectx.financial/api/v1/nodes/";
  Future<List<Node>> getListNodes({
    required String token,
  }) async {
    try {
      var url = Uri.parse(urlApi + 'client');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'bearer $token',
          'Content-Type': 'application/json'
        },
      );
      final map = json.decode(response.body).cast<Map<String, dynamic>>();
      return map.map<Node>((json) => Node.fromMap(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Response> createNodes(
      {required String token, required int amount}) async {
    try {
      var url = Uri.parse(urlApi + 'create');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode(
          <String, int>{
            'amount': amount,
          },
        ),
      );
      final statusCode = json.decode(response.statusCode.toString());
      return statusCode == 200
          ? const Response(
              status: true,
              message: PxStrings.responseNodeCreatedOk,
            )
          : const Response(
              status: false,
              message: PxStrings.errorClaimProcess,
            );
    } catch (e) {
      return const Response(
        status: false,
        message: PxStrings.errorClaimProcess,
      );
    }
  }
}
