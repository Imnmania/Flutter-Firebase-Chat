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

  // Adding or sending message
  Future addMessage(String chatRoomId, messageId, Map messageInfoMap) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  // Update Messages in Real Time
  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .set(lastMessageInfoMap);
  }
}
