import 'package:flutter/material.dart';

class Survey extends StatefulWidget {
  final String name;
  final String description;
  // final String id;
  // final String userId;

  const Survey({
    Key? key,
    required this.name,
    required this.description,
    // required this.id,
    // required this.userId
  }) : super(key: key);

  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  // late String name;
  int _index = 0;
  List quotes = [
    "Hello inspire 1",
    "HEllo Inspire 2",
    "Hello inspire 3",
    "HEllo Inspire 4",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(quotes[_index % quotes.length]),
            ),
            Text("3.1 createinitsurvey.dt : NEW Survey Class Object Created"),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: TextButton.icon(
                onPressed: _showQuote,
                icon: Icon(Icons.wb_sunny),
                label: Text("Inspire Me!"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: TextButton.icon(
                onPressed: _resetIndex,
                icon: Icon(Icons.wb_sunny),
                label: Text("REset Index"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showQuote() {
    print(_index);
    setState(() {
      _index += 1;
    });
  }

  void _resetIndex() {
    print(_index);
    setState(() {
      _index = 0;
    });
  }
}
