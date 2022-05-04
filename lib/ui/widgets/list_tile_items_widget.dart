import 'package:flutter/material.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/config/styles.dart';

class ListTileItems extends StatelessWidget {
  final String title;
  final String value;
  const ListTileItems({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: kBlack),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: textStyleFontWeight.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: textStyleFontWeight.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
            ),
          ],
        ),
      ),
    );
  }
}
