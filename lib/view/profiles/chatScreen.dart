import 'package:beautybazzle/model/addservice/servic_data.dart';
import 'package:beautybazzle/model/signup_login/signup_model.dart';
import 'package:beautybazzle/utiils/static_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController msgController = TextEditingController();

  void onsendMessage() async {
    if (msgController.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": StaticData.userModel!.name,
        'message': msgController.text,
        'time': FieldValue.serverTimestamp(),
        'type': 'textmsg',
      };
      await FirebaseFirestore.instance
          .collection('chatroom')
          .doc(widget.chatId)
          .collection('Chats')
          .add(messages);
      msgController.clear();
    } else {
      print('Enter Some Text');
    }
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    bool isMe = map['sendby'] == StaticData.userModel!.name;
    return Container(
      width: size.width,
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isMe ? const Color(0XFFED8F45) : Colors.grey.withOpacity(0.18),
        ),
        child: Text(
          map['message'],
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("${StaticData.userModel!.name}"),
        backgroundColor: Colors.pink[200],
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chatroom')
                  .doc(widget.chatId)
                  .collection('Chats')
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> map = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;
                      return messages(size, map, context);
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          // Message Input Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: msgController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onsendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.pink[200],
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
