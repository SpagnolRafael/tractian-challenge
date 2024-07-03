class TreeEvent {}

class LoadAssetEvent extends TreeEvent {
  final String companyId;
  LoadAssetEvent(this.companyId);
}

class FilterChangeEvent extends TreeEvent {
  final String? type;
  final String? query;
  FilterChangeEvent({this.type, this.query});
}
