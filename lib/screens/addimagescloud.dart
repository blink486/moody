// Develop inspired from https://www.youtube.com/watch?v=pvRpzyBYBbA

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UploadImages extends StatefulWidget {
  const UploadImages({Key? key}) : super(key: key);

  @override
  _UploadImagesState createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  var imageUrlFire;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Column(
        children: <Widget>[
          (imageUrlFire != null)
              ? Image.network(imageUrlFire)
              : Placeholder(
                  fallbackHeight: 200,
                  fallbackWidth: double.infinity,
                ),
          TextButton(
              child: Text('Upload Image'),
              onPressed: () {
                print('UPLOADING IDNF');
                uploadImage();
                print(imageUrlFire);
              })
        ],
      ),
    );
  }

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
    var file = File(imageCloud.path);
    if (imageCloud != null) {
      final name = basename(imageCloud.path);
      var snapshot =
          await _storage.ref().child('folderName/$name').putFile(file);
      print(snapshot);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      print('DOWNLOAD url');
      print(downloadUrl);
      setState(() {
        imageUrlFire = downloadUrl;
      });
    } else {
      print('No path found');
    }
  }
}
