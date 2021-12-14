import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late final String? text;
  late final DateTime? date;
  late final String? email;

  DocumentReference? reference;

  Message({this.text, this.date, this.email});

  factory Message.fromJson(Map<dynamic, dynamic> json) {
    return Message(
      text: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
      email: json['email'] as String
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
      'date': date.toString(),
      'text': text,
      'email': email,
    };

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
  final message = Message.fromJson(snapshot.data() as Map<String, dynamic>);
  message.reference = snapshot.reference;
  return message;
  }

  

}
