import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersample/Features/MyCreatedList/Model/CreatedListModel.dart';
import 'package:fluttersample/Features/MyCreatedList/bloc/CreatedListBloc.dart';
import 'package:fluttersample/Features/MyCreatedList/bloc/Repository/CreatedListRepository.dart';
import 'package:fluttersample/Features/MyCreatedList/bloc/State/CreatedListState.dart';
import 'package:fluttersample/Features/MyCreatedList/ui/CreatedListCell.dart';

import '../bloc/Event/CreatedListEvent.dart';

class MyCreateList extends StatefulWidget {
  const MyCreateList({Key? key}) : super(key: key);

  @override
  State<MyCreateList> createState() => _MyCreateListState();
}

class _MyCreateListState extends State<MyCreateList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateListBloc, CreatedListState>(
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        if (state.status == CreateMovieListStatus.initial) {
          print("initial state called CreateMovieListStatus");
          context.read<CreateListBloc>().add(GetCreatedListEvent());
          return Center(
            child: Text("Initial"),
          );
        } else if (state.status == CreateMovieListStatus.loading) {
          print("Loading");
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == CreateMovieListStatus.success) {
          var list = state.createdList;
          print("Emit state");
          return getListView(list);
        } else if (state.status == CreateMovieListStatus.error) {
          return Text("Error");
        } else {
          return Text("Show detail");
        }
      },
      listenWhen: (previous, current) => true,
      listener: (context, state) {
        print("Listner called $state");
      },
    );
  }

  Widget getListView(List<CreatedMovieResult> results) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return CreatedListCell(movie: results[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(height: 20);
        },
        itemCount: results.length);
  }
}
