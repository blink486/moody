// import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moodclicks/model/survey.dart';
import 'package:moodclicks/model/surveyo.dart';
import 'package:moodclicks/screens/addimagescloud.dart';
import 'package:moodclicks/screens/tmp.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:convert';

class AddSrvImages extends StatefulWidget {
  final String name;
  final String description;
  // TODO: ADD Document Name from initial Survey Question in Previous Class.
  // TODO: Add additional Details from SignUp e.g. Phone No. , verify e-mail,

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
  var imageUrlFire;
  File? image;

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    // final _picker = ImagePicker();
    // PickedFile image;
    // File image;
// TODO: Check Permissions

// Select IMAGE

    // image =
    //     (await _picker.pickImage(source: ImageSource.gallery)) as PickedFile;
    final imageCloud =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print(PickedFile);
    print(imageCloud!.path);
    var file = File(imageCloud.path); //Fullpath
    var fileName = File(basename(imageCloud.path));
    if (imageCloud != null) {
      final name = basename(imageCloud.path);
      var snapshot =
          await _storage.ref().child('folderName/$name').putFile(file);
      print(snapshot);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      print('DOWNLOAD url');
      print(downloadUrl);
      Map<String, dynamic> data = {
        "imageLocation": file, //In Phone
        "imageName": fileName, //Name of image
        "downloadUrl": downloadUrl, //Location in CloudFireStorage
        "votes": 0,
      };
      imgMapList.add(data);

      setState(() {
        imageUrlFire = downloadUrl;
      });
    } else {
      print('No path found');
    }
  }

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

// Future uploadListToFire() async {

//     final _storage = FirebaseStorage.instance;

//  List<Map> imgMapList = [];

// }

  Future uploadListToFire() async {
    // FirebaseFirestore.instance.collection("questions").doc().update(
    final _fireStore = FirebaseFirestore.instance;
    List surveyItem = [];

    print(widget.name);

    // for (int j = 0; j < imgMapList.length; j++) print(j);
    for (int i = 0; i < imgMapList.length; i++)
      surveyItem.add({
        "votes": imgMapList.toList()[i]['votes'],
        "downloadUrl": imgMapList.toList()[i]['downloadUrl'].toString(),
      });

    // var snapshot =
    await _fireStore.collection('questions').doc('cV1Ht0R8VifDs89kGbVZ').set({
      'f01surveyname': widget.name,
      "f02surveydescription": widget.description,
      "items": FieldValue.arrayUnion(surveyItem),
      // "f0xdloadUerl": imgMapList[i]['downloadUrl'],
    });
  }

// List<Map> imgfromcloud = [];

// Future getdata() async{
//   await FirebaseFirestore.instance.collection("questions").doc('cV1Ht0R8VifDs89kGbVZ').get().then((value){
// setState(() {
//       // first add the data to the Offset object
//       List.from(value.data["items"]).forEach((element){
//           Offset data = new Offset(element);

//           //then add the data to the List<Offset>, now we have a type Offset
//           imgfromcloud.add(data);
//       });

//       });
//    });
//   }

//   late Future<dynamic> friendsList;

//   Future getclouddata() async {
// // final value =
//     FirebaseFirestore.instance
//         .collection("questions")
//         .doc('cV1Ht0R8VifDs89kGbVZ')
//         .get()
//         .then((value) {
//       friendsList = value.data()!["items"];
//       print(friendsList);
//     });
//   }

//   void getFriendsList() async {
//     List<dynamic> friendls;

//     final value = await FirebaseFirestore.instance
//         .collection("questions")
//         .doc('cV1Ht0R8VifDs89kGbVZ')
//         .get();
//     //  .then((value) {
//     //  return value.data()!["friends"];

//  forEac friendls.add(value["friend"])
  //  value.data()["friends"];

  // return
  // value.data()!["friends"];
  // })
  // ;
  // friendsList = value.data()!["items"]["votes"].toString() as Future;
  // print(friendsList);

  // List cloudItems = [];

  // for (int j = 0; j < imgMapList.length; j++) print(j);
  // for (int i = 0; i < imgMapList.length; i++)
