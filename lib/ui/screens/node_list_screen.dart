import 'package:flutter/material.dart';
import 'package:projectx/config/strings.dart';
import 'package:projectx/data/models/node.dart';
import 'package:projectx/ui/widgets/list_tile_node_widget.dart';

import '../../config/assets.dart';

class NodeListScreen extends StatelessWidget {
  final List<Node> listNode;
  final String cantNodes;
  const NodeListScreen({
    Key? key,
    required this.listNode,
    required this.cantNodes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(cantNodes.isNotEmpty
            ? '$cantNodes ${int.parse(cantNodes) >= 2 ? PxStrings.nodes : PxStrings.node}'
            : ''),
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
          child: ListView.builder(
            itemCount: listNode.length,
            itemBuilder: (context, index) => ListTileNode(
              node: listNode[index],
            ),
          ),
        ),
      ),
    );
  }
}
