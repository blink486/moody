import 'package:flutter/material.dart';
import 'package:moodclicks/screens/crd.dart';
import 'package:moodclicks/screens/questioncard.dart';

class Card2 extends StatefulWidget {
  const Card2({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Card2> {
  TextEditingController inputText = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    String emojiSymb = '\u2764';
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Data" /*+ widget.searchstr*/),
        actions: <Widget>[
          TextButton(
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
          ),
        ],
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
                'Start Survey 3rd',
              ),
              // ),
            ),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Expanded(
                  child: Text(
                    '2 .Generally how satisfied or dissatisfied are you with the way Lochfield Park deals with repairs and maintenance',
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
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.check,
                color: Colors.green,
              ),
              Icon(
                Icons.check,
                color: Colors.red,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          TextFormField(
            // TODO:  select only emoji Keyboard Tyep and retrict
            // keyboardType: ,
            controller: inputText,
            decoration: InputDecoration(hintText: "Input some Text"),
          ),
        ]),
      ),
    );
  }
}
