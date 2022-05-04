import 'package:projectx/utils/shared_preferences_utils.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import '../Token.g.dart';

class TokenDataFeeds {
  late String rpcHttpUrl;
  late EthereumAddress dataFeedsContractAddress;
  late Web3Client web3HttpClient;
  late Token tokenInstance;

  TokenDataFeeds(String rpcHttpUrl, String plainDataFeedsContractAddress) {
    dataFeedsContractAddress =
        EthereumAddress.fromHex(plainDataFeedsContractAddress);
    web3HttpClient = Web3Client(rpcHttpUrl, Client());

    tokenInstance =
        Token(client: web3HttpClient, address: dataFeedsContractAddress);
  }

<<<<<<< HEAD
  Future<BigInt> decimals() async {
    return await tokenInstance.decimals();
  }

=======
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
  Future<BigInt> allowance(
      EthereumAddress owner, EthereumAddress spender) async {
    return await tokenInstance.allowance(owner, spender);
  }

  Future<BigInt> balanceOf(String account) async {
    return await tokenInstance.balanceOf(EthereumAddress.fromHex(account));
  }

  Future<String> approve(EthereumAddress spender, BigInt amount) async {
    const String url = "https://api.avax-test.network/ext/bc/C/rpc";

    final privateKey = await SharedPreferencesUtil.getString('privateKey');

    final client = Web3Client(url, Client());

    final credentials = EthPrivateKey.fromHex(privateKey!);

    return await tokenInstance.approve(spender, amount,
        credentials: credentials);
  }

  Future<String> cashoutAll() async {
    final privateKey = SharedPreferencesUtil.getString('privateKey');

    final credentials = EthPrivateKey.fromHex(privateKey!);

    return await tokenInstance.cashoutAll(credentials: credentials);
  }

  Future<String> createNodeWithTokens(BigInt numberOfNodes) async {
    final privateKey = SharedPreferencesUtil.getString('privateKey');

    final credentials = EthPrivateKey.fromHex(privateKey!);

    return await tokenInstance.createNodeWithTokens(numberOfNodes,
        credentials: credentials);
  }

  /*
  Future<BigInt> latestRoundDataEth() async {
    final a = await EACAggregatorProxyInstance.latestRound();
    return  EtherAmount.fromUnitAndValue(EtherUnit.wei, a);
  } 
  */
}
