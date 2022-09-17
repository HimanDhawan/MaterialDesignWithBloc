import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttersample/Features/MyCreatedList/Model/CreatedListModel.dart';
import 'package:fluttersample/Features/MyCreatedList/ui/CreatedListCell.dart';

class MyCreatedList extends StatelessWidget {
  const MyCreatedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return CreatedListCell();
          },
          separatorBuilder: (context, index) {
            return Divider(height: 20);
          },
          itemCount: 2),
    );
  }
}
