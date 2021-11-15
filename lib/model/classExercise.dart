// import 'package:json_annotation/json_annotation.dart';

// part 'classExercise.g.dart';

// @JsonSerializable()

// class SurveyQ {
//   SurveyQ(this.name, this.surveyDesc);

//   String name;
//   String surveyDesc;
//   //TODO: Keep as Nullable?
//   // final List<QuestionLs>? questions;

//   factory SurveyQ.fromJson(Map<String, dynamic> json) => _$SurveyQFromJson(json);

//   Map<String, dynamic> toJson() => _$SurveyQToJson(this);
// }

// factory Survey.fromJson(dynamic json) {
//   return Survey(json['name'] as String, json['surveyDesc'] as String, Set.fromJson(json['sets']));
// }

// factory SurveyQ.fromJson(Map<String, dynamic> data) {
// note the explicit cast to String
// this is required if robust lint rules are enabled
// final name = data['name'] as String;
// final surveyDesc = data['surveyDesc'] as String;
// cast to a nullable list as the questions may be missing
// final questionsData = data['questions'] as List<dynamic>?;

// final questions = questionsData != null
//     ? questionsData
//         .map((questionData) => QuestionLs.fromJson(questionData))
// map() returns an Iterable so we convert it to a List
// .toList()
// use an empty list as fallback value
// : <QuestionLs>[];

//   return SurveyQ(
//     name: name,
//     surveyDesc: surveyDesc,
//     // questions: questions,
//   );
// }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'surveyDesc': surveyDesc,
//       // if (yearOpened != null) 'year_opened': yearOpened,
//       // 'questions': questions!.map((question) => question.toJson()).toList(),
//     };
//   }
// }

// class QuestionLs {
//   QuestionLs({required this.downloadUrl, required this.votes});
//   // nullable - assuming the downloadUrl field is optional
//   final String? downloadUrl; //TODO: Change back to Required and not optional
//   // non-nullable - assuming the votes field is always present
//   final int votes;

//   Map<String, dynamic> toMap() =>
//       {"downloadUrl": this.downloadUrl, "votes": this.votes};

//   factory QuestionLs.fromJson(Map<dynamic, dynamic> data) {
//     final downloadUrl = data['downloadUrl'] as String;
//     final votes = data['votes'] as int;
//     return QuestionLs(downloadUrl: downloadUrl, votes: votes);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'votes': votes,
//       // here we use collection-if to account for null values
//       if (votes != null) 'votes': votes,
//     };
//   }
// }

// **** OLD CODE PRE Json SERIALISATION

// Map<String, dynamic> toMap() => {
//       "name": this.name,
//       "surveyDesc": this.surveyDesc,
//       "sets": firestoreSets()
//     };

// List<Map<String, dynamic>> firestoreSets() {
//   List<Map<String, dynamic>> convertedSets = [];

//   this.sets.forEach((set) {
//     Set thisSet = set as Set;
//     convertedSets.add(thisSet.toMap());
//   });
//   return convertedSets;
// }

// Survey.fromMap(Map<dynamic, dynamic> map)
//     : name = map['name'],
//       surveyDesc = map['surveyDesc'],
//       sets = map['sets'].map((set) {
//         return Set.fromMap(set);
//       }).toList();
// }

// class Set {
//   final int downloadUrl;
//   final int votes;

//   Set(this.downloadUrl, this.votes);

//   Map<String,dynamic> toMap() => {
//     "downloadUrl": this.downloadUrl,
//     "votes": this.votes
//   };
// }

// class Set {
//   final String downloadUrl;
//   final int votes;

//   Set(this.downloadUrl, this.votes);

//   Map<String, dynamic> toMap() =>
//       {"downloadUrl": this.downloadUrl, "votes": this.votes};

//   Set.fromMap(Map<dynamic, dynamic> map)
//       : downloadUrl = map["downloadUrl"].toString(),
//         votes = map["votes"].toInt();

// factory Set.fromJson(dynamic json) {
// return Set(json['downloadUrl'] as String, json['votes'] as int);
// }
// }

