import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Add user to Firestore database
  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  // Search user from Firestore database
  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .snapshots();
  }
}
