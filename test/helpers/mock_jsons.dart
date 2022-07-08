dynamic mockIssueJson = {
  'repository': {
    'issue': {
      'id': 'I_kwDOAeUeuM5NFiOC',
      'number': 107074,
      'title':
          'didChangeAppLifecycleState always called even not visible/active',
      'authorAssociation': 'NONE',
      'author': {
        'avatarUrl': 'https://avatars.githubusercontent.com/u/10980847?v=4',
        'login': 'josefwilfinger'
      },
      'createdAt': '2022-07-04T15:10:03Z',
      'closedAt': null,
      'body':
          'Hi guys, \r\n\r\ni have the problem that for a widget which is not '
              'visible (not active StatelessWidget) the '
              'function\r\ndidChangeAppLifecycleState is always called. '
              'This is a performance issue. \r\nIn this case because it is a '
              'Camera widget, the camera gets always active if the app resumes.'
              '\r\nThis widget is not mine, i can not change the code it is a '
              'package from flutter.dev.\r\nA possibility to disable this call '
              'would be great.\r\n\r\ngreets and thx for your work',
      'bodyHTML':
          '<p dir="auto">Hi guys,</p>\n<p dir="auto">i have the problem that for a widget which is not visible (not active StatelessWidget) the function<br>\ndidChangeAppLifecycleState is always called. This is a performance issue.<br>\nIn this case because it is a Camera widget, the camera gets always active if the app resumes.<br>\nThis widget is not mine, i can not change the code it is a package from flutter.dev.<br>\nA possibility to disable this call would be great.</p>\n<p dir="auto">greets and thx for your work</p>',
      'bodyResourcePath': '/flutter/flutter/issues/107074#issue-1293296514',
      'state': 'OPEN',
      'stateReason': null,
      'comments': {'totalCount': 1},
      'labels': {
        'pageInfo': {
          'endCursor':
              'Y3Vyc29yOnYyOpK5MjAyMC0wMi0yMFQyMjo1NTo0NiswNTozMM5u5JFX',
          'hasNextPage': false
        },
        'totalCount': 2,
        'nodes': [
          {
            'id': 'MDU6TGFiZWwyODM0Nzk5NjU=',
            'color': '000000',
            'name': 'waiting for customer response'
          },
          {
            'id': 'MDU6TGFiZWwxODYwNDczMTc1',
            'color': '000000',
            'name': 'in triage'
          }
        ]
      }
    }
  }
};

dynamic mockLabelsJson = {
  'pageInfo': {
    'hasNextPage': true,
    'endCursor': 'Y3Vyc29yOnYyOpKiUDDOfPqUeg=='
  },
  'nodes': [
    {'id': 'MDU6TGFiZWwxNDY5MTI0ODE1', 'color': 'eae027', 'name': 'CQ+1'},
    {'id': 'MDU6TGFiZWwyMDk2Nzk2Nzk0', 'color': 'ff0000', 'name': 'P0'}
  ]
};

dynamic mockAssignableUsersJson = {
  'pageInfo': {
    'hasNextPage': true,
    'endCursor': 'Y3Vyc29yOnYyOpKmYS1zaXZhzgCDu80='
  },
  'nodes': [
    {
      'id': 'MDQ6VXNlcjI2NjI1MTQ5',
      'avatarUrl': 'https://avatars.githubusercontent.com/u/26625149?v=4',
      'name': 'Rulong Chen（陈汝龙）',
      'login': '0xZOne'
    },
    {
      'id': 'MDQ6VXNlcjg2MzMyOTM=',
      'avatarUrl':
          'https://avatars.githubusercontent.com/u/8633293?u=d6bc5b98b8ed13f38be510d649c4fd628f4463e4&v=4',
      'name': 'Siva',
      'login': 'a-siva'
    }
  ]
};

dynamic mockMileStoneJson = {
  'milestones': {
    'pageInfo': {'hasNextPage': true, 'endCursor': 'Y3Vyc29yOnYyOpHOABYbAg=='},
    'nodes': [
      {'id': 'MDk6TWlsZXN0b25lMTQwOTIwNg==', 'number': 3, 'title': '0: Today'},
      {'id': 'MDk6TWlsZXN0b25lMTQ0ODcwNg==', 'number': 4, 'title': 'Hackathon'}
    ]
  }
};
