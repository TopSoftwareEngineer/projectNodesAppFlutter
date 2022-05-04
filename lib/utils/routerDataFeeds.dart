import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'dart:typed_data' as _i2;
import '../Router.g.dart';

class RouterDataFeeds {
  late String rpcHttpUrl;

  late Web3Client web3HttpClient;
  late Router routerInstance;

  //MAINNET
  //const String url = "https://api.avax-test.network/ext/bc/C/rpc";
  //TESTNET
  final String url = "https://api.avax-test.network/ext/bc/C/rpc";

  RouterDataFeeds(String rpcHttpUrl, String plainDataFeedsContractAddress) {
    web3HttpClient = Web3Client(rpcHttpUrl, Client());
    routerInstance = Router(
        client: web3HttpClient,
        address: EthereumAddress.fromHex(plainDataFeedsContractAddress));
  }

  Future<String> swapAVAXForExactTokens(BigInt amountOutMin,
      List<EthereumAddress> path, EthereumAddress to, BigInt deadline) async {
    const String privateKey =
        'a2fd51b96dc55aeb14b30d55a6b3121c7b9c599500c1beb92a389c3377adc86e';
    final client = Web3Client(url, Client());

    final credentials = EthPrivateKey.fromHex(privateKey);

    return await routerInstance.swapAVAXForExactTokens(
        amountOutMin, path, to, deadline,
        credentials: credentials);
  }

  Future<String> swapExactTokensForAVAX(BigInt amountIn, BigInt amountOutMin,
      List<EthereumAddress> path, EthereumAddress to, BigInt deadline) async {
    const String privateKey =
        'a2fd51b96dc55aeb14b30d55a6b3121c7b9c599500c1beb92a389c3377adc86e';
    final client = Web3Client(url, Client());

    final credentials = EthPrivateKey.fromHex(privateKey);

    return await routerInstance.swapExactTokensForAVAX(
        amountIn, amountOutMin, path, to, deadline,
        credentials: credentials);
  }

  Future<String> swapExactTokensForAVAXSupportingFeeOnTransferTokens(
      BigInt amountIn,
      BigInt amountOutMin,
      List<EthereumAddress> path,
      EthereumAddress to,
      BigInt deadline) async {
    const String privateKey =
        'a2fd51b96dc55aeb14b30d55a6b3121c7b9c599500c1beb92a389c3377adc86e';
    final client = Web3Client(url, Client());

    final credentials = EthPrivateKey.fromHex(privateKey);

    return await routerInstance
        .swapExactTokensForAVAXSupportingFeeOnTransferTokens(
            amountIn, amountOutMin, path, to, deadline,
            credentials: credentials);
  }

  Future<List<BigInt>> getAmountsOut(
      BigInt amountIn, List<EthereumAddress> path) async {
    return await routerInstance.getAmountsOut(amountIn, path);
  }
}
