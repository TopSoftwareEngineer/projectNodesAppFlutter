import 'package:flutter/material.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/router/router_path.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';
import 'package:projectx/data/models/node.dart';
import 'package:projectx/utils/dialogs_util.dart';
import 'package:web3dart/web3dart.dart';

class ListTileNode extends StatelessWidget {
  final Node node;
  const ListTileNode({
    Key? key,
    required this.node,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kGray,
          ),
        ),
        color: kWhite,
      ),
      child: ListTile(
        title: Text(
          node.name,
          style: textStyleFontWeight.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          node.status,
          style: textStyleFontSize.copyWith(fontSize: 12),
        ),
        trailing: SizedBox(
          width: size.width * 0.5,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  '${EtherAmount.inWei(BigInt.parse(node.valueInitials)).getInEther}  ${PxStrings.pxt2}',
                  style: textStyleFontWeight.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                flex: 3,
                child: TextButton(
                  style: buttonStylebottomless,
                  onPressed: () => DialogsUtil().rpcDialog(
                    context: context,
                    rpc: node.rpcUrl,
                  ),
                  child: Text(
                    PxStrings.rpc,
                    style: textStyleColor.copyWith(
                      color: kBlueLight,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(0),
                  onPressed: () => Navigator.of(context).pushNamed(
                    PxPathCfg.nodeDetailScreenPageRoute,
                    arguments: node,
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_right,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
