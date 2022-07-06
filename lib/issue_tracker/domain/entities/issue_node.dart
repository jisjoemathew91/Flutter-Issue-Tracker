import 'package:flutter_issue_tracker/issue_tracker/domain/entities/author.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/comments.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/labels.dart';

class IssueNode {
  IssueNode({
    this.id,
    this.number,
    this.title,
    this.authorAssociation,
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
  String? authorAssociation;
  Author? author;
  String? createdAt;
  String? closedAt;
  String? bodyUrl;
  String? body;
  String? bodyHTML;
  String? state;
  String? stateReason;
  Comments? comments;
  Labels? labels;
  bool? isReadByViewer;
}
