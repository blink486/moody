import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moodclicks/model/classExercise.dart';
import 'package:moodclicks/model/surveymodel.dart';
import 'package:moodclicks/screens/getcloudimages.dart';
import 'package:moodclicks/services/createinitsurvey.dart';
import 'package:moodclicks/services/getdatalist.dart';

import 'classsample.dart';

class QList extends StatefulWidget {
  const QList({Key? key}) : super(key: key);

  @override
  _QListState createState() => _QListState();
}

class _QListState extends State<QList> {
//  Future uploadListToFire() async {
//     // FirebaseFirestore.instance.collection("questions").doc().update(
//     final _fireStore = FirebaseFirestore.instance;
//     List<Set> surveyItem = [];

//     print(widget.name);

//     // for (int j = 0; j < imgMapList.length; j++) print(j);
//     for (int i = 0; i < imgMapList.length; i++)
//       surveyItem.add({
//         "votes": imgMapList.toList()[i]['votes'],
//         "downloadUrl": imgMapList.toList()[i]['downloadUrl'].toString(),
//       });

//     // var snapshot =
//     await _fireStore.collection('questions').doc('cV1Ht0R8VifDs89kGbVZ').set({
//       'f01surveyname': widget.name,
//       "f02surveydescription": widget.description,
//       "items": FieldValue.arrayUnion(surveyItem),
//       // "f0xdloadUerl": imgMapList[i]['downloadUrl'],
//     });
//   }

  // var mydocument;
  // final loggedInUser = FirebaseAuth.instance.currentUser!.uid.toString();

  Future<List<SurveyZ>> getAllData() async {
    var val = await FirebaseFireStore.collection("questions").snapshots;
    //  Get the list of docs not just : .doc('wSqZnjShS4OKd3AeUTPD');
    var documents = val.documents;
    print("Documents ${documents.length}");
    if (documents.length > 0) {
      try {
        print("Active ${documents.length}");
        return documents.map((document) {
          SurveyZ bookingList =
              SurveyZ.fromJson(Map<String, dynamic>.from(document.data));

          print(bookingList);

          return bookingList;
        }).toList();
      } catch (e) {
        print("Exception $e");
        return [];
      }
    }
    return [];
  }

  Future<List<SurveyZ>> getOneData() async {
    var val = await FirebaseFireStore.collection("questions").snapshots;
    //  Get the list of docs not just : .doc('wSqZnjShS4OKd3AeUTPD');
    var documents = val.documents;
    print("Documents ${documents.length}");
    if (documents.length > 0) {
      try {
        print("Active ${documents.length}");
        return documents.map((document) {
          SurveyZ bookingList =
              SurveyZ.fromJson(Map<String, dynamic>.from(document.data));

          print(bookingList);

          return bookingList;
        }).toList();
      } catch (e) {
        print("Exception $e");
        return [];
      }
    }
    return [];
  }

  late Sample smp;

  // Future<Sample> _loadAStudentAsset() async {
  Future<Sample> _getDocsFromFire() async {
    Sample smpnull;
    var val = await FirebaseFireStore.collection("sample")
        .docs('iE5dR2daVHv7BZ8LSvCh')
        .snapshots;
    var documentsm = val.documents;
    if (documentsm.hasData) {
      try {
        print("Active ${documentsm.length}");
        return documentsm.map((document) {
          // Sample bookingList =

          smp = Sample.fromJson(Map<String, dynamic>.from(document.data));

          print(smp);

          return smp;
        }).toList();
      } catch (e) {
        print("Exception $e");
        return smp;
      }
    }
    return smp;
  }

  late Sample valf;

  // Stream<List<Sample>> getSomeoneCommentsList({@required String sellerId}) {
  Stream<List<Sample>> getSomeoneCommentsList() {
    return FirebaseFireStore.collection('sample')
        .where('name', isEqualTo: 'Ivan')
        .snapshots()
        .map((qSnap) =>
            qSnap.docs.map((doc) => Sample.fromJson(doc.data())).toList());
  }

// Future<Sample> getValue(String id) async {
//   final CollectionReference usersCollection =
//       FirebaseFirestore.instance.collection('sample');

//   return Sample.fromSnapshot(
//       await usersCollection.doc('iQkfaDnPAag5nK22Z2QH').get());
// }

