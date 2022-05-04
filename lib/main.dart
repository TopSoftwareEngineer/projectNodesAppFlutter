import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
<<<<<<< HEAD
import 'package:projectx/app.dart';
=======
import 'package:http/http.dart';
import 'package:projectx/ui/screens/home_navigationbar_screen.dart';
import 'package:projectx/ui/screens/login/login_screen.dart';
import 'package:projectx/utils/shared_preferences_utils.dart';
import 'package:web3dart/web3dart.dart';
import 'config/router/router.dart' as router;
import 'config/themes.dart';
import 'dart:math';
import 'package:projectx/data/repositories/web3_repository.dart';

import 'utils/chainLinkDataFeeds.dart'; //used for the random number generator
import 'utils/tokenDataFeeds.dart'; //token contract to interact with
import 'utils/routerDataFeeds.dart'; //router contract to buy and sell
import 'utils/nodeRewardsDataFeeds.dart'; //node rewards to get nodes, nodeOwner, etc
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
<<<<<<< HEAD
  runApp(const ProjectXApp());
=======
  final Web3Repository web3Repository = Web3Repository();
  //MAINNET
  //const String url = "https://api.avax-test.network/ext/bc/C/rpc";
  //TESTNET

  // Load account from private key
  final String url = "https://api.avax-test.network/ext/bc/C/rpc";

  // validar private key
  // 1. privateKey.length == 64
  // 2. comprobar que no existe, si esta repetida mostramos dialog de error diciendo que ya se ha repetido
  // 3. sí se importa bien, mostrar dialog de clave importada correctamente y avanza al menu

  // ejemplo borrar wallet
  //SharedPreferencesUtil.removeItem(privateKey);

  // -------------------------------------------------------------------------------------------------

  // -------------------------------------------------------------------------------------------------

  //print(await client.getBalance(address));
  //MAINNET
  // const String tokenContractDataFeeds =
  //     "0x9e20Af05AB5FED467dFDd5bb5752F7d5410C832e";
  // const String routerContractDataFeeds =
  //     "0x60aE616a2155Ee3d9A68541Ba4544862310933d4";
  // const String nodeRewardsContractDataFeeds =
  //     "0x05c88F67fa0711b3a76ada2B6f0A2D3a54Fc775c";
  //TESTNET
  const String tokenContractDataFeeds =
      "0x183433E3B157c2f4B7ae8B56524A3f31FD18918c";
  const String routerContractDataFeeds =
      "0x2D99ABD9008Dc933ff5c0CD271B88309593aB921";
  const String nodeRewardsContractDataFeeds =
      "0x0fE753E28292f04975f73CE7F92206B045EEC812";

  const String AVAX_USD_DataFeeds =
      "0x0A77230d17318075983913bC2145DB16C7366156";
  //final chainLinkDataFeeds = ChainLinkDataFeeds(url, AVAX_USD_DataFeeds);

  final tokenDataFeeds = TokenDataFeeds(url, tokenContractDataFeeds);
  final routerDataFeeds = RouterDataFeeds(url, routerContractDataFeeds);
  final nodeRewardsDataFeeds =
      NodeRewardsDataFeeds(url, nodeRewardsContractDataFeeds);

  const publickey = '0xb6e76628BeB7872D2ade6AE9641bb390401c18ef';
  // mostrar en número de nodes
  print(await nodeRewardsDataFeeds.getNodeNumberOf(publickey));
  print(await nodeRewardsDataFeeds.isNodeOwner(publickey));
  print(await nodeRewardsDataFeeds.totalNodesCreated());
  final isNodeOwner = await nodeRewardsDataFeeds.isNodeOwner(publickey);
  final tokenBalance = await tokenDataFeeds.balanceOf(publickey);
  print("balance");
  print(tokenBalance);
  // final allowance = await tokenDataFeeds.allowance(
  //     publickey, tokenDataFeeds.dataFeedsContractAddress);
  //if node owner sacamos las demás y mostramos
  if (isNodeOwner) {
    final nodeNumberOf = await nodeRewardsDataFeeds.getNodeNumberOf(publickey);
    final nodesRewardAvailable =
        await nodeRewardsDataFeeds.getNodesRewardAvailable(publickey);
    final rewardsAmountOf =
        await nodeRewardsDataFeeds.getRewardAmountOf(publickey);

    // Mostrar en claim
    print(await nodeRewardsDataFeeds.getRewardAmountOf(publickey));

    // valor pxt node
    print(await nodeRewardsDataFeeds.getNodesRewardAvailable(publickey));
  }
  // if (tokenBalance > BigInt.parse("10000000000000000000")) {
  //   print('pacooo');
  //   final nodeCreated =
  //       await tokenDataFeeds.createNodeWithTokens(BigInt.parse("1"));
  //   print(nodeCreated);
  // }
  //tanto para la compra como para la venta vamos a tener que calcular la
  //el precio estimado para enviarlo como el amountOutMin
  // final swap = await routerDataFeeds.swapAVAXForExactTokens(
  //     BigInt.from(1397183332),
  //     [
  //       EthereumAddress.fromHex("0xd00ae08403B9bbb9124bB305C09058E32C39A48c"),
  //       EthereumAddress.fromHex("0xca3Ca6c228F0dED829033cad58c06ebcce41fEF9")
  //     ],
  //     EthereumAddress.fromHex("0xfbAA3c716dA6378A0840754185BFf6A05a20e1C8"),
  //     BigInt.from(DateTime.now().millisecondsSinceEpoch + 300));
  // print('swap');
  // print(swap);
