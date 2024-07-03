import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/data/repository/asset_repository.dart';
import 'package:tractian_challenge/screens/home_screen/home_event.dart';
import 'package:tractian_challenge/screens/home_screen/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AssetRepository _repository;
  HomeBloc(this._repository) : super(HomeState.initial()) {
    on<LoadCompaniesEvent>((event, emit) => _getCompanies(event, emit));
  }
  HomeEvent? previousEvent;

  Future<void> _getCompanies(
      LoadCompaniesEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeState.loading());
      final companies = await _repository.getCompanies();
      emit(companies.isEmpty
          ? HomeState.empty()
          : HomeState.success(companies: companies));
    } catch (e) {
      emit(HomeState.error(onTryAgain: retry));
    }
  }

  @override
  void onEvent(HomeEvent event) {
    previousEvent = event;
    super.onEvent(event);
  }

  void retry() {
    if (previousEvent != null) {
      add(previousEvent!);
    }
  }
}