  // Stream<QuerySnapshot> getData() async {
  //   // FirebaseUser user = await FirebaseAuth.instance.currentUser();
  //   var val = await FirebaseFireStore.collection('questions')
  //       // .where("userId", isEqualTo: user.uid)
  //       // .orderBy('upload time', descending: true)
  //       .snapshots();
  // }

  final db = FirebaseFirestore.instance;
  final databaseReference = FirebaseFirestore.instance;
  final ui = UserInformation();
  // late final Sample sample;
  late Future<List<Sample>> sampla;
  List<Sample> sample_b = [];
//  final List<Sample> samaple = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parsing Json"),
      ),
      // resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "SHOW Json TO and From",
                        style: TextStyle(fontSize: 18, color: Colors.pink),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // Exercise ex;
                    var mydocument = await FirebaseFirestore.instance
                        .collection("questions")
                        // .doc("4DNTipoOB6GqnGP31dyc")
                        .doc("cV1Ht0R8VifDs89kGbVZ")
                        .get();
                    // .then((docSnapshot) => {
                    //       print(
                    //         docSnapshot.data(),
                    //       ),
                    //     });

                    print('pic pRESSED');
                    // print(mydocument.toString());
                    print(
                        'We sent the verification link to ${mydocument['f01surveyname']}.');
                    print(mydocument);
                  },
                  child: Text('Hello: Press Me'),
                ),
                TextButton(
                  onPressed: () async {
                    // Exercise ex;
                    // final _database = FirebaseFirestore.instance;
                    // var mydocument = await _database
                    //     .collection("questions")
                    //     // .doc("4DNTipoOB6GqnGP31dyc")
                    //     .get();
                    // // .doc("wSqZnjShS4OKd3AeUTPD");
                    // // .get();
                    // var docs = mydocument;
                    // print(Snapshot.toString());
                    // .then((docSnapshot) {
                    // for (var i = 0; i <= docSnapshot.data()!.length; i++) {
                    //   print(docSnapshot.data()![i.toString()]['name'].toString());

                    // var surveyobj =
                    //     SurveyZ.fromJson(docSnapshot.data()![i.toString()]);
                    // print(surveyobj.toString());
                    // print(docSnapshot.toString());
                    // }

                    // });
                    // final _reference = await FirebaseFirestore.instance
                    //     .collection('questions')
                    //     .snapshots();

                    // print(snapshots.toString());
                    // .then((value) => {
                    //       print(value.data()),

                    // ADD CODE HERE TO GENERATE SurveyZ.fromJson(json)
                    // }                            )
                    // ;
                    // var snapshot = await _reference;
                    // print(snapshot);

                    // getAllData();

                    print('pic PRESSED 2');
                    getAllData();
                    // print(mydocument.toString());
                    // print(
                    //     'We sent the verification link to ${mydocument['f01surveyname']}.');
                    // print(mydocument);
                  },
                  child: Text('Hello: Press Me2'),
                ),
                SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: db.collection('sample').snapshots(),
                    builder: (context, snapshot) {
                      List<SurveyZ> srvList = [];
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else
                        return ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((doc) {
                            return Card(
                              child: ListTile(
                                // title: Text(doc.data()!.toString()),
                                // title: Text(SurveyZ.data()!.toString()),
                                title: Text(doc['name']),
                                subtitle: Text(doc['surveyDesc']),
                              ),
                            );
                          }).toList(),
                        );
                    },
                  ),
                ),
                // StreamBuilder(
                //     stream: FirebaseFirestore.instance
                //         .collection('users')
                //         .doc('ItpNRR6uNfl4Mf4qvlIa')
                //         .collection('questions')
                //         .snapshots()
                //         .map((snapshot) => snapshot.docs
                //             .map((doc) => SurveyZ.fromJson(doc.data()))
                //             .toList()),
                //     builder: ((context, snapshot) {
                //       ListView.builder(
                //           itemCount: 10,
                //           itemBuilder: (context, index) {
                //             // return something for every item in the list
                //             return Text('Hello');
                //           });
                //     })),

                //         StreamBuilder<QuerySnapshot>(
                //   stream:  FirebaseFirestore.instance
                //                 .collection('questions')
                //                 .snapshots(),
                //   builder: (BuildContext context,
                //       AsyncSnapshot<QuerySnapshot> snapshot) {
                //     if (snapshot.hasError)
                //       return new Text('Error: ${snapshot.error}');
                //     switch (snapshot.connectionState) {
                //       case ConnectionState.waiting:
                //         return new Text('Loading...');
                //       default:
                //         return new ListView(
                //           children: snapshot.data.
                //               .map((DocumentSnapshot document) {
                //             return new CustomCard(
                //               name: document['name'],
                //               phone: document['phno'],

                //             );
                //           }).toList(),
                //         );
                //     }
                //   },
                // ),

                // FutureBuilder<SurveyZ>(
                //   future: getAllData,
                //   builder: (
                //     BuildContext context,
                //     AsyncSnapshot<SurveyZ> snapshot,
                //   ) {
                //     print(snapshot.connectionState);
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return CircularProgressIndicator();
                //     } else if (snapshot.connectionState ==
                //         ConnectionState.done) {
                //       if (snapshot.hasError) {
                //         return const Text('Error');
                //       } else if (snapshot.hasData) {
                //         return
                //             // Text(snapshot.data);
                //           Text(snapshot.data!.name);
                //             ;
                //       } else {
                //         return const Text('Empty data');
                //       }
                //     } else {
                //       return Text('State: ${snapshot.connectionState}');
                //     }
                //   },
                // )
                SingleChildScrollView(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('sample')
                        // .where('participants', arrayContains: UserInfoData.userID)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      switch (streamSnapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );

                        default:
                          if (streamSnapshot.hasError) {
                            print(streamSnapshot.hasError.toString());
                          } else {
                            final survey = streamSnapshot.data!.docs;
                            if (survey.isEmpty) {
                              return Text('ff');
                            } else
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: survey.length,
                                itemBuilder: (context, i) => ListTile(
                                  // TODO: Need to Add Image Url/OR Deal with error for all objects otherwise the onse without image field create Error
                                  // leading: CircleAvatar(
                                  //   backgroundImage:
                                  //       NetworkImage(survey[i]['image']),
                                  // ),
                                  // String name = survey[i]['surveyDesc'];
                                  title: Text(survey[i]['name']),
                                  subtitle: Text(survey[i]['surveyDesc']),
                                ),
                              );
                          }
                      }
                      return Text('ok');
                    },
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     // getQDocs();
                //     print(
                //         'Stream From Firebase Started to create a listview of the data above');
                //   },
                //   child: Text(
                //       'Pull Stream From Firebase and Create List VIEW Above'),
                // ),
                TextButton(
                  onPressed: () {
                    getQDocs();
                    // print(_postList[0].name);
                  },
                  child: Text(
                      'Load Full Stream FROM Firebase INTO a List of Type SurveyZ'),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: 500,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      // Let the ListView know how many items it needs to build.
                      itemCount: _postList.length,
                      // Provide a builder function. This is where the magic happens.
                      // Convert each item into a widget based on the type of item it is.
                      itemBuilder: (context, index) {
                        final item = _postList[index];

                        return ListTile(
                          // title: Text('Sports ${_postList[index].name}'),
                          title: Text(item.name),
                          subtitle: Text(item.name),
                        );
                      },
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     print(_postList[0].name);
                //   },
                //   child: Text('Hello: Press Me 5 LIST print'),
                // ),
                TextButton(
                  onPressed: () {
                    print(_postList.length);
                    List<Sample> abn = [];
                    getSomeoneCommentsList();
                  },
                  child: Text('How may in the List?'),
                ),
                TextButton(
                  onPressed: () {
                    // print(_postList.length);
                    clearList();
                  },
                  child: Text('Hello: Press Me 7 CLear the LIST print'),
                ),
                TextButton(
                  onPressed: () {
                    print("New Exercise Doc Added to Firebase");
                    // SaveNestedData();
                  },
                  child: Text('Add Exercide Doc to FIREBASE'),
                ),
                TextButton(
                  onPressed: () {
                    print("New Exercise.set  Doc Added to Firebase");

                    AddObjectToArray();
                  },
                  child: Text('Add Exercide SET Array to Doc to FIREBASE'),
                ),
                Center(
                  child: Text('NEw Class Belwo'),
                ),
//                 TextButton(
//                   onPressed: () {
//                     print("New Exercise.set  Doc Added to Firebase");
//                 FirebaseFirestore rootRef = FirebaseFirestore.instance;

// CollectionReference applicationsRef = rootRef.collection("sample");
// DocumentReference applicationIdRef = applicationsRef.doc('mAIkXXv96LFqQvlXq8ty');
// applicationIdRef.get().addOnCompleteListener(task -> {
//     if (task.isSuccessful()) {
//         DocumentSnapshot document = task.getResult();
//         if (document.exists()) {
//             List<Map<String, Object>> users = (List<Map<String, Object>>) document.get("users");
//         }
//     }
// });
//                   },
//                   child: Text('Add Exercide SET Array to Doc to FIREBASE'),
//                 ),
                // TextButton(
                //   onPressed: () {
                //     print("New Exercise.set  Doc Added to Firebase");

                //     AddObjectToArray_a();
                //   },
                //   child: Text('Add Exercide SET ArrayArray to Doc to FIREBASE'),
                // ),
                Center(
                  child: SingleChildScrollView(
                    child: SizedBox(height: 500, child: ui.build(context)),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    //  var firebaseUser =  FirebaseAuth.instance.currentUser;
                    DocumentSnapshot docitem =
                        await FirebaseFireStore.collection("sample")
                            .doc('iE5dR2daVHv7BZ8LSvCh')
                            .get()
                        //     .then((value) {
                        //   // print(value.data());
                        //   Sample.fromJson(value);
                        // });
                        ;
                    print(docitem.toString());
                  },
                  child: Text('some yrd'),
                ),
                // TextButton(
                //   onPressed: () async {
                //     DocumentSnapshot variable = await FirebaseFirestore.instance
                //         .collection('sample')
                //         .doc('iE5dR2daVHv7BZ8LSvCh')
                //         .get()((variable) async {
                //       Sample.fromJson(variable);
                //     });

                //     print('Doc Id is: ' + variable.id);
                //     print(variable['name']);
                //   },
                //   child: Text('some yrd'),
                // ),
                // TextButton(
                //   onPressed: () {
                //     print(AddObject());
                //     // print(_postList[0].name);
                //   },
                //   child: Text(
                //       'Load Full Stream FROM Firebase INTO a List of Type SurveyZ'),
                // ),
                TextButton(
                  onPressed: () async {
                    Sample sam;
                    DocumentSnapshot variable = await FirebaseFirestore.instance
                        .collection('sample')
                        .doc('iE5dR2daVHv7BZ8LSvCh')
                        .get();
                    // .then((variable) =>  Map<String, dynamic> toMap(variable)));

                    // print('Doc Id is: ' + variable.name);
                    // print(variable['name']);
                    print('HELOOS');

                    print(variable['name']);
                  },
                  child: Text("See Debug Console for output!"),
                ),
                TextButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("sample")
                        .where("name", isEqualTo: "Ivan")
                        .get()
                        .then((value) {
                      value.docs.forEach((result) {
                        // print(result.data());

                        Sample smg = Sample.fromJson(result.data());
                        print(smg.name);
                        smp = smg;
                      });
                    });
                  },
                  child: Text("See Debug Console for output! IVAN AGAIN"),
                ),
                TextButton(
                  onPressed: () {
                    print(smp.surveyDesc);
                    print(smp.name);
                  },
                  child: Text(
                      "See Debug Console for output! IVAN PRINT GLOBALAGAIN"),
                ),
                TextButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("sample")
                        .where("name", isEqualTo: "Ivan")
                        .get()
                        .then((value) {
                      value.docs.forEach((result) {
                        // print(result.data());

                        Sample smg = Sample.fromJson(result.data());
                        print(smg.name);
                        smp = smg;
                      });
                    });
                  },
                  child: Text("See Debug Console for output! IVAN AGAIN"),
                ),
                // Center(child: Text('hello${smp.surveyDesc}')),

                // TextButton(
                //   onPressed: () {
                //     final CollectionReference usersCollection =
                //         FirebaseFirestore.instance.collection('sample').snapshots();

                //         Sample.fromSnapshot(usersCollection
                //           .doc('iQkfaDnPAag5nK22Z2QH')
                //           .get();
                //     }
                //     // DocumentSnapshot variable = await FirebaseFirestore.instance
                //     //     .collection('sample')
                //     //     .doc('iE5dR2daVHv7BZ8LSvCh')
                //     //     .get();
                //     // // .then((variable) =>  Map<String, dynamic> toMap(variable)));

                //     // // print('Doc Id is: ' + variable.name);
                //     // // print(variable['name']);
                //     // print('HELOOS');

                //     print(ag.surveyDesc);
                //   },
                //   child: Text("See Debug Console for output!"),
                // ),
              ]),
        ),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

