mixin IssueQueries {
  static String listIssuesQuery = r'''
  query ListIssues($owner: String!
  $name: String!
  $first: Int!
  $orderBy: IssueOrder
  $filterBy: IssueFilters
  $after: String
  $labelFirst: Int) {
  repository(owner: $owner, name: $name) {
    issues(
      first: $first
      orderBy: $orderBy
      filterBy: $filterBy
      after: $after
    ) {
      pageInfo {
        endCursor
        hasNextPage
      }
      nodes {
        id
        number
        title
        state
        stateReason
        createdAt
        comments {
          totalCount
        }
        isReadByViewer
        createdAt
        closedAt
        labels(first: $labelFirst){
          nodes{
            id
            color
            name
          }
        }
      }
    }
  }
}''';

  static String issueDetailQuery = r'''
query IssueDetailQuery($owner: String!
  $name: String!
  $number: Int!) {
  repository(owner: $owner, name: $name) {
    issue(number: $number) {
      id
      number
      title
      authorAssociation
      author {
        avatarUrl
        login
      }
      createdAt
      closedAt
      bodyUrl
      body
      bodyHTML
      state
      stateReason
      comments {
        totalCount
      }
      labels(first: 10) {
        pageInfo {
          endCursor
          hasNextPage
        }
        totalCount
        nodes {
          id
          color
          name
        }
      }
    }
  }
}''';

  static String listAssignableUsersQuery = r'''
  query ListAssignableUser($owner: String!
  $name: String!
  $first: Int
  $after: String) {
  repository(owner: $owner, name: $name) {
    assignableUsers(first: $first, after: $after) {
      pageInfo{
        hasNextPage
        endCursor
      }
      nodes {
        id
        avatarUrl
        name
        login
      }
    }
  }
}''';

  static String listLabelsQuery = r'''
  query ListLabels($owner: String!
  $name: String!
  $first: Int
  $after: String
  $orderBy: LabelOrder) {
  repository(owner: $owner, name: $name) {
    labels(first: $first 
      after: $after
      orderBy: $orderBy) {
      pageInfo {
        hasNextPage
        endCursor
      }
      nodes {
        id
        color
        name
      }
    }
  }
}''';

  static String listMilestonesQuery = r'''
  query ListMilestones($owner: String!
  $name: String!
  $first: Int
  $after: String) {
  repository(owner: $owner, name: $name) {
    milestones(first: $first 
      after: $after) {
      pageInfo {
        hasNextPage
        endCursor
      }
      nodes {
        id
        number
        title
      }
    }
  }
}''';
}