// class Task {
//   String title;
//   bool completed;

//   Task({
//     required this.title,
//     this.completed = false,
//   });

//   Task.fromMap(Map<String, dynamic> map): title = map['title'],completed = map['completed'];

//   updateTitle(title) {
//     this.title = title;
//   }

//   Map toMap() {
//     return {
//       'title': title,
//       'completed': completed,
//     };
//   }
// }

// Future<String> _loadPhotoAsset() async {
//   return await rootBundle.loadString('assets/photo.json');
// }

// Future loadPhotos() async {
//   String jsonPhotos = await _loadPhotoAsset();
//   final jsonResponse = json.decode(jsonPhotos);
//   PhotosList photosList = PhotosList.fromJson(jsonResponse);
//   print("photos " + photosList.photos[0].title);

// class Exercise {
//   final String name;
//   final String muscle;
//   List<dynamic> sets = [
//     {"reps": 10, "weight": 40},
//     {"reps": 20, "weight": 50},
//     {"reps": 30, "weight": 60}
//   ];

//   Exercise(this.name, this.muscle);

//   Map<String, dynamic> toMap() =>
//       {"name": this.name, "muscle": this.muscle, "sets": this.sets};
// }

// SECOND ATTEMPT: 09/11/2021

// class Exercise {
//   final String name;
//   final String muscle;
//   List<dynamic> sets = [];

//   Exercise(this.name, this.muscle);

//   Map<String, dynamic> toMap() =>
//       {"name": this.name, "muscle": this.muscle, "sets": this.sets};

//   Exercise.fromMap(Map<dynamic, dynamic> map)
//       : name = map['name'],
//         muscle = map['muscle'],
//         sets = map['sets'].map((set) {
//           return Set.fromMap(set);
//         }).toList();
// }

class Exercise {
  final String name;
  final String muscle;
  List<dynamic> sets = [];

  Exercise(this.name, this.muscle);

  Map<String, dynamic> toMap() =>
      {"name": this.name, "muscle": this.muscle, "sets": firestoreSets()};

  List<Map<String, dynamic>> firestoreSets() {
    List<Map<String, dynamic>> convertedSets = [];
    this.sets.forEach((set) {
      Set thisSet = set as Set;
      convertedSets.add(thisSet.toMap());
    });
    return convertedSets;
  }

  // Exercise.fromMap(Map<dynamic, dynamic> map)
  //     : name = map['name'],
  //       muscle = map['muscle'],
  //       sets = map['sets'].map((set) {
  //         return Set.fromMap(set);
  //       }).toList();

  Exercise.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        muscle = map['muscle'],
        sets = map['sets'].map((set) {
          return Set.fromMap(set);
        }).toList();

// factory Exercise.fromJson(Map<String, dynamic> json) {
//      return Exercise(
//          name: json['name'],
//          muscle: title = json['title'] != null ? new Title.fromJson(json['title']) : null;
//          link: json['link'].toString()
//         );

  Exercise.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        muscle = json['muscle'],
        sets = json['sets'].json((set) {
          return Set.fromMap(set);
        }).toList();

// factory Exercise.fromMap_A(Map<String, dynamic> map) {
//     return Exercise(
//       // birthday: DateTime.fromMillisecondsSinceEpoch(map['birthday']),
//       // gender: map['gender'],
//       // isDarkMode: map['isDarkMode'],
//       // isMetric: map['isMetric'],
//       // name: map['name'],
//       // password: map['password'],

//         name: map['name'],
//         muscle: map['muscle'],
//         sets map['sets'].map((set) {
//           return Set.fromMap(set);
//         }).toList();

  //   );
  // }

}

class Set {
  final int reps;
  final int weight;

  Set(this.reps, this.weight);

  Map<String, dynamic> toMap() => {"reps": this.reps, "weight": this.weight};

  Set.fromMap(Map<String, dynamic> map)
      : reps = map["reps"].toInt(),
        weight = map["weight"].toInt();
}