Widget _myListView(BuildContext context) {
  // backing data
  // final europeanCountries = ['Albania', 'Andorra', 'Armenia', 'Austria',
  //   'Azerbaijan', 'Belarus', 'Belgium', 'Bosnia and Herzegovina', 'Bulgaria',
  //   'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland',
  //   'France', 'Georgia', 'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland',
  //   'Italy', 'Kazakhstan', 'Kosovo', 'Latvia', 'Liechtenstein', 'Lithuania',
  //   'Luxembourg', 'Macedonia', 'Malta', 'Moldova', 'Monaco', 'Montenegro',
  //   'Netherlands', 'Norway', 'Poland', 'Portugal', 'Romania', 'Russia',
  //   'San Marino', 'Serbia', 'Slovakia', 'Slovenia', 'Spain', 'Sweden',
  //   'Switzerland', 'Turkey', 'Ukraine', 'United Kingdom', 'Vatican City'];

  return ListView.builder(
    itemCount: _postList.length,
    itemBuilder: (context, index) {
      return ListTile(
        // title: Text(_postList['name'].[index]),

        title: Text('Sports ${_postList[index].name}'),
      );
    },
  );
}

List<SurveyZ> serv = [];

// Future<void> buildData(AsyncSnapshot snapshot) async {
//   if (snapshot.data.documents.length == 0) {
//     serv = [];
//   }

