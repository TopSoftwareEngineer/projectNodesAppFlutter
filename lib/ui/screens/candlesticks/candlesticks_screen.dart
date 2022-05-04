import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/data/repositories/candlesticks_repository.dart';
import 'package:projectx/ui/widgets/candlesticks_count.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CandlesticksScreen extends StatefulWidget {
  const CandlesticksScreen({Key? key}) : super(key: key);

  @override
  _CandlesticksScreenState createState() => _CandlesticksScreenState();
}

class _CandlesticksScreenState extends State<CandlesticksScreen> {
  List<Candle> candles = [];
  WebSocketChannel? _channel;

  String interval = "1d";
  void binanceFetch(String interval) {
    fetchCandles(symbol: "AVAXUSDT", interval: interval).then(
      (value) => setState(
        () {
          this.interval = interval;
          candles = value;
        },
      ),
    );
    if (_channel != null) _channel!.sink.close();
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws'),
    );

    _channel!.sink.add(
      jsonEncode(
        {
          "method": "SUBSCRIBE",
          "params": ["avaxusdt@kline_" + interval],
          "id": 1
        },
      ),
    );
  }

  @override
  void initState() {
    binanceFetch("1d");
    super.initState();
  }

  @override
  void dispose() {
    if (_channel != null) _channel!.sink.close();
    super.dispose();
  }

  double updateCandlesFromSnapshot(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.data != null) {
      final data = jsonDecode(snapshot.data as String) as Map<String, dynamic>;
      if (data.containsKey("k") == true &&
          candles[0].date.millisecondsSinceEpoch == data["k"]["t"]) {

        candles[0] = Candle(
            date: candles[0].date,
            high: double.parse(data["k"]["h"]),
            low: double.parse(data["k"]["l"]),
            open: double.parse(data["k"]["o"]),
            close: double.parse(data["k"]["c"]),
            volume: double.parse(data["k"]["v"]));

      } else if (data.containsKey("k") == true &&
          data["k"]["t"] - candles[0].date.millisecondsSinceEpoch ==
              candles[0].date.millisecondsSinceEpoch -
                  candles[1].date.millisecondsSinceEpoch) {
        candles.insert(
          0,
          Candle(
            date: DateTime.fromMillisecondsSinceEpoch(data["k"]["t"]),
            high: double.parse(data["k"]["h"]),
            low: double.parse(data["k"]["l"]),
            open: double.parse(data["k"]["o"]),
            close: double.parse(data["k"]["c"]),
            volume: double.parse(data["k"]["v"]),
          ),
        );

      }

      try {
        return  double.parse(data["k"] ["c"]);
      } catch(e) {
        return 0;
      }

   }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBluebackground,
      body: StreamBuilder(
          stream: _channel == null ? null : _channel!.stream,
          builder: (context, snapshot) {
            final actualValue = updateCandlesFromSnapshot(snapshot);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CandlesticksCount(number: actualValue),
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Candlesticks(
                    onIntervalChange: (String value) async {
                      binanceFetch(value);
                    },
                    candles: candles,
                    interval: interval,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
