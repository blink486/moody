import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String name;
  final int totalVotes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map(), {required this.reference})
      : assert(map()['name'] != null),
        assert(map()['totalVotes'] != null),
        name = map()['name'],
        totalVotes = map()['totalVotes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$totalVotes>";
}

class Voters {
  String uid;
  String voteId;
  String markedVoteOption;
}

/// Contains all the data of this [DocumentSnapshot].
Map<String, dynamic> data() {
  return _CodecUtility.replaceDelegatesWithValueInMap(
      _delegate.data(), _firestore);
}