//   serv = [];
//   await Future.forEach(snapshot.data.documents, (element) {
//     serv.add(SurveyZ.fromJson(element));
//   });
// }

// Future getFoodType1Cloud() async {
//   QuerySnapshot snapshot =
//    await FirebaseFirestore.instance.collection("sample").get();
//   snapshot.docs.forEach(snapshot => {
//    Map<String, dynamic> SurveyZ.toJson = doc.data;
//   // convert this Map to your custom object and add it to your list
// });
// }

// Future getFoodType31Cloud() async {
//   QuerySnapshot snapshot =
// await FirebaseFirestore.instance
//   .collection('sample')
//   // .document(documentId)
//   .get().then((value) {
//     print("hello");
//   });
// }

Future getuDocs() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("sample").get();

  for (int i = 0; i < querySnapshot.size; i++) {
    var a = querySnapshot.docs[i];
    print(a.data());
    print("HELOOS 1");
    print(a.data().toString());
    // var doca = SurveyZ.fromJson(json.decode(querySnapshot.docs.toString()));
    var doca = SurveyZ.fromJson(json.decode(a.data().toString()));
    // querySnapshot.docs.map(json.decode()));
    print("HELOOS" + doca.surveyDesc);
  }
}

// >>>>>>>>>>>>>   WORKING VERSION: TURN basic FirebaseFirestore data into Class OBjects - TODO: Add List Object to Classes START

