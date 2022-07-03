class CommentsModel {
  CommentsModel({
    this.totalCount,
  });

  CommentsModel.fromJson(dynamic json) {
    totalCount = json['totalCount'] as int?;
  }

  int? totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalCount'] = totalCount;
    return map;
  }
}
