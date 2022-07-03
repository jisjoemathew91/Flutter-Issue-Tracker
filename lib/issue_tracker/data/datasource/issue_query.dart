mixin IssueQueries {
  static String listIssuesQuery = r'''
  query ListIssues($owner: String!
  $name: String!
  $first: Int!
  $orderBy: IssueOrder
  $filterBy: IssueFilters
  $after: String) {
  repository(owner: $owner, name: $name) {
    issues(
      first: $first
      orderBy: $orderBy
      filterBy: filterBy
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
        labels(first:10){
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
      author {
        avatarUrl
        login
      }
      createdAt
      closedAt
      body
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
}
