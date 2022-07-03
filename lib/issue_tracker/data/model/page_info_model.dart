class PageInfoModel {
  PageInfoModel({
    this.endCursor,
    this.hasNextPage,
  });

  PageInfoModel.fromJson(dynamic json) {
    endCursor = json['endCursor'] as String?;
    hasNextPage = json['hasNextPage'] as bool?;
  }

  String? endCursor;
  bool? hasNextPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['endCursor'] = endCursor;
    map['hasNextPage'] = hasNextPage;
    return map;
  }
}
