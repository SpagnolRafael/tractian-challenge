import 'package:tractian_challenge/data/dto/company_dto.dart';

class HomeState {
  HomeState();

  factory HomeState.initial() => HomeInitialState();
  factory HomeState.loading() => HomeLoadingState();
  factory HomeState.empty() => HomeEmptyState();
  factory HomeState.error({void Function()? onTryAgain}) =>
      HomeErrorState(onTryAgain: onTryAgain);
  factory HomeState.success({required List<CompanyDto> companies}) =>
      HomeSuccessState(companies: companies);
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeEmptyState extends HomeState {}

class HomeErrorState extends HomeState {
  final void Function()? onTryAgain;
  HomeErrorState({this.onTryAgain});
}

class HomeSuccessState extends HomeState {
  final List<CompanyDto> companies;
  HomeSuccessState({required this.companies});
}
