import 'package:flutter_issue_tracker/issue_tracker/data/model/repository_model.dart';

class RepositoryDataModel {
  RepositoryDataModel({
    this.repository,
  });

  RepositoryDataModel.fromJson(dynamic json) {
    repository = json['repository'] != null
        ? RepositoryModel.fromJson(json['repository'])
        : null;
  }

  RepositoryModel? repository;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (repository != null) {
      map['repository'] = repository?.toJson();
    }
    return map;
  }
}
