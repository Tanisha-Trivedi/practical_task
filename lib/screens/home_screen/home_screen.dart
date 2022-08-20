import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/models/homepage_list_model.dart';

import '../../blocs/homepage_bloc/homepage_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomePageListResponse homePageListResponse;
  List<HomePageListRow> list = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (BuildContext context, state) {
        if (state is HomePageFailure) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          );
        }
        if (state is HomePageSuccess) {
          homePageListResponse = state.homePageListResponse;
          list = homePageListResponse.rows;
          return Scaffold(
            appBar: AppBar(
              title: Text(homePageListResponse.title.toString()),
            ),
            body: Placeholder(),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
