import 'package:flutter/material.dart';
import 'package:projectx/config/assets.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/config/styles.dart';
import 'package:projectx/data/models/node.dart';
import 'package:web3dart/web3dart.dart';

const Widget spaceBetween = SizedBox(
  height: 15,
);

class NodeDetailScreen extends StatelessWidget {
  final Node node;
  const NodeDetailScreen({Key? key, required this.node}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('${PxStrings.nodeDetails}${node.name}'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kBackgroundHomeImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              width: size.width * 0.5,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        PxStrings.name,
                        style: textStyleFontWeight.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(node.name),
                    ],
                  ),
                  spaceBetween,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PxStrings.rpcDetail,
                        style: textStyleFontWeight.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: SelectableText(
                          node.rpcUrl == PxStrings.rpcIsEmpty
                              ? PxStrings.rpcIsEmpty
                              : PxStrings.rpcUrl + node.rpcUrl,
                          textAlign: TextAlign.center,
                          style: textStyleColor.copyWith(
                            color: kBlueLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  spaceBetween,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        PxStrings.valueDetail,
                        style: textStyleFontWeight.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                          '${EtherAmount.inWei(BigInt.parse(node.valueInitials)).getInEther}  ${PxStrings.pxt2}'),
                    ],
                  ),
                  spaceBetween,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        PxStrings.statusDetail,
                        style: textStyleFontWeight.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(node.status),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
