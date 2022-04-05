import 'package:projectx/config/strings.dart';
import 'package:projectx/data/models/node.dart';
import 'package:projectx/data/models/response.dart';
import 'package:projectx/utils/chainLinkDataFeeds.dart';
import 'package:projectx/utils/nodeRewardsDataFeeds.dart';
import 'package:projectx/utils/tokenDataFeeds.dart';
import 'package:projectx/utils/routerDataFeeds.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class Web3Repository {
  static const String url = "https://api.avax-test.network/ext/bc/C/rpc";
  static const String tokenContractDataFeeds =
      "0x183433E3B157c2f4B7ae8B56524A3f31FD18918c";
  static const String routerContractDataFeeds =
      "0x2D99ABD9008Dc933ff5c0CD271B88309593aB921";
  static const String nodeRewardsContractDataFeeds =
      "0x0fE753E28292f04975f73CE7F92206B045EEC812";
  //mainnet
  //static const String AVAX_USD_DataFeeds = "0x0A77230d17318075983913bC2145DB16C7366156";
  static const String AVAX_USD_DataFeeds =
      "0x5498BB86BC934c8D34FDA08E81D444153d0D06aD";
  static const List<String> namesNodes = [
    'Footprint',
    'Saturn',
    'Dark Horse',
    'Keyhole',
    'Cone',
    'Hubble\'s Variable',
    'Barnard\'s Bubble',
    'Eagle',
    'Glowing Eye',
    'Spirograph',
    'Double Helix',
    'Oyster',
    'Horsehead',
    'California',
    'Ghost Head',
    'Vela Junior',
    'Heart',
    'Soccer Ball',
    'Iris',
    'Stingray',
    'Spaghetti',
    'Red Spider',
    'Statue of Liberty',
    'Bug',
    'Cat\'s Eye'
        'Soap Bubble',
    'Trifid',
    'Twin Jet',
    'Cocoon',
    'Seagull',
    'Shark',
    'Jellyfish',
    'Ant',
    'Orion',
    'Running Man',
    'Flame',
    'Water lily',
    'Crescent',
    'Dragonfish',
    'Eye of Sauron',
    'Owl',
    'Phantom Streak',
    'Helix',
    'War and Peace',
    'Spare-Tyre',
    'Dark Doodad',
    'Bow-Tie',
    'Bubble',
    'Frosty Leo',
    'Box',
    'Skull',
    'Dragon\'s Head',
    'Cleopatra\'s Eye',
    'Dumbbell',
    'Monkey Head',
    'Fried Egg',
    'Medusa',
    'Turtle',
    'Rosette',
    'Engraved Hourglass',
    'Blue Snowball',
    'Butterfly',
    'Little Gem',
    'Thor\'s Helmet',
    'Snake',
    'Kepler\'s Supernova',
    'Western Veil',
    'Retina',
    'Running Chicken',
    'Lagoon',
    'Eskimo',
    'Fish Head',
    'Pelican',
    'Pistol',
    'Blue Racquetball',
    'Tarantula',
    'Omega',
    'Robin\'s Egg',
    'Blue Flash',
    'Lemon Slice',
    'Crab',
    'Southern Crab',
    'Little Ghost',
    'Dolphin',
    'North America',
    'Flaming Star',
    'Boomerang',
    'Manatee',
    'Bean',
    'Elephant\'s Trunk',
    'Egg',
    'Cat\'s Paw',
    'Pacman',
    'Coalsack',
    'Ghost of Jupiter',
    'Cotton Candy',
    'Southern Owl',
    'Corona Australis',
    'Fleming',
    'Witch Head',
  ];
  final nodeRewardsDataFeeds =
      NodeRewardsDataFeeds(url, nodeRewardsContractDataFeeds);
  final tokenDataFeeds = TokenDataFeeds(url, tokenContractDataFeeds);

  Future<BigInt> getLatestRoundData() async {
    try {
      final chainLinkDataFeeds = ChainLinkDataFeeds(url, AVAX_USD_DataFeeds);
      final latestRoundData = await chainLinkDataFeeds.latestRoundData();
      return latestRoundData;
    } catch (e) {
      return BigInt.from(0);
    }
  }

  Future<EthPrivateKey> getCredentialsByPrivateKey(
      {required String privateKey}) async {
    final credentials = EthPrivateKey.fromHex(privateKey);
    return credentials;
  }

  Future<BigInt> getNodeNumberOf({required String publicKey}) async {
    final result = await nodeRewardsDataFeeds.getNodeNumberOf(publicKey);
    return result;
  }

  Future<Response> createNodeWithTokens({
    required BigInt numberOfNodes,
    required String publickey,
  }) async {
    try {
      final tokenDataFeeds = TokenDataFeeds(url, tokenContractDataFeeds);
      final ethereumAddress = EthereumAddress.fromHex(publickey);
      final tokenBalance = await tokenDataFeeds.balanceOf(publickey);
      final allowance = await tokenDataFeeds.allowance(
          ethereumAddress, tokenDataFeeds.dataFeedsContractAddress);
      var approve = 'false';
      if (allowance == BigInt.from(0)) {
        approve = await tokenDataFeeds.approve(
            tokenDataFeeds.dataFeedsContractAddress,
            BigInt.from(1000000000000000000));
      } else if (allowance > BigInt.from(0)) {
        approve = 'true';
      }
      if (approve != 'false' && tokenBalance > BigInt.from(10)) {
        final result = await tokenDataFeeds.createNodeWithTokens(numberOfNodes);
        print("result_tx");
        print("https://testnet.snowtrace.io/tx/" + result);
        return Response(
          status: true,
          message: PxStrings.responseNodeCreatedOk,
          tx: 'https://testnet.snowtrace.io/tx/$result',
        );
      } else {
        throw Exception('tokenBalance');
      }
    } catch (e) {
      String message = PxStrings.errorClaimProcess;
      final listExpectionText = e.toString().split(':');
      String exception = listExpectionText[1].replaceAll(' ', '');
      if (exception == 'allowance') {
        message = PxStrings.errorAllowance;
      } else if (exception == 'tokenBalance') {
        message = PxStrings.errorTokenBalance;
      } else {
        message = PxStrings.errorClaimProcess;
      }
      return Response(
        status: false,
        message: message,
      );
    }
  }

  Future<EtherAmount> balanceOf({required String publicKey}) async {
    final tokenDataFeeds = TokenDataFeeds(url, tokenContractDataFeeds);
    final result = await tokenDataFeeds.balanceOf(publicKey);
    return EtherAmount.fromUnitAndValue(EtherUnit.ether, result);
  }

  Future<BigInt> getRewardAmountOf({required String publicKey}) async {
    final result = await nodeRewardsDataFeeds.getRewardAmountOf(publicKey);
    return result;
  }

  Future<BigInt> getTokenPriceInAvax() async {
    final path =
        await getPathTokenForAvax(tokenAddress: tokenContractDataFeeds);
    final routerDataFeeds = RouterDataFeeds(url, routerContractDataFeeds);
    final result = await routerDataFeeds.getAmountsOut(
        BigInt.from(1000000000000000000), path);
    return result[1];
  }

  Future<List<EthereumAddress>> getPathTokenForAvax(
      {required String tokenAddress}) async {
    return [
      EthereumAddress.fromHex(tokenAddress),
      EthereumAddress.fromHex("0xd00ae08403B9bbb9124bB305C09058E32C39A48c")
    ];
  }

  Future<BigInt> getAVAXPriceInUSDC() async {
    final path = await getPathAvaxForTokens(
        tokenAddress: "0xFe143522938e253e5Feef14DB0732e9d96221D72");
    final routerDataFeeds = RouterDataFeeds(url, routerContractDataFeeds);
    final result = await routerDataFeeds.getAmountsOut(
        BigInt.from(1000000000000000000), path);
    return result[1];
  }

  Future<String> getNodesLastClaimTime(walletAddress) async {
    final result =
        await nodeRewardsDataFeeds.getNodesLastClaimTime(walletAddress);
    return result;
  }

  Future<BigInt> getClaimInterval(walletAddress) async {
    final result = await nodeRewardsDataFeeds.getClaimInterval(walletAddress);
    return result;
  }

  Future<List<EthereumAddress>> getPathAvaxForTokens(
      {required String tokenAddress}) async {
    return [
      EthereumAddress.fromHex("0xd00ae08403B9bbb9124bB305C09058E32C39A48c"),
      EthereumAddress.fromHex(tokenAddress)
    ];
  }

  Future<bool> isNodeOwner(String publicKey) =>
      nodeRewardsDataFeeds.isNodeOwner(publicKey);

  Future<Response> cashoutAll({
    required String publicKey,
  }) async {
    try {
      final isNodeOwner = await nodeRewardsDataFeeds.isNodeOwner(publicKey);
      if (isNodeOwner) {
        final rewardsAmountOf =
            await nodeRewardsDataFeeds.getRewardAmountOf(publicKey);
        if (rewardsAmountOf > BigInt.from(0)) {
          final cashoutAll = await tokenDataFeeds.cashoutAll();
          print("result_tx");
          print("https://testnet.snowtrace.io/tx/" + cashoutAll);
          return Response(
            status: true,
            message: PxStrings.claimProcessSuccessful,
            tx: 'https://testnet.snowtrace.io/tx/$cashoutAll',
          );
        } else {
          throw Exception('isInsufficient');
        }
      } else {
        throw Exception('isNoOwner');
      }
    } catch (e) {
      String message = PxStrings.errorClaimProcess;
      final listExpectionText = e.toString().split(':');
      String exception = listExpectionText[1].replaceAll(' ', '');
      if (exception == 'isNoOwner') {
        message = PxStrings.errorIsNotNodeOwner;
      } else if (exception == 'isInsufficient') {
        message = PxStrings.errorIsInsufficient;
      } else {
        message = PxStrings.errorClaimProcess;
      }
      return Response(
        status: false,
        message: message,
      );
    }
  }

  Future<List<Node>> getNodesRewardAvailable({
    required String publicKey,
    required List<Node> listNode,
  }) async {
    List<Node> listNodes = [];
    final nodeRewardsDataFeeds =
        NodeRewardsDataFeeds(url, nodeRewardsContractDataFeeds);
    final result =
        await nodeRewardsDataFeeds.getNodesRewardAvailable(publicKey);
    final listRewards = result.split('#');
    int cont = 0;
    for (var element in listRewards) {
      Node node = Node(
        id: cont < listNode.length ? listNode[cont].id : 1,
        createdAt: cont < listNode.length ? listNode[cont].createdAt : '',
        updatedAt: cont < listNode.length ? listNode[cont].updatedAt : '',
        deletedAt: cont < listNode.length ? listNode[cont].deletedAt : '',
        walletAddress:
            cont < listNode.length ? listNode[cont].walletAddress : publicKey,
        dateCreated: cont < listNode.length ? listNode[cont].dateCreated : 0,
        rpcUrl: cont < listNode.length
            ? listNode[cont].rpcUrl
            : PxStrings.rpcIsEmpty,
        wssUrl: cont < listNode.length ? listNode[cont].wssUrl : '',
        maintenancefeeLastpaid:
            cont < listNode.length ? listNode[cont].maintenancefeeLastpaid : 0,
        network: cont < listNode.length ? listNode[cont].network : '',
        location: cont < listNode.length ? listNode[cont].location : '',
        name: namesNodes[cont],
        status: 'READY',
        valueInitials: element,
      );
      listNodes.add(node);
      cont++;
    }
    return listNodes;
  }
}
