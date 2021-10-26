import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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

      // final imageTemporary = File(image.path);
      // this.image = imageTemporary;
      // setState(() => this.image = imageTemporary);
      final imagePermanent = await saveImagePermanently(image.path);
      print('LOCATION IF IMAGES: ' + image.path);
      this.image = imagePermanent;
      setState(() => this.image = imagePermanent);
    } on PlatformException catch (e) {
      print('failed to pick images: $e');
    }
  }

  List<String> imgLocation = [];
  List<String> imgName = [];

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    print(directory);
    imgLocation.add(basename(imagePath));
    imgName.add(name);
    print("Imahe List Location: ");
    print(imgLocation);
    print("Imahe List Path: ");
    print(imagePath);
    return File(imagePath).copy(image.path);
  }

  void _printImgLocationList() {
    print(imgLocation);
  }

  void _printImgNameList() {
    print(imgName);
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

  List<File> _imageList = [];

  int index = 0;

  void _addImage(File _newimage) {
    setState(() {
      index += 1;
      _imageList.add(_newimage);
      print("HA path" + _newimage.path);
    });
  }

  void _printImgList() {
    print(_imageList.toString());
  }

  @override
  Widget build(BuildContext context) {
    // var item = yourItemList.length - 1;

    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
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
              // TextButton(
              //   child: Text("Add Image:  ${_imageList.length}"),
              //   onPressed: () async {
              //     var _image =
              //         await ImagePicker.pickImage(source: ImageSource.gallery);
              //     // print(_image.path);
              //     // _addImage(_image);
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton.icon(
                    icon: Icon(Icons.ac_unit),
                    label: Text("Camera "),
                    onPressed: () async {
                      var _newimage = await pickImage(ImageSource.gallery);
                      print("HELLOO " + _newimage.path);
                      _addImage(_newimage);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _imageList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          print('Tepped');
                          return null;
                        },
                        child: Card(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Text(_imageList[index].path),
                              // child: Text(
                              //   "_imageList[index].path",
                              //   style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: TextButton.icon(
                  onPressed: _printImgList,
                  icon: Icon(Icons.wb_sunny),
                  label: Text("PRINT IMAGE List"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: TextButton.icon(
                  onPressed: _printImgLocationList,
                  icon: Icon(Icons.wb_sunny),
                  label: Text("PRINT IMAGE PATH LIST"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: TextButton.icon(
                  onPressed: _printImgNameList,
                  icon: Icon(Icons.wb_sunny),
                  label: Text("PRINT IMAGE NAME LIST"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 34,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      widget.description,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
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
                      size: 60,
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
                padding: const EdgeInsets.all(30.0),
                child: TextButton.icon(
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text("Camera"),
                  onPressed: () => pickImage(ImageSource.camera),
                ),
              ),

              // DEV NOTES:  Can also choose many images using final List <XFile>? images = await  _picker.pickMultiImage();
              // Read Documentation for details: https://pub.dev/packages/image_picker/versions/0.8.3+1/example
              // Take not of changes required if you want to imple,ment in iOS need to update the Runner/Info.plist and add NSCameraUsageDescription...n

              //DEV NOTES: Choose Video Clip - Only in Version 2?
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: TextButton.icon(
              //     icon: Icon(Icons.camera_alt_outlined),
              //     label: Text("Camera"),
              //     onPressed: () => pickImage(ImageSource.gallery),
              //   ),
              // ),

              // Container(
              //   height: 50,
              //   child: SingleChildScrollView(
              //     child: ListView(
              //         scrollDirection: Axis.vertical,
              //         children: <Widget>[
              //           Text(
              //             srvq[0],
              //           ),
              //           Text(
              //             srvq[1],
              //           ),
              //           Text(
              //             srvq[2],
              //           ),
              //         ]),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    // Container(
                    //   height: 10,
                    //   color: Colors.grey,
                    // ),
                    // Container(
                    //   height: 10,
                    //   color: Colors.blueGrey,
                    // ),
                    // Container(
                    //   height: 10,
                    //   color: Colors.green,
                    // ),
                    // Container(
                    //   height: 10,
                    //   color: Colors.grey,
                    // )
                    Text(
                      srvq[0],
                    ),
                    Text(
                      srvq[1],
                    ),
                    Text(
                      srvq[2],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 44,
              ),
              // ListView(
              //   scrollDirection: Axis.vertical,
              //   children: <Widget>[
              //     Container(
              //       height: 10,
              //       color: Colors.grey,
              //     ),
              //     Container(
              //       height: 10,
              //       color: Colors.blueGrey,
              //     )
              //   ],
              // ),
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
