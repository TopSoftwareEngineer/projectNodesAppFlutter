import 'package:http/http.dart';
import 'package:projectx/EACAggregatorProxyContract.g.dart';
import 'package:projectx/utils/web3/config.dart';
import 'package:web3dart/web3dart.dart';

class ChainLinkDataFeed {
  late String _rpcUrl;
  late EACAggregatorProxyContract _chainLinkInstance;

  ChainLinkDataFeed({String strRpcUrl = Web3Config.defRPCUrl, String strChainLinkContractAddress = Web3Config.defAVAXUSDFeed}) {
    _rpcUrl = strRpcUrl;
    Web3Client web3client = Web3Client(strRpcUrl, Client());
    _chainLinkInstance = EACAggregatorProxyContract(address: EthereumAddress.fromHex(strChainLinkContractAddress), client: web3client);
  }

  Future<BigInt> latestRoundData() async {
    return EtherAmount.fromUnitAndValue(EtherUnit.wei,  await _chainLinkInstance.latestRound()).getInEther;
  }
}