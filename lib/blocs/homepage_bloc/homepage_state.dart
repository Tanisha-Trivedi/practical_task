part of 'homepage_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
}

class HomePageInitial extends HomePageState {
  @override
  List<Object> get props => [];
}

class HomePageLoading extends HomePageState {
  @override
  List<Object?> get props => [];
}

class HomePageSuccess extends HomePageState {
  final HomePageListResponse homePageListResponse;

  const HomePageSuccess({required this.homePageListResponse});
  @override
  List<Object?> get props => [];
}

class HomePageFailure extends HomePageState {
  final String message;

  const HomePageFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
