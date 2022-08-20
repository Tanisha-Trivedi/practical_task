import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/models/homepage_list_model.dart';
import 'package:practical_task/resources/image_resources.dart';

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
            body: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: CachedNetworkImage(
                              fit: BoxFit.contain,
                              imageUrl: homePageListResponse
                                  .rows[index].imageHref
                                  .toString(),
                              placeholder: (context, url) => Image.asset(
                                ImageResources.placeholderImage,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                ImageResources.placeholderImage,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  homePageListResponse.rows[index].title
                                      .toString(),
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Text(
                                  homePageListResponse.rows[index].description
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                );
              },
              itemCount: homePageListResponse.rows.length,
            ),
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
