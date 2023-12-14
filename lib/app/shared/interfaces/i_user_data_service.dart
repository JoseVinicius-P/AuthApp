import 'package:auth/app/shared/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class IUserDataService {
 late final FirebaseFirestore db;
 late final FirebaseStorage storage;
 late final FirebaseAuth auth;

 Future<String> saveProfilePicture(String path);
 Future<bool> saveUserData(ProfileModel user);
 Future<DocumentSnapshot> getUserData();
 Future<bool> isDataComplete();

}