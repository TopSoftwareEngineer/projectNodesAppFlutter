import 'package:http/http.dart';
import 'package:projectx/contract/node.g.dart';
import 'package:projectx/utils/web3/config.dart';
import 'package:web3dart/web3dart.dart';

class NodeDataFeed {
  late String _rpcUrl;
  late Node _nodeRewardsManagerInstance;

  NodeDataFeed({String strRpcUrl = Web3Config.defRPCUrl, String strNodeRewardsContractAddress = Web3Config.defNodeRewardsContractAddress}) {
    _rpcUrl = strRpcUrl;
    Web3Client web3client = Web3Client(strRpcUrl, Client());
    _nodeRewardsManagerInstance = Node(address: EthereumAddress.fromHex(strNodeRewardsContractAddress), client: web3client);
  }

  // Future<bool> isNodeOwner({required EthereumAddress address}) async {
  //   return await _nodeRewardsManagerInstance.isNodeOwner(address);
  // }
  //
  // Future<String> createNodes({required EthereumAddress address, required int amount, required Credentials credentials}) async {
  //   return await _nodeRewardsManagerInstance.createNodes(address, BigInt.from(amount), credentials: credentials);
  // }
  //
  // Future<BigInt> totalNodesCreated() async {
  //   return await _nodeRewardsManagerInstance.totalNodesCreated();
  // }
  //
  // Future<BigInt> getNodeNumberOf({required EthereumAddress address}) async {
  //   return await _nodeRewardsManagerInstance.getNodeNumberOf(address);
  // }
  //
  // Future<BigInt> getRewardAmountOf({required EthereumAddress address}) async {
  //   return await _nodeRewardsManagerInstance.getRewardAmountOf(address);
  // }
  //
  // Future<String> getNodesRewardAvailable({required EthereumAddress address}) async {
  //   return await _nodeRewardsManagerInstance.getNodesRewardAvailable(address);
  // }
  //
  // Future<String> getNodesLastClaimTime({required EthereumAddress address}) async {
  //   return await _nodeRewardsManagerInstance.getNodesLastClaimTime(address);
  // }
  //
  // Future<BigInt> getClaimInterval({required EthereumAddress address}) async {
  //   return await _nodeRewardsManagerInstance.claimInterval();
  // }
}