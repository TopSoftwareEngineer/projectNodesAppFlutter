import 'package:http/http.dart';
import 'package:projectx/Router.g.dart';
import 'package:projectx/utils/web3/config.dart';
import 'package:web3dart/web3dart.dart';

class RouterDataFeed {
  late String _rpcUrl;
  late Router _routerInstance;

  RouterDataFeed({String strRpcUrl = Web3Config.defRPCUrl, String strRouterContractAddress = Web3Config.defRouterContractAddress, int chainId = Web3Config.defChainId}) {
    _rpcUrl = strRpcUrl;
    Web3Client web3Client = Web3Client(strRpcUrl, Client());
    _routerInstance = Router(address: EthereumAddress.fromHex(strRouterContractAddress), client: web3Client, chainId: chainId);
  }

  Future<List<BigInt>> getAmountsOut(BigInt amountIn, List<EthereumAddress> path) async {
    return await _routerInstance.getAmountsOut(amountIn, path);
  }

  Future<List<BigInt>> getAmountsIn(BigInt amountIn, List<EthereumAddress> path) async {
    return await _routerInstance.getAmountsIn(amountIn, path);
  }

  Future<String> swapExactAVAXForTokens({
    required BigInt amountOutMin,
    required List<EthereumAddress> path,
    required EthereumAddress to,
    required BigInt deadline,
    required EthPrivateKey credentials, Transaction? transaction}) async {
    return await routerInstance.swapExactAVAXForTokens(amountOutMin, path, to, deadline, credentials: credentials, transaction: transaction);
  }

  Future<String> swapExactTokenForAVAX({
    required BigInt amountIn,
    required BigInt amountOutMin,
    required List<EthereumAddress> path,
    required EthereumAddress to,
    required BigInt deadline,
    required EthPrivateKey credentials, Transaction? transaction}) async {
    return await routerInstance.swapExactTokensForAVAX(amountIn, amountOutMin, path, to, deadline, credentials: credentials, transaction: transaction);
  }

  Router get routerInstance => _routerInstance;
}
