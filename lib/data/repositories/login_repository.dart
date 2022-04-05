import 'package:http/http.dart' as http;

class LoginRepository {
  static const String urlApi =
      'https://nodeapi.projectx.financial/api/v1/auth/client';
  var url = Uri.parse(urlApi);

  Future<Map<int, String>> authenticateKeyUser({required String key}) async {
    try {
      final response = await http.post(
        url,
        body: {
          'wallet_address': key,
        },
      );
      Map<int, String> mapResponse = {
        response.statusCode: response.body,
      };
      return mapResponse;
    } catch (e) {
      return {500: 'Server Error'};
    }
  }
}
