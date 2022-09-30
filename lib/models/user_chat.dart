import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat/constants/constants.dart';

class UserChat {
  String id;
  String photoUrl;
  String userName;
  String aboutMe;

  UserChat({
    required this.id,
    required this.photoUrl,
    required this.userName,
    required this.aboutMe,
  });

  Map<String, String> toJson() {
    return {
      FirestoreConstants.userName: userName,
      FirestoreConstants.aboutMe: aboutMe,
      FirestoreConstants.photoUrl: photoUrl,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String aboutMe = "";
    String photoUrl = "";
    String userName = "";
    try {
      aboutMe = doc.get(FirestoreConstants.aboutMe);
    } catch (e) {}
    try {
      photoUrl = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {}
    try {
      userName = doc.get(FirestoreConstants.userName);
    } catch (e) {}
    return UserChat(
      id: doc.id,
      photoUrl: photoUrl,
      userName: userName,
      aboutMe: aboutMe,
    );
  }
}
