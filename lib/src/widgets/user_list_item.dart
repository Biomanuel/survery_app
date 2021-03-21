import 'package:breastcervicalcancersurvey_app/src/models/registerer.dart';
import 'package:flutter/material.dart';

import '../registerer_page.dart';

class UserListItem extends StatelessWidget {
  final Registerer survey;
  final int index;

  const UserListItem({
    Key key,
    @required this.survey,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      constraints: BoxConstraints(minHeight: 60),
      color: Colors.grey.shade300,
      child: Center(
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${index + 1}."),
            ],
          ),
          title: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegistererPage(survey))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email: "),
                Expanded(
                  child: Text(
                    survey.email,
                    maxLines: 2,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          subtitle: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegistererPage(survey))),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Details: "),
                    Expanded(
                      child: Text(
                        "${survey.userDetails}",
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Submitted Surveys: "),
                    Expanded(
                      child: Text(
                        "${survey.surveyCount}",
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