List<SurveyZ> _postList = [];

Future<List<SurveyZ>> getQDocs() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("sample").get();
  // TODO: ADD IF NOT DATA CHECK ELSE THEN
  for (int i = 0; i < querySnapshot.size; i++) {
    var a = querySnapshot.docs[i];
    print('HAA' + a.get('name'));
    var b = SurveyZ(a.get('name'), a.get('surveyDesc'));
    print(b.surveyDesc);
    _postList.add(b);

    // Map<String, dynamic> map = querySnapshot.docs.first[i];
    // _postList.add(SurveyZ.fromJson(map));
    // debugPrint('Id-------${map['id']}');

  }

  return _postList;
}

// >>>>>>>>>>>>>   WORKING VERSION: END

void clearList() {
  print('Clearing List of Values: {$_postList.length}');

  _postList.clear();
}

// Widget buildFoodList(List foods) {
//     return Expanded(
//       child: GridView.builder(
//         itemCount: foods.length,
//         physics: BouncingScrollPhysics(),
//         gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.8,
//           mainAxisSpacing: 20,
//           crossAxisSpacing: 20,
//         ),
//         itemBuilder: (context, index) {
//           return Card(foods[index]);
//         },
//       ),
//     );
//   }

// Future<List<SurveyZ>> getAllData() async {
//   print("Active Users");
//   var val = await FirebaseFireStore.collection("questions").getDocuments();
//   var documents = val.documents;
//   print("Documents ${documents.length}");
//   if (documents.length > 0) {
//     try {
//       print("Active ${documents.length}");
//       return documents.map((document) {
//         SurveyZ bookingList =
//             SurveyZ.fromJson(Map<String, dynamic>.from(document.data));

