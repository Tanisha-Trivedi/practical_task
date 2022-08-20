import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_task/models/homepage_list_model.dart';
import 'package:practical_task/resources/image_resources.dart';

import '../../blocs/homepage_bloc/homepage_bloc.dart';
import '../../common_widgets/search_field.dart';
import '../../resources/string_resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomePageListResponse homePageListResponse;
  List<HomePageListRow> list = [];

  //added value notifier for local search
  ValueNotifier<List<HomePageListRow>> valueNotifier = ValueNotifier([]);
  String search = '';

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
          valueNotifier.value = homePageListResponse.rows;

          return Scaffold(
            appBar: AppBar(
              title: Text(homePageListResponse.title.toString()),
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SearchTextField(
                  text: search,
                  hintText: Strings.search,
                  onChanged: searchRow,
                ),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                    valueListenable: valueNotifier,
                    builder: (context, value, child) => Expanded(
                          flex: 1,
                          child: RefreshIndicator(
                            onRefresh: _onRefresh,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 5.0,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 70,
                                            width: 70,
                                            child: CachedNetworkImage(
                                              fit: BoxFit.contain,
                                              imageUrl: valueNotifier
                                                  .value[index].imageHref
                                                  .toString(),
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                ImageResources.placeholderImage,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                ImageResources.placeholderImage,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  valueNotifier
                                                      .value[index].title
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  valueNotifier
                                                      .value[index].description
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
                              itemCount: valueNotifier.value.length,
                            ),
                          ),
                        )),
              ],
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

  Future<void> _onRefresh() async {
    context.read<HomePageBloc>().add(GetHomePageData());
  }

  void searchRow(String searchString) {
    valueNotifier.value = [];
    if (searchString.isEmpty) {
      valueNotifier.value.addAll(list);
      return;
    }

    for (var temp_list in list) {
      if (temp_list.title == null) {
        continue;
      }
      if (temp_list.title!.toLowerCase().contains(searchString.toLowerCase())) {
        valueNotifier.value.add(temp_list);
      }
    }
  }
}
