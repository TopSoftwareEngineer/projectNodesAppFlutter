import 'dart:io';

import 'package:projectx/config/strings.dart';
import 'package:projectx/data/models/node.dart';
import 'package:projectx/utils/web3/chainlink_data_feed.dart';
import 'package:projectx/utils/web3/config.dart';
import 'package:projectx/utils/web3/node_data_feed.dart';
import 'package:projectx/utils/web3/router_data_feed.dart';
import 'package:projectx/utils/web3/token_data_feed.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class Web3Api {

  late String _rpcUrl;
  late TokenDataFeed _tokenDataFeed;
  late RouterDataFeed _routerDataFeed;
  late NodeDataFeed _nodeDataFeed;
  late ChainLinkDataFeed _chainLinkDataFeed;

  Future<EtherAmount> getAVAXBalanceOf({required EthereumAddress address}) async {
    http.Client httpClient = http.Client();
    Web3Client web3Client = Web3Client(_rpcUrl, httpClient);
    return await web3Client.getBalance(address);
  }

  Future<EtherAmount> getTokenBalanceOf({required EthereumAddress address}) async {
    return EtherAmount.inWei(await _tokenDataFeed.balanceOf(address: address.hex));
  }

  Future<double> getTokenPriceInAVAX() async {
    List<EthereumAddress> path = [
      _tokenDataFeed.tokenContractAddress,
      EthereumAddress.fromHex(Web3Config.defWAVAXAddress)
    ];
    List<BigInt> result = await _routerDataFeed.getAmountsOut(BigInt.from(10).pow(18), path);
    return result[1] / BigInt.from(10).pow(18);
  }

  Future<bool> allowance({required EthereumAddress owner}) async {
    final allowance = await _tokenDataFeed.allowance(owner: owner, spender: _tokenDataFeed.tokenContractAddress);
    if (allowance == BigInt.zero) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> approve({required EthereumAddress owner, required Credentials credentials}) async {
    if (await allowance(owner: owner)) return true;
    try {
      final approved = await _tokenDataFeed.approve(credentials: credentials, spender: _tokenDataFeed.tokenContractAddress, amount: BigInt.from(1000000000000000000));
      if (approved.startsWith('0x')) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String?> swapExactAVAXForTokens({
    required BigInt amountOutMin,
    required List<EthereumAddress> path,
    required EthereumAddress to,
    required BigInt deadline,
    required EthPrivateKey credentials, Transaction? transaction}) async {
    return await _routerDataFeed.swapExactAVAXForTokens(amountOutMin: amountOutMin, path: path, to: to, deadline: deadline, credentials: credentials, transaction: transaction);
  }

  Future<String> swapExactTokenForAVAX({
    required BigInt amountIn,
    required BigInt amountOutMin,
    required List<EthereumAddress> path,
    required EthereumAddress to,
    required BigInt deadline,
    required EthPrivateKey credentials, Transaction? transaction}) async {
    return await _routerDataFeed.swapExactTokenForAVAX(amountIn: amountIn, amountOutMin: amountOutMin, path: path, to: to, deadline: deadline, credentials: credentials, transaction: transaction);
  }

  Future<bool> isNodeOwner({required EthereumAddress address}) async {
    return await _nodeDataFeed.isNodeOwner(address: address);
  }

  Future<String> createNodes({required EthereumAddress address, required int amount, required Credentials credentials}) async {
    return await _nodeDataFeed.createNodes(address: address, amount: amount, credentials: credentials);
  }

  Future<String> createNodesWithTokens({required Credentials credentials, required BigInt numberOfNodes}) async {
    return await _tokenDataFeed.createNodeWithTokens(credentials: credentials, numberOfNodes: numberOfNodes);
  }

  Future<List<Node>> getNodesRewardAvailable({
    required EthereumAddress address,
    required List<Node> listNode,
  }) async {
    List<Node> listNodes = [];
    final result = await _nodeDataFeed.getNodesRewardAvailable(address: address);
    final listRewards = result.split('#');
    int cont = 0;
    for (var element in listRewards) {
      Node node = Node(
        id: cont < listNode.length ? listNode[cont].id : 1,
        createdAt: cont < listNode.length ? listNode[cont].createdAt : '',
        updatedAt: cont < listNode.length ? listNode[cont].updatedAt : '',
        deletedAt: cont < listNode.length ? listNode[cont].deletedAt : '',
        walletAddress: cont < listNode.length ? listNode[cont].walletAddress : address.hex,
        dateCreated: cont < listNode.length ? listNode[cont].dateCreated : 0,
        rpcUrl: cont < listNode.length ? listNode[cont].rpcUrl : PxStrings.rpcIsEmpty,
        wssUrl: cont < listNode.length ? listNode[cont].wssUrl : '',
        maintenancefeeLastpaid: cont < listNode.length ? listNode[cont].maintenancefeeLastpaid : 0,
        network: cont < listNode.length ? listNode[cont].network : '',
        location: cont < listNode.length ? listNode[cont].location : '',
        name: Web3Config.namesNodes[cont],
        status: 'READY',
        valueInitials: element,
      );
      listNodes.add(node);
      cont++;
    }
    return listNodes;
  }

  Future<BigInt> getRewardAmountOf({required EthereumAddress address}) async {
    return await _nodeDataFeed.getRewardAmountOf(address: address);
  }

  Future<BigInt> getLatestRoundData() async {
    try {
      return await _chainLinkDataFeed.latestRoundData();
    } catch (e) {
      return BigInt.zero;
    }
  }

  static final Web3Api _instance = Web3Api._internal();
  factory Web3Api({
    String rpcUrl = Web3Config.defRPCUrl,
    String tokenContractAddress = Web3Config.defTokenContractAddress,
    String routerContractAddress = Web3Config.defRouterContractAddress,
    String nodeRewardsManagerContractAddress = Web3Config.defNodeRewardsContractAddress,
    String chainLinkContractAddress = Web3Config.defAVAXUSDFeed
  }) {
    _instance._rpcUrl = rpcUrl;
    _instance._tokenDataFeed = TokenDataFeed(strRpcUrl: rpcUrl, strTokenContractAddress: tokenContractAddress);
    _instance._routerDataFeed = RouterDataFeed(strRpcUrl: rpcUrl, strRouterContractAddress: routerContractAddress);
    _instance._nodeDataFeed = NodeDataFeed(strRpcUrl: rpcUrl, strNodeRewardsContractAddress: nodeRewardsManagerContractAddress);
    _instance._chainLinkDataFeed = ChainLinkDataFeed(strRpcUrl: rpcUrl, strChainLinkContractAddress: chainLinkContractAddress);
    return _instance;
  }
  Web3Api._internal();
}