//       cloudItems.add({
//         "votes": value.data.()[i]['votes'],
//         "downloadUrl": imgMapList.toList()[i]['downloadUrl'].toString(),
//       });

//     print(value.data());
//     String data = value[];

// String  dload = jsonDecode(value.data());

// var myData = jsonDecode(value.data())['f01surveyname'][0];
// print(myData);

// List<imgMapList> chartData = [];

// Future loadSalesData() async {
//   String jsonString = await getJsonFromFirebaseRestAPI();
//   final jsonResponse = json.decode(jsonString);
//   setState(() {
//     for (Map<String, dynamic> i in jsonResponse)
//       chartData.add(SalesData.fromJson(i));
//   });
// }

// factory LocationRecordings.fromJson(Map<String, dynamic> json) {

//  List<> recList = [];

//  List<dynamic>.from(json['recordings']).forEach((content) {
//       Recording recording = Recording.fromJson(jsonDecode(jsonEncode(content)));
//       recList.add(recording);
//    });
//  return new LocationRecordings(recordings: recList, state: json['state']);
// }
  // }

// TODO: Make survey Publi/Private?
// TODO: Create and save groups in profile e.g. send to group - List Group?
// TODO: How to access Contacts in phone and groups in WhatsApp?
// TODO: Create Launch Page and show popular public votes on TOP Card.
//
  // Future<void> uploadListToFire() async {
  //   // FirebaseFirestore.instance.collection("questions").doc().update(
  //   print(widget.name);
  //   print(srvquestions);
  //   for (int i = 0; i < srvquestions.length; i++)
  //     yourItemList.add({"f03question": srvquestions.toList()[i]});

  //   await FirebaseFirestore.instance
  //       .collection('questions')
  //       .doc('pTTR5oIfOSjNf0AMy0UH')
  //       .update({
  //     // 'f01surveyname': widget.name,
  //     // "f02surveydescription": widget.description,
  //     "f03question": FieldValue.arrayUnion(yourItemList),
  //   });
  // }

  // void uploadListToFireO() {
  //   // FirebaseFirestore.instance.collection("questions").doc().update(
  //   print(widget.name);
  //   print('Hello');
  //   print(srvquestions);
  //   for (int i = 0; i < srvquestions.length; i++)
  //     yourItemList.add({"f08dloadUrl": srvquestions.toList()[i]});
  //   // for (int i = 0; i < imgMapList.length; i++)
  //   FirebaseFirestore.instance
  //       .collection('questions')
  //       .doc('pTTR5oIfOSjNf0AMy0UH')
  //       .update({
  //     'f01surveyname': widget.name,
  //     "f02surveydescription": widget.description,
  //     // "f05dloadUrl": FieldValue.arrayUnion(yourItemList),
  //     // "f05dloadUrl": imageUrlFire.toString(),
  //     // 'dataAdd': imgMapList[i]["downloadUrl"]
  //     // "nested": FieldValue.arrayUnion(yourItemList),
  //     "f08dloadUrl": FieldValue.arrayUnion(yourItemList),
  //   });
  // }

  int _votes = 0;

  late String imageUrl;

  List<File> imgLoc = [];
  List<String> imgLocation = [];
  List<String> imgName = [];
  List<Map> imgMapList = [];

  Future<File> saveImagePermanently(String imagePath) async {
    final _storage = FirebaseStorage.instance;
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    print(directory);
    imgLocation.add(basename(imagePath));
    imgName.add(name);
    imgLoc.add(image);

    Map<String, dynamic> data = {
      "imageLocation": image,
      "votes": 0,
    };
    imgMapList.add(data);
    print("Imahe List Location: ");
    print(imgLocation);
    print("Imahe List Path: ");
    print(imagePath);
    // return File(imagePath).copy(image.path);

// EXTRA TO UPLOAD TO FIREBASE STORAGE:

    // Future uploadImageToFirebase(BuildContext context) async {
    // String fileName = basename(_imageFile.path);
    // StorageReference firebaseStorageRef =
    //     FirebaseStorage.instance.ref().child('uploads/$image');
    // StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // taskSnapshot.ref.getDownloadURL().then(
    //       (value) => print("Done: $value"),
    //     );

    // try {
    //   var firebase_storage;
    //   await firebase_storage.FirebaseStorage.instance
    //       .ref('uploads/file-to-upload.png')
    //       .putFile(image);
    // } on firebase_core.FirebaseException catch (e) {
    //   // e.g, e.code == 'canceled'
    // }

    try {
      var snapshot = await _storage.ref().child('images').putFile(image);

      var downloadurl = snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadurl as String;
      });
    } catch (e) {
      print(e);
      print("NO FILE UPload");
    }
    return File(imagePath).copy(image.path);

    // }
  }

  // Future uploadImageToFirebase(BuildContext context) async {
  //   String fileName = basename(_imageFile.path);
  //   StorageReference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child('uploads/$fileName');
  //   StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
  //   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  //   taskSnapshot.ref.getDownloadURL().then(
  //         (value) => print("Done: $value"),
  //       );
  // }

  void _printImgLocationList() {
    print(imgLocation);
  }

  void _printImgNameList() {
    print(imgName);
  }

  void _printImgMapList() {
    print(imgMapList);
  }

  void _clearImgNameList() {
    setState(() {
      imgLoc.clear();
    });
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

  void _voteincr() {
    setState(() {
      _votes += 1;

      print(" ONe Vote added");
    });
  }

  void _voteIncrMap(index) {
    setState(() {
      imgMapList[index]['votes'] += 1;
      print(" ONe Vote added to ");
    });
  }

// body['personalizations'][0]['dynamic_template_data']['Salary'] = 5000.00;

  @override
  Widget build(BuildContext context) {
    // var item = yourItemList.length - 1;

    FutureBuilder<Exercise> exercise;

    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
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

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Text(
                      srvq[0],
                    ),
                    Text(
                      srvq[1],
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          print('pic pRESSED');
                          _voteincr();
                          print(_votes);
                        },
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          height: 160,
                          width: 160,
                          child: image == null
                              ? Text('No Image Showing')
                              : Image.file(imgLoc.first),
                        ),
                      ),
                    ),
                  ],
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
              ),

              // NEW CARD LIST VIEW
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: imgMapList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print('pic pRESSED');
                        _voteIncrMap(index);
                        // _voteincr();
                        print(_printImgMapList);
                        // return null;
                      },
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          alignment: Alignment.bottomLeft,
                          height: 90,
                          width: 80,
                          child: image == null
                              ? Text('No Image Showing in CARD')
                              : Image.file(
                                  imgMapList[index]['imageLocation'] as File),
                          // : Image.file(
                          //     '/data/user/0/com.example.moodclicks/app_flutter/image_picker1557202220805647028.jpg'),
                        ),
                      ),
                    );
                  }),

              Padding(
                padding: const EdgeInsets.all(34.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ListImages(),
                      ),
                    ); //Go Sample Cards
                    // builder: (BuildContext context) => SignUp()));
                    // print('${smile.name}');
                  },
                  child: Text(
                    " View Sample Survey Display:",
                    style: TextStyle(fontSize: 18),
                  ),
                  // ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: imgLoc.length,
                itemBuilder: (context, index) {
                  // return Text('Some text');

                  return Center(
                    child: TextButton(
                      onPressed: () {
                        print('pic pRESSED');
                        _voteincr();
                        print(_votes);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        alignment: Alignment.bottomLeft,
                        height: 80,
                        width: 100,
                        child: image == null
                            ? Text('No Image Showing')
                            : Image.file(imgLoc[index]),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(34.0),
                child: TextButton(
                  onPressed: () {
                    imgLoc.clear();
                  },
                  child: Text(
                    // NEED LOGIC TO REBUILD CONTEXT
                    " Clear imgLoc: ",
                    style: TextStyle(fontSize: 18),
                  ),
                  // ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: TextButton.icon(
                  onPressed: _printImgMapList,
                  icon: Icon(Icons.wb_sunny),
                  label: Text("PRINT IMAGE _printImgMapList LIST"),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: imgMapList.length,
                itemBuilder: (context, index) {
                  // var imageLoc = imgMapList[index]['imageLocation'].toString();
                  File file =
                      File(imgMapList[index]['imageLocation'].toString());

                  return Center(
                    child: TextButton(
                      onPressed: () {
                        print('pic pRESSED');
                        _voteIncrMap(index);
                        // _voteincr();
                        print(_printImgMapList);
                        print("thi is it 3");
                        print(imgMapList[index]['votes']);
                        print(image);
                        print("thi is it 4");
                        print(imgMapList[index]['imageLocation'] as File);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        alignment: Alignment.bottomLeft,
                        height: 180,
                        width: 100,
                        child: image == null
                            ? Text('No Image Showing')
                            : Image.file(
                                imgMapList[index]['imageLocation'] as File),
                        // : Image.file(
                        //     '/data/user/0/com.example.moodclicks/app_flutter/image_picker1557202220805647028.jpg'),
                      ),
                    ),
                  );
                },
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => UploadImages(),
                    ),
                  ); //Go Sample Cards
                  // builder: (BuildContext context) => SignUp()));
                  // print('${smile.name}');
                },
                child: Text(
                  " Images: UPLOAD to Cloud",
                  style: TextStyle(fontSize: 14),
                ),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text("Upload to Firebase from Gallery"),
                  onPressed: () => uploadImage(), //(ImageSource.gallery),
                ),
              ),
              Container(
                height: 100,
                width: 80,
                child: Image.network(
                  // "https://firebasestorage.googleapis.com/v0/b/moodclick-3174b.appspot.com/o/folderName%2Fimage_picker8468315551375320268.jpg?alt=media&token=f438819a-92e2-4e8f-b8b7-aa943d6fbbc9",
                  "https://firebasestorage.googleapis.com/v0/b/moodclick-3174b.appspot.com/o/folderName%2Fimage_picker2699089795374030666.jpg?alt=media&token=e0805266-bb82-41f6-a79d-411cf9ebe38d",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 80,
                  child: Text('List from Cloud'),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: imgMapList.length,
                itemBuilder: (context, index) {
                  // var imageLoc = imgMapList[index]['imageLocation'].toString();
                  // File file =
                  //     File(imgMapList[index]['imageLocation'].toString());

                  return Center(
                    child: TextButton(
                      onPressed: () {
                        print('pic pRESSED');
                        _voteIncrMap(index);
                        // _voteincr();
                        print(_printImgMapList);
                        print("Votes");
                        print(imgMapList[index]['votes']);
                        print(image);
                        print("List of Docs");
                        print(imgMapList[index]['imageLocation'] as File);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        alignment: Alignment.bottomLeft,
                        height: 180,
                        width: 100,
                        child: imageUrlFire == null
                            ? Text('No Image Showing')
                            // : Image.network(imgMapList[index]['downloadUrl']),
                            : Image.network(imgMapList[index]['downloadUrl']),
                        // : Image.file(
                        //     '/data/user/0/com.example.moodclicks/app_flutter/image_picker1557202220805647028.jpg'),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton.icon(
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text("Upload imageList to Firebase"),
                  onPressed: () => uploadListToFire(), //(ImageSource.gallery),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton.icon(
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text("Upload SaveNestedData  to Firebase"),
                  onPressed: () => SaveNestedData(), //(ImageSource.gallery),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton.icon(
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text("Upload AddObjectToArray  to Firebase"),
                  onPressed: () => AddObjectToArray(), //(ImageSource.gallery),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton.icon(
                    icon: Icon(Icons.camera_alt_outlined),
                    label: Text("Download ReadNestedData()  from Firebase"),
                    onPressed: () {
                      ReadNestedData();
                      // exercise = jsonDecode();
                      // Exercise tutorial = Exercise.fromMap()   .fromJson(jsonDecode(nestedObjText));
                    } //(ImageSource.gallery),
                    ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              QList())); //Go Sample Cards
                  // builder: (BuildContext context) => SignUp()));
                  // print('${smile.name}');
                },
                child: Text(
                  " View Sample Survey (Static):",
                  style: TextStyle(fontSize: 14),
                ),
                // ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: TextButton.icon(
              //     icon: Icon(Icons.assignment_returned),
              //     label: Text("GET imageList FROM Firebase"),
              //     onPressed: () => getFriendsList(), //(ImageSource.gallery),
              //   ),
              // ),
              //       StreamBuilder(
              // stream: FirebaseFirestore.instance.collection("questions").snapshots(),
              // builder: (context, snapshot) {
              //   if (!snapshot.hasData) {
              //     print("No DAta in file");
              //     // return null);
              //   }
              //   return ListView.builder(
              //     itemCount: snapshot.data.['']document.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       Map<dynamic, dynamic> map = snapshot.data.documents[index];
              //       return ListTile(
              //         title: Text(map.values.toList()[index]["coinlink"]),
              //       );
              //     },
              //   );
              // }),

              // SingleChildScrollView(
              //   physics: ScrollPhysics(),
              //   child: Expanded(
              //     child: StreamBuilder(
              //       stream: FirebaseFirestore.instance
              //           .collection('questions')
              //           // .where('items', arrayContains: UserInfoData.userID)
              //           // .where(document, isEqualTo: 'cV1Ht0R8VifDs89kGbVZ')
              //           .snapshots(),
              //       builder:
              //           (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              //         switch (streamSnapshot.connectionState) {
              //           case ConnectionState.waiting:
              //             return Center(
              //               child: CircularProgressIndicator(),
              //             );

              //           default:
              //             if (streamSnapshot.hasError) {
              //               print(streamSnapshot.hasError.toString());
              //             } else {
              //               final questions = streamSnapshot.data!.docs;
              //               if (questions.isEmpty) {
              //                 return Text('ff');
              //               } else
              //                 return ListView.builder(
              //                   itemCount: questions.length,
              //                   itemBuilder: (context, i) => ListTile(
              //                     leading: CircleAvatar(
              //                         // backgroundImage: NetworkImage(
              //                         //     questions[i]['items']['downloadUrl']),
              //                         ),
              //                     title: Text(
              //                         questions[i]['items']['downloadUrl']),
              //                     subtitle: Text("HELLO"),
              //                   ),
              //                 );
              //             }
              //         }
              //         return Text('ok');
              //       },
              //     ),
              //   ),
              // ),
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

void SaveNestedData() {
  Exercise exercise = Exercise("Champins league Final winner?", "Who Wins?");
  FirebaseFirestore.instance
      .collection("questions")
      .doc("4DNTipoOB6GqnGP31dyc")
      .set(exercise.toMap());
}

void AddObjectToArray() {
  Set set = Set("https://www.google.com/", 15);
  FirebaseFirestore.instance
      .collection("questions")
      .doc("4DNTipoOB6GqnGP31dyc")
      .update({
    "sets": FieldValue.arrayUnion([set.toMap()])
  });
}

//  List<String> imgName = [];
List<Set> log = [];

// void ReadNestedData() {
//     Exercise exercise;
//     FirebaseFirestore.instance.collection("questions").doc("4DNTipoOB6GqnGP31dyc").get().then((docSnapshot) =>
//     {
//       exercise = Exercise.fromMap(Snapshot.data),
//       exercise.sets.forEach((set) {
//         Set setInst = set as Set;
//         log("Sets :" + setInst.downloadUrl.toString());
//       })
//     });
//   }

void ReadNestedData() {
  // Exercise ex;
  FirebaseFirestore.instance
      .collection("questions")
      // .doc("4DNTipoOB6GqnGP31dyc")
      .doc("cV1Ht0R8VifDs89kGbVZ")
      .get()
      .then((docSnapshot) => {
            print(
              docSnapshot.data(),
            ),
          });
}
