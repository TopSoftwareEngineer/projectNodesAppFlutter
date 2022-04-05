import 'package:bloc/bloc.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/data/models/node.dart';
import 'package:projectx/data/models/response.dart';
import 'package:projectx/data/repositories/node_repository.dart';
import 'package:projectx/data/repositories/web3_repository.dart';
import 'package:projectx/utils/shared_preferences_utils.dart';
import 'package:web3dart/web3dart.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final Web3Repository web3Repository = Web3Repository();
  final NodeRepository nodeRepository = NodeRepository();

  void getLatestRoundData() async {
    final latestRoundData = await web3Repository.getLatestRoundData();
    emit(LoadedlatestRoundData(latestRoundData));
  }

  void getInitialData() async {
    final privateKey = SharedPreferencesUtil.getString('privateKey');
    final publicKey = SharedPreferencesUtil.getString(privateKey!)!;
    final token = SharedPreferencesUtil.getString('token');
    final listNodes1 = await nodeRepository.getListNodes(token: token!);

    final isNodeOwner = await web3Repository.isNodeOwner(publicKey);
    late List<Node> listNodes;
    late BigInt nodeNumberOf;
    late EtherAmount balanceOf;
    final BigInt rewardAmountOf;

    if (isNodeOwner) {
      nodeNumberOf = await web3Repository.getNodeNumberOf(publicKey: publicKey);
      balanceOf = await web3Repository.balanceOf(publicKey: publicKey);
      rewardAmountOf =
          await web3Repository.getRewardAmountOf(publicKey: publicKey);
      listNodes = await web3Repository.getNodesRewardAvailable(
        publicKey: publicKey,
        listNode: listNodes1,
      );
    } else {
      nodeNumberOf = BigInt.zero;
      balanceOf = EtherAmount.zero();
      rewardAmountOf = BigInt.zero;
      listNodes = [];
    }

    emit(
      LoadedInitialData(
        publicKey: publicKey,
        listNodes: listNodes,
        nodeNumberOf: nodeNumberOf,
        balanceOf: balanceOf,
        rewardAmountOf: rewardAmountOf,
      ),
    );
  }

  void cashoutAll() async {
    final privateKey = SharedPreferencesUtil.getString('privateKey');
    final publicKey = SharedPreferencesUtil.getString(privateKey!);
    final response = await web3Repository.cashoutAll(publicKey: publicKey!);
    final seconds = await web3Repository.getClaimInterval(publicKey);

    emit(LoadedCashoutAll(
      response: response,
      seconds: seconds.toInt(),
    ));
  }

  void createNodeWithTokens({
    required BigInt numberOfNodes,
  }) async {
    final privateKey = SharedPreferencesUtil.getString('privateKey');
    final publicKey = SharedPreferencesUtil.getString(privateKey!);
    final token = SharedPreferencesUtil.getString('token');
    var response = await web3Repository.createNodeWithTokens(
      publickey: publicKey!,
      numberOfNodes: numberOfNodes,
    );
    if (response.status) {
      final responseApi = await nodeRepository.createNodes(
        token: token!,
        amount: numberOfNodes.toInt(),
      );
      response = Response(
        status: responseApi.status,
        message: responseApi.message,
        tx: response.tx,
      );
    }
    emit(
      LoadedCreateNodeWithTokens(
        response: response,
      ),
    );
  }
}
