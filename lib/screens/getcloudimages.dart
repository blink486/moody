// import 'package:cloud_firestore/cloud_firestore.dart';

// class Exercise {
//   final String name;
//   final String muscle;
//   List<dynamic> sets = [
//     // {"reps": 10, "weight": 40},
//     // {"reps": 10, "weight": 40},
//     // {"reps": 10, "weight": 40}
//   ];

//   Exercise(this.name, this.muscle);

//   Map<String, dynamic> toMap() =>
//       {"name": this.name, "muscle": this.muscle, "sets": this.sets};

// //   Food.fromMap(Map<String, dynamic> data) {
// //     id = data['id'];
// //     name = data['name'];
// //     category = data['category'];
// //     image = data['image'];
// //     subIngredients = data['subIngredients'];
// //     createdAt = data['createdAt'];
// //     updatedAt = data['updatedAt'];
// //   }

// }

// Future<void> SaveNestedData() async {
//   Exercise exercise = Exercise("Tricep Extension", "Triceps");
//   await FirebaseFirestore.instance
//       .collection("exercises")
//       .doc()
//       .set(exercise.toMap());
// }


// class Exercise {
//   final String f01surveyname;
//   final String f02surveydescription;
//   List<dynamic> sets = [];

//   Exercise(this.f01surveyname, this.f02surveydescription);

//   Map<String, dynamic> toMap() => {"f01surveyname": this.f01surveyname, "f02surveydescription": this.f02surveydescription, "sets": firestoreSets()};

//   List<Map<String,dynamic>> firestoreSets() {
//     List<Map<String,dynamic>> convertedSets = [];
//     this.sets.forEach((set) {
//       Set thisSet = set as Set;
//       convertedSets.add(thisSet.toMap();
//     });
//     return convertedSets;
//   }

//   Exercise.fromMap(Map<dynamic, dynamic> map, this.f01surveyname, this.f02surveydescription)
//       : f01surveyname = map['f01surveyname'],
//         f02surveydescription = map['f02surveydescription'],
//         sets = map['sets'].map((set) {
//           return Set.fromMap(set);
//         }).toList();
// }





// class Food {
//   String id;
//   String name;
//   String category;
//   String image;
//   List subIngredients = [];
//   Timestamp createdAt;
//   Timestamp updatedAt;


//   Food();

//   Food.fromMap(Map<String, dynamic> data) {
//     id = data['id'];
//     name = data['name'];
//     category = data['category'];
//     image = data['image'];
//     subIngredients = data['subIngredients'];
//     createdAt = data['createdAt'];
//     updatedAt = data['updatedAt'];
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'category': category,
//       'image': image,
//       'subIngredients': subIngredients,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt
//     };
//   }
// }