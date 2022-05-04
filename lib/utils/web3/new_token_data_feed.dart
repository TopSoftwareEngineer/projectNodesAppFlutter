import 'package:http/http.dart';
import 'package:projectx/contract/token.g.dart';
import 'package:projectx/utils/web3/config.dart';
import 'package:web3dart/web3dart.dart';

class NewTokenDataFeed {
  late String _rpcUrl;
  late EthereumAddress _tokenContractAddress;
  late Token _tokenInstance;

  NewTokenDataFeed({
    String strRpcUrl = Web3Config.defRPCUrl,
    String strTokenContractAddress = Web3Config.defNewTokenContractAddress,
    int chainId = Web3Config.defChainId
  }) {
    _rpcUrl = strRpcUrl;
    _tokenContractAddress = EthereumAddress.fromHex(strTokenContractAddress);
    Web3Client web3Client = Web3Client(_rpcUrl, Client());
    _tokenInstance = Token(address: _tokenContractAddress, client: web3Client, chainId: chainId);
  }

  Future<BigInt> decimals() async {
    return await _tokenInstance.decimals();
  }

  Future<BigInt> balanceOf({required String address}) async {
    return await _tokenInstance.balanceOf(EthereumAddress.fromHex(address));
  }

  Future<BigInt> allowance({required EthereumAddress owner, required EthereumAddress spender}) async {
    return await _tokenInstance.allowance(owner, spender);
  }

  Future<String> approve({required Credentials credentials, required EthereumAddress spender, required BigInt amount}) async {
    return await _tokenInstance.approve(spender, amount, credentials: credentials);
  }

  // Future<String> cashOutAll({required String privateKey}) async {
  //   EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  //   return await _tokenInstance.cashoutAll(credentials: credentials);
  // }
  //
  // Future<String> createNodeWithTokens({required Credentials credentials, required BigInt numberOfNodes}) async {
  //   return await _tokenInstance.createNodeWithTokens(numberOfNodes, credentials: credentials);
  // }

  EthereumAddress get tokenContractAddress => _tokenContractAddress;
}