//         return bookingList;
//       }).toList();
//     } catch (e) {
//       print("Exception $e");
//       return [];
//     }
//   }
//   return [];
// }

class FirebaseFireStore {
  static collection(String s) {}
}

class FIrebaseFirestore {}

// FirebaseFirestore.instance
//     .collection("questions")
//     // .doc("4DNTipoOB6GqnGP31dyc")
//     .doc("cV1Ht0R8VifDs89kGbVZ")
//     .get()
//     .then((docSnapshot) => {
//           print(
//             docSnapshot.data(),
//           ),
//         });

// SEPERATE THESE CLASES BELOW TO INDIVIDUAL DART FILES

// class User {
//   final String f01surveyname;
//   final String f02surveydescription;

//   User(this.f01surveyname, this.f02surveydescription);

//   User.fromJson(Map<String, dynamic> json)
//       : f01surveyname = json['f01surveyname'],
//         f02surveydescription = json['f02surveydescription'];

//   Map<String, dynamic> toJson() => {
//         'f01surveyname': f01surveyname,
//         'f02surveydescription': f02surveydescription,
//       };
// }

class RecipeList {
  List<SurveyZ> surveyList;

  RecipeList(this.surveyList);
}

// class Network async {

//   final  val = await FirebaseFireStore.collection(
//         "questions");

// }

// VERSION1:
// ignore: non_constant_identifier_names
// Future<void> SaveNestedData() async {
//   await FirebaseFirestore.instance.collection("exercises").add({
//     "name": "Dumbbell curl",
//     "muscle": "Biceps",
//     "sets": {"reps": 10, "weight": 40}
//   });
// }

// VERSION2:
// ignore: non_constant_identifier_names
// Future<void> SaveNestedData() async {
//   await FirebaseFirestore.instance.collection("exercises").add({
//     "name": "Dumbbell curl",
//     "muscle": "Biceps",
//     "sets": [
//       {"reps": 10, "weight": 40},
//       {"reps": 10, "weight": 40},
//       {"reps": 10, "weight": 40}
//     ]
//   });
// }

// VERSION3:
// Future<void> SaveNestedData() async {
//   Exercise exercise = Exercise("Tricep Extension", "Triceps");
//   await FirebaseFirestore.instance
//       .collection("exercises")
//       .doc()
//       .set(exercise.toMap());
// }

// ignore: non_constant_identifier_names
// Future<void> SaveNestedData() async {
//   Exercise exercise = Exercise("Tricep Extension", "Triceps");
//   await FirebaseFirestore.instance
//       .collection("exercises")
//       .doc("pc4rmnEUhziXZmvkAwSq")
//       .set(exercise.toMap());
// }

// ignore: non_constant_identifier_names
Future<void> AddObjectToArray() async {
  Set set = Set(10, 35);
  await FirebaseFirestore.instance
      .collection("exercises")
      .doc("pc4rmnEUhziXZmvkAwSq")
      .update({
    "sets": FieldValue.arrayUnion([set.toMap()])
  });
}

// void AddObjectToArray_a() {
//   Set set = Set(12, 40);
//   Exercise exercise;
//   Set newSet;
//   FirebaseFirestore.instance
//       .collection("exercises")
//       .doc("pc4rmnEUhziXZmvkAwSq")
//       .get()
//       .then((docSnapshot) => {
//             newSet = Set(10, 30),
//             exercise = Exercise.fromMap(docSnapshot.data),
//             exercise.sets.add(newSet),
//             FirebaseFirestore.instance
//                 .collection("exercises")
//                 .doc("pc4rmnEUhziXZmvkAwSq")
//                 .set(exercise.toMap())
//           });
// }

