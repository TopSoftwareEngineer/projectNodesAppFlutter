import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:projectx/api/api.dart';
import 'package:projectx/data/models/node.dart';
import 'package:projectx/utils/web3/config.dart';
import 'package:projectx/utils/web3/web3_api.dart';
import 'package:web3dart/web3dart.dart';

class WalletAccount {
  late String _privateKey;
  late EthereumAddress _address;
  late double _balanceAVAX, _balancePXT2;
  late String _title, _token;
  late Web3Api _web3Api;
  late List<Node> _rewardAvailableNodeList;
  late BigInt _rewardAmount;

  WalletAccount({required String privateKey, String? title = "", String? token = ""}) {
    _privateKey = privateKey;
    _title = title ?? "";
    _token = token ?? "";
    _web3Api = Web3Api();
    _rewardAvailableNodeList = [];
    _rewardAmount = BigInt.zero;
  }

  Future<void> load() async {
    await loadBalances();
    await loadNodes();
  }

  Future<void> loadBalances() async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(_privateKey);
    _address = credentials.address;
    _balanceAVAX = (await _web3Api.getAVAXBalanceOf(address: _address)).getValueInUnit(EtherUnit.ether);
    _balancePXT2 = (await _web3Api.getTokenBalanceOf(address: _address)).getValueInUnit(EtherUnit.ether);
  }

  Future<void> loadNodes() async {
    bool isNodeOwner = await _web3Api.isNodeOwner(address: _address);
    if (isNodeOwner) {
      List<dynamic> listNodesSaved = await Api.getListNodes();
      List<Node> listNodes = listNodesSaved.map<Node>((value) => Node.fromMap(value)).toList();
      _rewardAvailableNodeList = await _web3Api.getNodesRewardAvailable(address: _address, listNode: listNodes);
      _rewardAmount = await _web3Api.getRewardAmountOf(address: _address);
    }
  }

  Future<bool> allowance() async {
    return await _web3Api.allowance(owner: _address);
  }

  Future<bool> approve() async {
    return await _web3Api.approve(owner: _address, credentials: EthPrivateKey.fromHex(_privateKey));
  }

  Future<String> sendAVAX({required double amount, required String to}) async {
    const String url = "https://api.avax-test.network/ext/bc/C/rpc";
    final client = Web3Client(url, Client());
    final credentials = EthPrivateKey.fromHex(_privateKey);
    return await client.sendTransaction(
        credentials,
        Transaction(
          from: _address,
          to: EthereumAddress.fromHex(to),
          value: EtherAmount.fromUnitAndValue(EtherUnit.gwei, BigInt.from(amount * pow(10, 9).toInt())),
        ),
        chainId: 43113);
  }

  Future<String?> swapAVAXForTokens({required double amount}) async {
    List<EthereumAddress> path = [EthereumAddress.fromHex(Web3Config.defWAVAXAddress), EthereumAddress.fromHex(Web3Config.defTokenContractAddress)];
    int deadline = (DateTime.now().millisecondsSinceEpoch / 1000).floor() + 60 * 30;
    EtherAmount swapAmount = EtherAmount.fromUnitAndValue(EtherUnit.gwei, BigInt.from(amount * pow(10, 9).toInt()));
    Transaction transaction = Transaction(
      from: _address,
      value: swapAmount,
    );
    try {
      return await _web3Api.swapExactAVAXForTokens(amountOutMin: swapAmount.getValueInUnitBI(EtherUnit.gwei), path: path, to: _address, deadline: BigInt.from(deadline), credentials: EthPrivateKey.fromHex(_privateKey), transaction: transaction);
    } catch (e) {
      print("================ exception ================");
      print(e.toString());
      return null;
    }
  }

  Future<String?> swapTokenForAVAX({required double amount}) async {
    List<EthereumAddress> path = [EthereumAddress.fromHex(Web3Config.defTokenContractAddress), EthereumAddress.fromHex(Web3Config.defWAVAXAddress)];
    int deadline = (DateTime.now().millisecondsSinceEpoch / 1000).floor() + 60 * 30;
    EtherAmount swapAmount = EtherAmount.fromUnitAndValue(EtherUnit.gwei, BigInt.from(amount * pow(10, 9).toInt()));
    Transaction transaction = Transaction(
      from: _address,
      value: swapAmount,
    );
    try {
      return await _web3Api.swapExactTokenForAVAX(amountIn: swapAmount.getInEther, amountOutMin: swapAmount.getValueInUnitBI(EtherUnit.gwei), path: path, to: _address, deadline: BigInt.from(deadline), credentials: EthPrivateKey.fromHex(_privateKey), transaction: transaction);
    } catch (e) {
      print("================ exception ================");
      print(e.toString());
      return null;
    }
  }

  Future<BigInt> getLatestAVAXPriceUSDT() async {
    return _web3Api.getLatestRoundData();
  }

  Future<String> createNodes({required int amount}) async {
    return await _web3Api.createNodes(address: _address, amount: amount, credentials: EthPrivateKey.fromHex(_privateKey));
  }

  double get balancePXT2 => _balancePXT2;

  set balancePXT2(value) {
    _balancePXT2 = value;
  }

  double get balanceAVAX => _balanceAVAX;

  set balanceAVAX(double value) {
    _balanceAVAX = value;
  }

  EthereumAddress get address => _address;

  set address(EthereumAddress value) {
    _address = value;
  }

  String get privateKey => _privateKey;

  set privateKey(String value) {
    _privateKey = value;
  }

  get token => _token;

  set token(value) {
    _token = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  BigInt get rewardAmount => _rewardAmount;

  set rewardAmount(BigInt value) {
    _rewardAmount = value;
  }

  List<Node> get rewardAvailableNodeList => _rewardAvailableNodeList;

  set rewardAvailableNodeList(List<Node> value) {
    _rewardAvailableNodeList = value;
  }
}
