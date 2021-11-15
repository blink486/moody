import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
// part 'classsample.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated..
// @JsonSerializable()
class Sample {
  Sample({required this.name, required this.surveyDesc});

  final String name;
  final String surveyDesc;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  // factory Sample.fromJson(Map<String, dynamic> json) => _$SampleFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  // Map<String, dynamic> toJson() => _$SampleToJson(this);

  // factory Sample.fromSnapshot(DocumentSnapshot snapshot) =>
  //     _$SampleFromSnapshot(snapshot);

  Sample.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        surveyDesc = json["surveyDesc"];

// Map<String, dynamic> _$SampleToJson(Sample instance) => <String, dynamic>{
//       'name': instance.name,
//       'surveyDesc': instance.surveyDesc,
//     };

  static Sample fromSnapshot(DocumentSnapshot snapshot) {
    return Sample(name: snapshot['name'], surveyDesc: snapshot['surveyDesc']);
  }

  // factory Sample.fromJson(Map<String, dynamic> parsedJson) {
  //   return Sample(
  //       name: parsedJson['name'], surveyDesc: parsedJson['surveyDesc']);
  // }

}
