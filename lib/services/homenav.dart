import 'package:flutter/material.dart';
import 'package:moodclicks/screens/questioncard.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({Key? key}) : super(key: key);
// TODO:CREATE AND FINISH NAV BAR
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                // GetDataX 11/09/2021
                builder: (BuildContext context) => Home(

                    //TO DO: Add Snapshot Item doc id and pass to create Card in next screen
                    )));
      },
      child: Text(
        "HOME",
        style: TextStyle(color: Colors.amber),
      ),
    );
  }
}
