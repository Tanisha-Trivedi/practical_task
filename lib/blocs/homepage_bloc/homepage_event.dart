part of 'homepage_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class GetHomePageData extends HomePageEvent {
  @override
  List<Object?> get props => [];
}
