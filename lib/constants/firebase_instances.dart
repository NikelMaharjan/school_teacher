import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseInstances{

  static FirebaseAuth firebaseAuth= FirebaseAuth.instance;
  static FirebaseMessaging firebaseMessaging= FirebaseMessaging.instance;
  static FirebaseFirestore fireStore= FirebaseFirestore.instance;


}