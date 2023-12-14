import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel{
  late String profilePictureUrl;
  late String fullName;
  late String phoneNumber;


  ProfileModel(this.profilePictureUrl, this.fullName, this.phoneNumber);

  ProfileModel.fromDocumentSnapshot(DocumentSnapshot snapshot){
    profilePictureUrl = snapshot.get('profilePictureUrl');
    fullName = snapshot.get('fullName');
    phoneNumber = snapshot.get('phoneNumber');
  }

  Map<String, dynamic> toFirestore() {
    String name = fullName.trim();
    if(name.isNotEmpty && phoneNumber.length == 11){
      return {
        "fullName": name,
        "phoneNumber": phoneNumber,
        "profilePictureUrl": profilePictureUrl
      };
    }else{
      throw Exception("Variable name is empty or phone number invalid");
    }
  }

}