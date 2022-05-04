import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:http/http.dart' as http;

Future<List<Candle>> fetchCandles(
    {required String symbol, required String interval}) async {
  // se obtienen los datos de 2 semanas
  final fromTime = DateTime.now().millisecondsSinceEpoch - 1210076000;
  final toTime = DateTime.now().millisecondsSinceEpoch;

  // final uri = Uri.parse(
  //     "https://io9.dexscreener.io/u/chart/bars/avalanche/0x326238CfAf10Fc6f536791b548441D03B80dacA8?from=" +
  //         fromTime.toString() +
  //         "&to=" +
  //         toTime.toString() +
  //         "&res=60&cb=320");
  final uri = Uri.parse(
      "https://io9.dexscreener.io/u/chart/bars/avalanche/0x326238CfAf10Fc6f536791b548441D03B80dacA8?from=1645921175000&to=1647073115490&res=60&cb=320");
  final res = await http.get(uri);
  print(res);
  return (jsonDecode(res.body) as List<dynamic>)
      .map((e) => Candle.fromJson(e))
      .toList()
      .reversed
      .toList();
}
