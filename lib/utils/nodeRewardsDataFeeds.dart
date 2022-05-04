import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import '../NodeRewardsMannager.g.dart';

class NodeRewardsDataFeeds {
  late String rpcHttpUrl;
  late EthereumAddress dataFeedsContractAddress;
  late Web3Client web3HttpClient;
  late NodeRewardsMannager nodeRewardsMannagerInstance;

  NodeRewardsDataFeeds(
      String rpcHttpUrl, String plainDataFeedsContractAddress) {
    dataFeedsContractAddress =
        EthereumAddress.fromHex(plainDataFeedsContractAddress);
    web3HttpClient = Web3Client(rpcHttpUrl, Client());

    nodeRewardsMannagerInstance = NodeRewardsMannager(
        client: web3HttpClient, address: dataFeedsContractAddress);
  }
  //si es node owner llamaremos al resto de funciones
  Future<bool> isNodeOwner(String account) async {
    return await nodeRewardsMannagerInstance
        .isNodeOwner(EthereumAddress.fromHex(account));
  }

  //mostramos el total de nodos en universal nodes initialized
  Future<BigInt> totalNodesCreated() async {
    return await nodeRewardsMannagerInstance.totalNodesCreated();
  }

  //cargamos el numero de nodos en my nodes */100
  Future<BigInt> getNodeNumberOf(String account) async {
    return await nodeRewardsMannagerInstance
        .getNodeNumberOf(EthereumAddress.fromHex(account));
  }

  //obtenemos el total del reward acumulado
  Future<BigInt> getRewardAmountOf(String account) async {
    return await nodeRewardsMannagerInstance
        .getRewardAmountOf(EthereumAddress.fromHex(account));
  }

  //obtenemos el string que hay que splitear con la # para obtener el reward de
  //cada nodo
  Future<String> getNodesRewardAvailable(String account) async {
    return await nodeRewardsMannagerInstance
        .getNodesRewardAvailable(EthereumAddress.fromHex(account));
  }

  Future<String> getNodesLastClaimTime(String account) async {
    return await nodeRewardsMannagerInstance
        .getNodesLastClaimTime(EthereumAddress.fromHex(account));
  }

  Future<BigInt> getClaimInterval(String account) async {
    return await nodeRewardsMannagerInstance.claimInterval();
  }

  /*
  Future<BigInt> latestRoundDataEth() async {
    final a = await EACAggregatorProxyInstance.latestRound();
    return  EtherAmount.fromUnitAndValue(EtherUnit.wei, a);
  }
  */
}
