import 'package:flutter_issue_tracker/issue_tracker/domain/entities/page_info.dart';

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

  PageInfo toEntity() => PageInfo(
        endCursor: endCursor,
        hasNextPage: hasNextPage,
      );
}