/*
  final swap =
      await routerDataFeeds.swapExactTokensForAVAXSupportingFeeOnTransferTokens(
          BigInt.from(500000000000),
          BigInt.from(965562832),
          [
            EthereumAddress.fromHex(
                "0x3269099573eF5532c90465D120dfaeA8ea0a039e"),
            EthereumAddress.fromHex(
                "0xd00ae08403B9bbb9124bB305C09058E32C39A48c")
          ],
          EthereumAddress.fromHex("0x76778e046D73a5B8ce3d03749cE6B1b3D6a12E36"),
          BigInt.from(DateTime.now().millisecondsSinceEpoch + 300));

  print("sell");
  print(swap);
  */

  //final latestRoundData = await chainLinkDataFeeds.latestRoundData();
  //siempre se va a consultar el total de nodos creados
  final totalNodesCreated = await nodeRewardsDataFeeds.totalNodesCreated();
  final tokenPriceInAvax = await web3Repository.getTokenPriceInAvax();
  final tokenInEth = EtherAmount.inWei(tokenPriceInAvax).getInEther;

  final avaxPriceInUsdc = await web3Repository.getAVAXPriceInUSDC();
  final avaxInEth = EtherAmount.inWei(avaxPriceInUsdc).getInEther;
  final priceAsInt = (avaxInEth * tokenInEth).toInt();
  print("token");
  print(priceAsInt / (1 + 0.5));
  print("division");
  print(1);
  print("totalNodesCreated");
  print(totalNodesCreated);

  final pxtBalance = await tokenDataFeeds
      .balanceOf("0x31F1577793eBB123795b9afEeBda4BA01ACA2Bc9");

  print("pxtBalance");
  print(pxtBalance);

  /*
  final isNodeOwner = await nodeRewardsDataFeeds.isNodeOwner(publickey);
  final tokenBalance = await tokenDataFeeds.balanceOf(publickey);
  final allowance = await tokenDataFeeds.allowance(
      publickey, tokenDataFeeds.dataFeedsContractAddress);
  //if node owner sacamos las demás y mostramos
  if (isNodeOwner) {
    final nodeNumberOf = await nodeRewardsDataFeeds.getNodeNumberOf(publickey);
    final nodesRewardAvailable =
        await nodeRewardsDataFeeds.getNodesRewardAvailable(publickey);
    final rewardsAmountOf =
        await nodeRewardsDataFeeds.getRewardAmountOf(publickey);

    print("number of nodes");
    print(nodeNumberOf);
    print("amount of rewards available in wei");
    print(rewardsAmountOf);

    if (rewardsAmountOf > BigInt.from(0)) {
      //solo llamar al hacer click en el claim button (claim button dead xD) y si hay
      //reward disponible
      final cashoutAll = await tokenDataFeeds.cashoutAll();
    }
    //si no hay allowance no se puede crear nodos y hay que mostrar el bottón de
    // approve y hacer approve de la cantidad máxima
    var approve = 'false';
    /*
    if (allowance == BigInt.from(0)) {
      approve = await tokenDataFeeds.approve(
          tokenDataFeeds.dataFeedsContractAddress,
          BigInt.from(999999999999999999));
    }
    */
    //una vez que hay allowance y que el token balance es mayor de 10 (precio
    //para crear un nodo) se permite crear nodos y se muestra el botón
    if (approve != 'false' && tokenBalance > BigInt.from(10)) {
      //cantidad recibida es la cantidad de nodos a crear
      final createNode =
          await tokenDataFeeds.createNodeWithTokens(BigInt.from(2));
    }
  }
*/

  /// Init preferences
  await SharedPreferencesUtil.init();

  // traer llaves para validar si se ingresa al home la primera vez
  final privateKey = await SharedPreferencesUtil.getString('privateKey') ?? '';

  runApp(MyApp(
    privateKey: privateKey,
  ));
  FlutterNativeSplash.remove();
}

Future<Credentials> createNewWallet() async {
  var rng = Random.secure();
  Credentials credentials = EthPrivateKey.createRandom(rng);
  var address = await credentials.extractAddress();
  print(credentials);
  print(address.hex);

  // store pk on storage

  return credentials;
}

Future<void> sendTx() async {
  const String url = "https://api.avax-test.network/ext/bc/C/rpc";
  const String privateKey =
      'a2fd51b96dc55aeb14b30d55a6b3121c7b9c599500c1beb92a389c3377adc86e';
  final client = Web3Client(url, Client());
  final credentials = EthPrivateKey.fromHex(privateKey);

  await client.sendTransaction(
    credentials,
    Transaction(
      to: EthereumAddress.fromHex('0xC91...3706'),
      gasPrice: EtherAmount.inWei(BigInt.two),
      maxGas: 200000,
      value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 1),
    ),
  );
}

Future<String> importAccountFromPrivateKey(pk) async {
  Credentials credentials = EthPrivateKey.fromHex(pk);
  var address = await credentials.extractAddress();
  print(address.hex);
  return address.hex;
}

class MyApp extends StatelessWidget {
  final String privateKey;
  const MyApp({Key? key, required this.privateKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProjectX',
      theme: PxAppTheme.initialTheme(),
      onGenerateRoute: router.generateRoute,
      home: privateKey.isEmpty
          ? const InitialScreen()
          : const HomeBottomNavigationBarScreen(),
    );
  }
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
}
