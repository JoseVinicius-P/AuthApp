import 'dart:io';

import 'package:auth/app/shared/interfaces/i_user_data_service.dart';
import 'package:auth/app/shared/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDataService implements IUserDataService{
 @override
  late final FirebaseFirestore db;
 @override
  late final FirebaseStorage storage;
 @override
  late final FirebaseAuth auth;

  UserDataService(this.storage, this.db, this.auth);

 @override
  Future<String> saveProfilePicture(String path) async {
   if(!path.contains('http')){
     final reference = storage.ref().child("profile_pictures/${FirebaseAuth.instance.currentUser!.uid}.jpg");
     try {
       File file = File(path);
       await reference.putFile(file);
       return reference.getDownloadURL();
     } on FirebaseException catch (e) {
       return "";
     }catch(e){
       return "";
     }
   }else{
     return "";
   }
 }

 @override
  Future<bool> saveUserData(ProfileModel user) async {
   try{
     await db.collection("Users")
         .doc(FirebaseAuth.instance.currentUser!.uid)
         .set(user.toFirestore(), SetOptions(merge: true));
     return true;
   }catch(e){
     return false;
   }
 }

 @override
  Future<DocumentSnapshot> getUserData() async{
   DocumentReference docRef = db.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid);
   DocumentSnapshot snapshot = await docRef.get();
   return snapshot;
 }

 @override
  Future<bool> isDataComplete() async {
   DocumentSnapshot snapshot = await getUserData();
   return snapshot.exists;
 }

}