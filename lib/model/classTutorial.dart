// import 'package:json_annotation/json_annotation.dart';

// @JsonSerializable()
// class User {
//   String name;
//   int age;

//   User(this.name, this.age);

//   factory User.fromJson(dynamic json) {
//     return User(json['name'] as String, json['age'] as int);
//   }

//   @override
//   String toString() {
//     return '{ ${this.name}, ${this.age} }';
//   }
// }

// class Tutorial {
//   String title;
//   String description;
//   User author;
//   List<Tag> tags;

//   Tutorial(this.title, this.description, this.author, [this.tags]);

//   factory Tutorial.fromJson(dynamic json) {
//     if (json['tags'] != null) {
//       var tagObjsJson = json['tags'] as List;
//       List<Tag> _tags =
//           tagObjsJson.map((tagJson) => Tag.fromJson(tagJson)).toList();

//       return Tutorial(json['title'] as String, json['description'] as String,
//           User.fromJson(json['author']), _tags);
//     } else {
//       return Tutorial(json['title'] as String, json['description'] as String,
//           User.fromJson(json['author']));
//     }
//   }

//   @override
//   String toString() {
//     return '{ ${this.title}, ${this.description}, ${this.author}, ${this.tags} }';
//   }
// }

// class Tag {
//   String name;
//   int quantity;

//   Tag(this.name, this.quantity);

//   factory Tag.fromJson(dynamic json) {
//     return Tag(json['name'] as String, json['quantity'] as int);
//   }

//   @override
//   String toString() {
//     return '{ ${this.name}, ${this.quantity} }';
//   }
// }
