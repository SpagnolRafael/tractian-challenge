import 'package:tractian_challenge/data/dto/company_asset_dto.dart';

class TreeState {
  TreeState();
  factory TreeState.initial() => TreeInitialState();
  factory TreeState.loading() => TreeLoadingState();
  factory TreeState.error({void Function()? onTryAgain}) =>
      TreeErrorState(onTryAgain: onTryAgain);
  factory TreeState.success({required List<CompanyAssetDto> assets}) =>
      TreeSuccessState(assets: assets);
}

class TreeInitialState extends TreeState {}

class TreeLoadingState extends TreeState {}

class TreeSuccessState extends TreeState {
  final List<CompanyAssetDto> assets;
  TreeSuccessState({required this.assets});
}

class TreeErrorState extends TreeState {
  final void Function()? onTryAgain;
  TreeErrorState({this.onTryAgain});
}
