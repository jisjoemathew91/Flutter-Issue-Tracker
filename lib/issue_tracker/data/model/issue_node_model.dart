import 'package:flutter_issue_tracker/issue_tracker/data/model/author_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/comments_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/labels_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';

class IssueNodeModel {
  IssueNodeModel({
    this.id,
    this.number,
    this.title,
    this.author,
    this.createdAt,
    this.closedAt,
    this.bodyUrl,
    this.body,
    this.bodyHTML,
    this.state,
    this.stateReason,
    this.comments,
    this.labels,
    this.isReadByViewer,
  });

  IssueNodeModel.fromJson(dynamic json) {
    id = json['id'] as String?;
    number = json['number'] as int?;
    title = json['title'] as String?;
    author =
        json['author'] != null ? AuthorModel.fromJson(json['author']) : null;
    createdAt = json['createdAt'] as String?;
    closedAt = json['closedAt'] as String?;
    bodyUrl = json['bodyUrl'] as String?;
    body = json['body'] as String?;
    bodyHTML = json['bodyHTML'] as String?;
    state = json['state'] as String?;
    stateReason = json['stateReason'] as String?;
    comments = json['comments'] != null
        ? CommentsModel.fromJson(json['comments'])
        : null;
    labels =
        json['labels'] != null ? LabelsModel.fromJson(json['labels']) : null;
    isReadByViewer = json['isReadByViewer'] as bool?;
  }

  String? id;
  int? number;
  String? title;
  AuthorModel? author;
  String? createdAt;
  String? closedAt;
  String? bodyUrl;
  String? body;
  String? bodyHTML;
  String? state;
  String? stateReason;
  CommentsModel? comments;
  LabelsModel? labels;
  bool? isReadByViewer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['number'] = number;
    map['title'] = title;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    map['createdAt'] = createdAt;
    map['closedAt'] = closedAt;
    map['bodyUrl'] = bodyUrl;
    map['body'] = body;
    map['bodyHTML'] = bodyHTML;
    map['state'] = state;
    map['stateReason'] = stateReason;
    map['isReadByViewer'] = isReadByViewer;
    if (comments != null) {
      map['comments'] = comments?.toJson();
    }
    if (labels != null) {
      map['labels'] = labels?.toJson();
    }
    return map;
  }

  IssueNode toEntity() => IssueNode(
        id: id,
        number: number,
        title: title,
        author: author,
        createdAt: createdAt,
        closedAt: closedAt,
        bodyUrl: bodyUrl,
        body: body,
        bodyHTML: bodyHTML,
        state: state,
        stateReason: stateReason,
        comments: comments,
        labels: labels,
        isReadByViewer: isReadByViewer,
      );
}
