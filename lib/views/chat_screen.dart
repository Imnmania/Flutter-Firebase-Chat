import 'package:flutter/material.dart';
import 'package:flutter_chat_firebase_2/helperFunctions/sharedpref_helper.dart';
import 'package:flutter_chat_firebase_2/services/database.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithUserName, name;

  ChatScreen({@required this.chatWithUserName, @required this.name});
  //
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //
  String chatRoomId = "";
  String messageId = "";
  String myName, myProfilePic, myUserName, myEmail;

  var messageTextController = TextEditingController();

  // Get Data from SharedPreferences
  getMyInfoFromSharedPref() async {
    myName = await SharedPreferenceHelper().getUserDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfilePicUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    chatRoomId = getChatRoomIdByUserNames(widget.chatWithUserName, myUserName);
  }

  // Generate chatroom ID by using usernames
  getChatRoomIdByUserNames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  // Add Messages
  addMessage(bool sendClicked) {
    if (messageTextController.text != '' || null) {
      String message = messageTextController.text;

      var lastMessageTs = DateTime.now();

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserName,
        "ts": lastMessageTs,
        "profileUrl": myProfilePic
      };

      // messageId
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }

      DatabaseMethods()
          .addMessage(
        chatRoomId,
        messageId,
        messageInfoMap,
      )
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": myUserName
        };

        DatabaseMethods().updateLastMessageSend(chatRoomId, lastMessageInfoMap);

        if (sendClicked) {
          // Remove texts from texfield after sending
          messageTextController.clear();

          // Make the messageId blank to regenerate next msg send
          messageId = "";
          // setState(() {});
        }
      });
    }
  }

  // Get previous messages/ history
  getAndSetMessages() async {}

  // Function for init state
  doThisOnLaunch() async {
    await getMyInfoFromSharedPref();
    getAndSetMessages();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyInfoFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue.withOpacity(0.8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Type a message...",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        onChanged: (value) {
                          addMessage(false);
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        addMessage(true);
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
