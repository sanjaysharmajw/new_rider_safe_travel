import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/chat_module/chat_controller/chat_controller.dart';
import 'package:ride_safe_travel/chat_module/chat_widgets/chat_textfield.dart';
import 'package:ride_safe_travel/chat_module/chat_widgets/empty_chat.dart';
import 'package:ride_safe_travel/chat_module/models/message.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class RealtimeChatScreen extends StatefulWidget {
  String? socketToken;

  RealtimeChatScreen({Key? key,this.socketToken}) : super(key: key);

  @override
  State<RealtimeChatScreen> createState() => _RealtimeChatScreenState();
}

class _RealtimeChatScreenState extends State<RealtimeChatScreen> {
  late IO.Socket socket;
  final TextEditingController _messageInputController = TextEditingController();
  final chatController = Get.put(ChatController());
  String username="";

  sendMessage() {
    chatController.messages.add(Message(msg: _messageInputController.text.trim(),fromMe: true));
    var msgEmit={
      "messagetext": _messageInputController.text.trim(),
    };
    socket.emit("message", msgEmit);
    _messageInputController.clear();
    chatController.scrollAnimation();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      socketConnect(widget.socketToken.toString());
    });
  }
  @override
  void dispose() {
    _messageInputController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(chatController.messages.isEmpty?"Chat":chatController.messages[0].userName==null?"Chat":
            chatController.messages[0].userName.toString(),style:
            const TextStyle(color: Colors.black)),
            const Text('Typing...',style:
            TextStyle(color: lightText,fontSize: 12)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child:
            Obx(() {
              return chatController.messages.isEmpty?const Center(child: EmptyChat()):ListView.separated(
                physics: const BouncingScrollPhysics(),
                controller: chatController.scrollController,
                itemCount: chatController.messages.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  return Wrap(
                    alignment: message.fromMe!?WrapAlignment.end:WrapAlignment.start,
                    children: [
                      Container(
                        constraints:  BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.3),
                        decoration:  BoxDecoration(
                          color: message.fromMe!?appBlue:appLightBlue,
                          borderRadius: message.fromMe!?const BorderRadius.only(topRight:Radius.circular(13),topLeft:Radius.circular(13),bottomLeft:Radius.circular(13)):
                          const BorderRadius.only(topRight:Radius.circular(13),bottomRight:Radius.circular(13),bottomLeft:Radius.circular(13)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Column(
                            children: [
                              Text(message.msg.toString(),style:  TextStyle(fontFamily: 'Gilroy',color: message.fromMe!?Colors.white:Colors.black,fontSize: 15)),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (_, index) =>
                const SizedBox(
                  height: 5,
                ),
              );
            }),
          ),
          ChatTextField(fabClick: (){
            setState(() {
              if (_messageInputController.text.trim().isNotEmpty) {
                sendMessage();
              }
            });
          }, textEditingController: _messageInputController),
        ],
      ),
    );
  }
  Future<void> socketConnect(String token) async {
    try {
      socket = IO.io('http://65.1.73.254:3700', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'extraHeaders': {
          'authorization': token.toString(),
          'Content-Type': 'application/json; charset=UTF-8'
        }
      });
      socket.connect();
      socket.on('connect', (_) {
        debugPrint('Connected to the server');
      });
      socket.on('disconnect', (_) {
        debugPrint('Disconnected from the server');
      });
      socket.on('event', (data) {
        debugPrint('Received event: $data');
      });
      socket.on('message', (data) {
        setState(() {
          debugPrint('Received message: $data');
          chatController.addNewMessage(Message.fromJson(data));
          chatController.scrollAnimation();
        });
      });
      socket.on('error', (error) {
        debugPrint('Error: $error');
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}