import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import '../EACAggregatorProxyContract.g.dart';

class ChainLinkDataFeeds {
  late String rpcHttpUrl;
  late EthereumAddress dataFeedsContractAddress;
  late Web3Client web3HttpClient;
  late EACAggregatorProxyContract EACAggregatorProxyInstance;

  ChainLinkDataFeeds(String rpcHttpUrl, String plainDataFeedsContractAddress) {
    dataFeedsContractAddress = EthereumAddress.fromHex(plainDataFeedsContractAddress);
    web3HttpClient = Web3Client(rpcHttpUrl, Client());

    EACAggregatorProxyInstance = EACAggregatorProxyContract(
        client: web3HttpClient,
        address: dataFeedsContractAddress
    );
  }

  Future<BigInt> latestRoundData() async {
    return EtherAmount.fromUnitAndValue(EtherUnit.wei,  await EACAggregatorProxyInstance.latestRound()).getInEther;
  }

  /*
  Future<BigInt> latestRoundDataEth() async {
    final a = await EACAggregatorProxyInstance.latestRound();
    return  EtherAmount.fromUnitAndValue(EtherUnit.wei, a);
  }
  */
}
