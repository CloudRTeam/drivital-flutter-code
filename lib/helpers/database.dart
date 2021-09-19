import 'package:flutter_web_dashboard/models/device.dart';
import 'package:flutter_web_dashboard/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  Map<String, dynamic> newDeviceData = {
    'event_list': [],
    'name': 'Default name',
  };
  Map<String, dynamic> emptyMap = {};
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference personCollection =
      FirebaseFirestore.instance.collection('persons');

  Future<void> createUser({String deviceId}) async {
    await personCollection.doc(uid).set(emptyMap);
    return await personCollection
        .doc(uid)
        .collection('devices')
        .doc(deviceId)
        .set(newDeviceData);
  }

  Future<void> addDevice({String deviceId}) async {
    return await personCollection
        .doc(uid)
        .collection('devices')
        .doc(deviceId)
        .set(newDeviceData);
  }

  // brew list from snapshot
  List<Device> _deviceListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      print(doc['name']);
      return Device(
        name: doc['name'] ?? '',
        id: doc.id ?? '',
        event_list: doc['event_list'] ?? [],
      );
    }).toList();
  }

  // user data from snapshots
  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //     uid: uid,
  //     name: snapshot.data['name'],
  //     sugars: snapshot.data['sugars'],
  //     strength: snapshot.data['strength']
  //   );
  // }

  //get devices stream
  Stream<List<Device>> get devices {
    return personCollection
        .doc(uid)
        .collection('devices')
        .snapshots()
        .map(_deviceListFromSnapshot);
  }

  // get user doc stream
  // Stream<UserData> get userData {
  //   return brewCollection.document(uid).snapshots()
  //     .map(_userDataFromSnapshot);
  // }

}
