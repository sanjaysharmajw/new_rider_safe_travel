import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pip_view/pip_view.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/LoginModule/preferences.dart';
import 'package:ride_safe_travel/Utils/CustomLoader.dart';
import 'package:ride_safe_travel/Utils/utils_class.dart';
import 'package:ride_safe_travel/bottom_nav/custom_bottom_navi.dart';
import 'package:ride_safe_travel/chat_module/chat_controller/chat_controller.dart';
import 'package:ride_safe_travel/chat_module/chat_widgets/chat_alert.dart';
import 'package:ride_safe_travel/chat_module/chat_widgets/chat_items.dart';
import 'package:ride_safe_travel/chat_module/chat_widgets/chat_textfield.dart';
import 'package:ride_safe_travel/chat_module/chat_widgets/empty_chat.dart';
import 'package:ride_safe_travel/chat_module/models/is_typing_model.dart';
import 'package:ride_safe_travel/chat_module/models/me_typing_request.dart';
import 'package:ride_safe_travel/chat_module/models/message.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class RealtimeChatScreen extends StatefulWidget {
  String? socketToken;

  RealtimeChatScreen({Key? key, this.socketToken}) : super(key: key);

  @override
  State<RealtimeChatScreen> createState() => _RealtimeChatScreenState();
}

class _RealtimeChatScreenState extends State<RealtimeChatScreen> {
  late IO.Socket socket;
  final TextEditingController _messageInputController = TextEditingController();
  final chatController = Get.put(ChatController());
  String username = "";
  String? onchangeText;

  sendMessage() {
    chatController.messages.add(Message(
        msg: _messageInputController.text.trim(),
        fromMe: true,
        chatTime: MyUtils.getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch)));
    var msgEmit = {
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
      CustomLoader.message(widget.socketToken.toString());
      debugPrint("widget.socketToken.toString()");
      debugPrint(widget.socketToken.toString());
      socketConnect(widget.socketToken.toString());
    });
  }




  @override
  void dispose() {
    _messageInputController.dispose();
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PIPView(
      builder: (context, isFloating) {
        return WillPopScope(
          onWillPop: () => showChatExitPopup(context,"Do you want to continue",(){
            PIPView.of(context)?.presentBelow(const CustomBottomNav());
            Get.back();
          },(){
            socket.disconnect();
            Get.offAll(const CustomBottomNav());
          }),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: appBlue,
              elevation: 0,
              centerTitle: false,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      getCurrentTime();
                    },
                    child: Text(
                        chatController.messages.isEmpty
                            ? "Chat"
                            : chatController.messages[0].userName == null
                                ? "Chat"
                                : chatController.messages[0].userName
                                    .toString(),
                        style: const TextStyle(color: Colors.white)),
                  ),
                    Text(chatController.isTypingData.isEmpty
                        ? "waiting"
                        : chatController.isTypingData[0].msg == null
                        ? "waiting"
                        : "typing",
                      style: const TextStyle(color: CustomColor.white, fontSize: 12)),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    return chatController.messages.isEmpty
                        ? const Center(child: EmptyChat())
                        : ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            controller: chatController.scrollController,
                            itemCount: chatController.messages.length,
                            padding: const EdgeInsets.all(16),
                            itemBuilder: (context, index) {
                              final message = chatController.messages[index];
                              return ChatItems(message: message);
                            },
                            separatorBuilder: (_, index) => const SizedBox(
                              height: 5,
                            ),
                          );
                  }),
                ),
                ChatTextField(
                    fabClick: () {
                      setState(() {
                        if (_messageInputController.text.trim().isNotEmpty) {
                          sendMessage();
                        }
                      });
                    },
                    textEditingController: _messageInputController, changed: (value) {
                  setState(() {
                    onchangeText=value;
                    CustomLoader.message(value.toString());
                    MeTypingRequest meTypingRequest = MeTypingRequest(isTyping: value==""?false:true);
                    socket.emit("meTyping", jsonEncode(meTypingRequest));
                    debugPrint("meTypinfRequest");
                    debugPrint(jsonEncode(meTypingRequest));
                  });
                }),
              ],
            ),
          ),
        );
      },
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

      socket.on('typing', (data) {  // true,false
        setState(() {
          debugPrint('meTyping: $data');
          chatController.addisTyping(IsTypingModel.fromJson(data));
        });
      });

      socket.on('waiting', (data) {  //waiting// startNewChat
        setState(() {
          debugPrint('waiting: $data');
        });
      });

      socket.on('startNewChat', (data) {
        setState(() {
          debugPrint('startNewChat: $data');
        });
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
  void getCurrentTime(){
    CustomLoader.message(MyUtils.getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch));
  }


}


