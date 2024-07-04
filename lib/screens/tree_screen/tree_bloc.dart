import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/data/dto/company_asset_dto.dart';
import 'package:tractian_challenge/data/repository/asset_repository.dart';
import 'package:tractian_challenge/screens/tree_screen/tree_event.dart';
import 'package:tractian_challenge/screens/tree_screen/tree_state.dart';

class TreeBloc extends Bloc<TreeEvent, TreeState> {
  final AssetRepository _repository;
  TreeBloc(this._repository) : super(TreeState.initial()) {
    on<LoadAssetEvent>((event, emit) => _getAsset(event, emit));
    on<FilterChangeEvent>((event, emit) => _getFilteredAsset(event, emit));
  }
  TreeEvent? previousEvent;
  List<CompanyAssetDto> _originalAssets = [];

  Future<void> _getAsset(LoadAssetEvent event, Emitter<TreeState> emit) async {
    try {
      emit(TreeState.loading());
      List<CompanyAssetDto> companyAssets = [];
      final locations =
          await _repository.getLocations(companyId: event.companyId);
      companyAssets.addAll(locations);
      final assets = await _repository.getAssets(companyId: event.companyId);
      companyAssets.addAll(assets);
      _originalAssets = companyAssets;
      emit(TreeState.success(assets: companyAssets));
    } catch (e) {
      emit(TreeState.error(onTryAgain: retry));
    }
  }

  Future<void> _getFilteredAsset(
      FilterChangeEvent event, Emitter<TreeState> emit) async {
    try {
      emit(TreeState.loading());
      List<CompanyAssetDto> parents = [];
      List<CompanyAssetDto> companyAssets = [];
      companyAssets = _originalAssets.where(
        (element) {
          if (event.query != null &&
              event.query!.isNotEmpty &&
              event.type != null) {
            return element.name
                    .toLowerCase()
                    .contains(event.query!.toLowerCase()) &&
                element.sensorType == event.type!;
          } else if (event.query != null &&
              event.query!.isNotEmpty &&
              event.type == null) {
            return element.name
                .toLowerCase()
                .contains(event.query!.toLowerCase());
          } else if (event.query == null && event.type != null) {
            return element.sensorType == event.type!;
          } else {
            return true;
          }
        },
      ).toList();

      int oldLength = parents.length;
      do {
        oldLength = parents.length;
        for (var e in companyAssets) {
          if (e.parentId != null) {
            final parent =
                _originalAssets.firstWhere((asset) => e.parentId == asset.id);

            parents.add(parent);
          }
          {
            _originalAssets.map((i) {
              if (i.parentId == e.id) {
                parents.add(i);
              }
            });
          }
        }
        parents = parents.toSet().toList();
        companyAssets.addAll(parents);
      } while (parents.length != oldLength);
      companyAssets.addAll(parents);
      companyAssets = companyAssets.toSet().toList();
      emit(TreeState.success(assets: companyAssets));
    } catch (e) {
      emit(TreeState.success(assets: _originalAssets));
    }
  }

  @override
  void onEvent(TreeEvent event) {
    previousEvent = event;
    super.onEvent(event);
  }

  void retry() {
    if (previousEvent != null) {
      add(previousEvent!);
    }
  }
}