// void ReadNestedData() {
//   Set set;
//   FirebaseFirestore.instance
//       .collection("exercises")
//       .doc("OWXsZjJRy3jjWmaM3Rup")
//       .get()
//       .then((docSnapshot) => {
//             set = Set.fromMap(docSnapshot.data['sets'][0]),
//             log("Data :" + docSnapshot.data.toString()),
//             log("Reps: " + set.reps.toString())
//           });
// }

// ignore: non_constant_identifier_names
// Future<void> ReadNestedData() async {
//     Exercise exercise; await
//     FirebaseFirestore.instance
//     .collection("exercises")
//     .doc("pc4rmnEUhziXZmvkAwSq")
//     .get().then((docSnapshot) =>
//     {
//       exercise = Exercise.fromMap(docSnapshot),
//       exercise.sets.forEach((set) {
//         Set setInst = set as Set;
//         log("Reps :" + setInst.reps.toString());
//       })
//     });
//   }

// Future<void> AddObjectToArray_A() async {
//     Set set = Set(12, 40);
//     Exercise exercise;
//     Set newSet;
//     FirebaseFirestore.instance
//         .collection("exercises")
//         .doc("pc4rmnEUhziXZmvkAwSq")
//         .get()
//         .then((docSnapshot) => {
//       newSet = Set(10, 30),
//       exercise = Exercise.fromMap(docSnapshot.docs),
//       exercise.sets.add(newSet),
//       FirebaseFirestore.instance.collection("exercises")
//       .doc("pc4rmnEUhziXZmvkAwSq")
//       .set(exercise.toMap())});
//   }

// ignore: non_constant_identifier_names
Future<void> ReadNestedData_B() async {
  await FirebaseFirestore.instance
      .collection("exercises")
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      FirebaseFirestore.instance
          .collection("exercises")
          .doc(result.id)
          .collection("exercises")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          print(result.data());
        });
      });
    });
  });
}

// Future<void> ReadNestedData_C() async {
//     Exercise exercise; await
//     FirebaseFirestore.instance
//     .collection("exercises")
//     .doc("pc4rmnEUhziXZmvkAwSq")
//     .get().then((docSnapshot) =>
//     {
//       exercise = Exercise.fromMap(docSnapshot.data()),
//       exercise.sets.forEach((set) {
//         Set setInst = set as Set;
//         log("Reps :" + setInst.reps.toString());
//       })
//     });
//   }

// ignore: non_constant_identifier_names
// Future<void> AddObject() async {
//   Stream<Sample?> curUserData() {
//     return FirebaseFirestore.instance
//         .collection('sample')
//         .doc('iQkfaDnPAag5nK22Z2QH')
//         .snapshots()
//         .map((DocumentSnapshot<Map<String, dynamic>> snapshot) =>
//             Sample.fromJson(snapshot.data()!));
//   }

//   // print(curUserData);
// }

// class DatabaseService {
//   final CollectionReference usersCollection =
//       FirebaseFirestore.instance.collection('sample');

//   Future<Sample> getUser(String id) async {
//     return Sample.fromSnapshot(
//         await usersCollection.doc('iQkfaDnPAag5nK22Z2QH').get());
//   }
// }

Future<Sample> getValue(String id) async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('sample');

  return Sample.fromSnapshot(
      await usersCollection.doc('iQkfaDnPAag5nK22Z2QH').get());
}

// Future<String> getValue() async {
//   await Future.delayed(Duration(seconds: 3));

//   return 'Woolha';
// }

class FutureBuilderExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FutureBuilderExampleState();
  }
}

class _FutureBuilderExampleState extends State<FutureBuilderExample> {
  late Future<String> _value;

  @override
  initState() {
    super.initState();
    _value = getValue('iQkfaDnPAag5nK22Z2QH') as Future<String>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Woolha.com Flutter Tutorial'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: FutureBuilder<String>(
            future: _value,
            initialData: 'App Name',
            builder: (
              BuildContext context,
              AsyncSnapshot<String> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Visibility(
                      visible: snapshot.hasData,
                      child: Text(
                        snapshot.data!,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Text(snapshot.data!,
                      style: const TextStyle(color: Colors.teal, fontSize: 36));
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
        ),
      ),
    );
  }
}
