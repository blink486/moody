import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddSrvImages extends StatefulWidget {
  final String name;
  final String description;
  // final String id;
  // final String userId;

  const AddSrvImages({
    Key? key,
    required this.name,
    required this.description,
    // required this.id,
    // required this.userId
  }) : super(key: key);

  @override
  _AddSrvImagesState createState() => _AddSrvImagesState();
}

class _AddSrvImagesState extends State<AddSrvImages> {
// Implemented image picker using code from : https://www.youtube.com/watch?v=MSv38jO4EJk

  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('failed to pick images: $e');
    }
  }

  // late String name;
  final loggedInUser = FirebaseAuth.instance.currentUser!.uid.toString();
  TextEditingController question = new TextEditingController();
  int _index = 0;
  List<String> srvquestions = [
    "Hello inspire11",
    "HEllo Inspire 2",
    "Hello inspire 3",
    "HEllo Inspire 4",
  ];

  List<String> srvq = [
    "Question1",
    "Question2",
    "Question3",
  ];

  List yourItemList = [];

  @override
  Widget build(BuildContext context) {
    // var item = yourItemList.length - 1;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "4. addsrvimages.dart",
                  style: TextStyle(fontSize: 18, color: Colors.pink),
                ),
              ),
              image != null
                  ? ClipOval(
                      child: Image.file(
                        image!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    )
                  : FlutterLogo(
                      size: 160,
                    ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton.icon(
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text("Gallery"),
                  onPressed: () => pickImage(ImageSource.gallery),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton.icon(
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text("Camera"),
                  onPressed: () => pickImage(ImageSource.camera),
                ),
              ),
              SizedBox(
                height: 44,
              ),
              TextFormField(
                controller: question,
                decoration: InputDecoration(hintText: "Add Question to Survey"),
              ),
              SizedBox(height: 10.0),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.red, // foreground
                ),
                onPressed: () {
                  Map<String, dynamic> data = {
                    "f00userid": loggedInUser,
                    "f01surveyname": widget.name,
                    "f02surveydescription": widget.description,
                    "f03question": question.text,
                    "f04questionsexist": "Y",
                  };
                  FirebaseFirestore.instance.collection("questions").add(data);
                },
                child: Text(
                    "Submit New Question - ONLY additional one from above to Firebase OK"),
              ),
              Center(
                child: Text(srvquestions[_index % srvquestions.length]),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: TextButton.icon(
                  onPressed: _addQuestion,
                  icon: Icon(Icons.wb_sunny),
                  label: Text("Add New Question to Question List<>"),
                ),
              ),
              Text("CLICK ABOVE ^^ TO ADD AN ADDITION Q To the LIST ^ "),
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
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: TextButton.icon(
                  onPressed: _uploadQList,
                  icon: Icon(Icons.wb_sunny),
                  label: Text("ADD FULL Question LIST TO Firebase"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: TextButton.icon(
                  onPressed: _printList,
                  icon: Icon(Icons.wb_sunny),
                  label: Text("PRINT List"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: TextButton.icon(
                  onPressed: _removeItemFromList,
                  icon: Icon(Icons.wb_sunny),
                  label: Text("REMOVE Latest Item From List"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void removeItem(int item) => removeItemFromList(item);

  void _uploadQList() {
    // FirebaseFirestore.instance.collection("questions").doc().update(
    print(widget.name);
    for (int i = 0; i < srvquestions.length; i++)
      yourItemList.add({"f03question": srvquestions.toList()[i]});

    FirebaseFirestore.instance
        .collection('questions')
        .doc('qfZnaKiRDN5PQsJ0VYNE')
        .update({
      // 'f01surveyname': widget.name,
      // "f02surveydescription": widget.description,
      "f03question": FieldValue.arrayUnion(yourItemList),
    });
  }

  void _removeItemFromList() {
    // FirebaseFirestore.instance.collection("questions").doc().update(
    // print(widget.name);
    // for (int i = 0; i < srvquestions.length; i++)
    yourItemList.removeAt(yourItemList.length);

    // FirebaseFirestore.instance
    //     .collection('questions')
    //     .doc('n2ixEbIzlPHR0ngVUtoY')
    //     .update({
    //   // 'f01surveyname': widget.name,
    //   // "f02surveydescription": widget.description,
    //   "f03question": FieldValue.arrayUnion(yourItemList),
    // });
  }

  // "f00userid": loggedInUser,
  // "f01surveyname": widget.name,
  // "f02surveydescription": widget.description,
  // "f03question": question.text,
  // "f04questionsexist": "Y",

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

  void _printList() {
    print(srvquestions);
  }

  void _addQuestion() {
    print(_index);
    print("ADDING New Question to LIST[]: " + question.text);
    setState(() {
      _index += 1;
      srvquestions.add(question.text);
    });
  }
}
