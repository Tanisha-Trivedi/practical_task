import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:practical_task/models/homepage_list_model.dart';
import 'package:practical_task/network/network_file.dart';

import '../../resources/string_resources.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  late HomePageListResponse _homePageListResponse;
  final Connectivity _connectivity = Connectivity();

  HomePageBloc() : super(HomePageInitial()) {
    on<GetHomePageData>(_getHomePageData);
  }

  void _getHomePageData(
      GetHomePageData getHomeData, Emitter<HomePageState> emit) async {
    emit(HomePageLoading());
    try {
      late ConnectivityResult result;

      result = await _connectivity.checkConnectivity();
      Map<String, dynamic> param;
      param = {"params": {}};
      _homePageListResponse =
          await NetworkController().getHomeData(param: param);
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        if (_homePageListResponse.rows.isNotEmpty) {
          emit(HomePageSuccess(homePageListResponse: _homePageListResponse));
        } else {
          emit(const HomePageFailure(message: Strings.noDataFound));
        }
      } else {
        emit(const HomePageFailure(message: Strings.connectivityFailure));
      }
    } catch (e) {
      emit(const HomePageFailure(message: Strings.somethingWentWrong));
    }
  }
}
