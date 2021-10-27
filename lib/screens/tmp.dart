import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

// class AddQuestions extends StatefulWidget {
//   final String srvCreator;
//   const AddQuestions({Key? key, required this.srvCreator}) : super(key: key);

//   @override
//   _AddQuestionsState createState() => _AddQuestionsState();
// }

class ListImages extends StatefulWidget {
  const ListImages({Key? key}) : super(key: key);

  @override
  _ListImagesState createState() => _ListImagesState();
}

class _ListImagesState extends State<ListImages> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }
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

  int _votes = 0;

  List<File> imgLoc = [];
  List<String> imgLocation = [];
  List<String> imgName = [];

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    print(directory);
    imgLocation.add(basename(imagePath));
    imgName.add(name);
    imgLoc.add(image);
    print("Imahe List Location: ");
    print(imgLocation);
    print("Imahe List Path: ");
    print(imagePath);
    return File(imagePath).copy(image.path);
  }

// class _ListImages extends State<ListImages> {

  List<File> _imageList = [];

  void _addImage(File _image) {
    setState(() {
      _imageList.add(_image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TITLE WID"),
      ),
      body: Column(
        children: <Widget>[
          MaterialButton(
            child: Text("Add Image:  ${_imageList.length}"),
            onPressed: () async {
              var _image = await pickImage(ImageSource.gallery);
              print(_image!.path);
              _addImage(_image);
              print(_imageList);
            },
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _imageList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      return null;
                    },
                    // child: Card(
                    //   child: Container(
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Text(_imageList[index].path),
                    //     ),
                    //   ),
                    // ),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      height: 160,
                      width: 160,
                      child: image == null
                          ? Text('No Image Showing')
                          : Image.file(imgLoc.first),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
