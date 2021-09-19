import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String type;
  final DateTime date;

  Event({this.type, this.date});
}

List<Event> EventTypeListFromEventList(List eventList) {
  // returns a list of events of this class from the event_list from the firebase
  return eventList
      .map((event) => Event(type: event['type'], date: event['date'].toDate()))
      .toList();
}
