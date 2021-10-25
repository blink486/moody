import 'package:flutter/material.dart';
import 'package:moodclicks/screens/createsurvey.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("1. questioncard.dt"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => Card(),
            //   ),
            // );

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CreateSurvey()));
          },
          child: Text(
            'Start Survey',
          ),
          // ),
        ),
      ),
    );
  }
}
