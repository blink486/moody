import 'package:flutter/material.dart';
import 'package:moodclicks/screens/crd.dart';

class Card3 extends StatefulWidget {
  const Card3({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Card3> {
  @override
  Widget build(BuildContext context) {
    String emojiSymb = '\u2765';
    return Scaffold(
      appBar: AppBar(
        title: Text("Question Start"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Center(
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
                        builder: (BuildContext context) => Qcards()));
              },
              child: Text(
                'Start Survey 4rd',
              ),
              // ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                child: Expanded(
                  child: Text(
                    '1. Taking into account the accommodation and services that Lochfield Park provides, do you think the rent for the property provides good value for money?',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(emojiSymb, style: TextStyle(fontSize: 44)),
              Text(emojiSymb, style: TextStyle(fontSize: 44)),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(emojiSymb, style: TextStyle(fontSize: 44)),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(emojiSymb, style: TextStyle(fontSize: 44)),
              Text(emojiSymb, style: TextStyle(fontSize: 44)),
              Text(emojiSymb, style: TextStyle(fontSize: 44)),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "<<<<<<",
            style: TextStyle(fontSize: 44, color: Colors.grey),
          ),
          SizedBox(
            height: 50,
          ),
        ]),
      ),
    );
  }
}
