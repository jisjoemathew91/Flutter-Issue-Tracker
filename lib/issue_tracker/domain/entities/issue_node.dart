import 'package:flutter_issue_tracker/issue_tracker/data/model/author_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/comments_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/labels_model.dart';

class IssueNode {
  IssueNode({
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
}
