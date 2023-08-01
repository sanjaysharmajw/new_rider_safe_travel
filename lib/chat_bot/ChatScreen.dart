import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/color_constant.dart';

import 'Messages.dart';
import 'UpperCaseTextFormatter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatBot(),
    );
  }
}

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ChatBot> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 15,
        backgroundColor: appBlue,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined, color: Colors.white,size: 25,),
            onPressed: () {
              Navigator.pop(context);
            }),
        title:  Text('chat'.tr,
          style: TextStyle(fontFamily: "Gilroy",fontSize: 22,color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Expanded(child: MessagesScreen(messages: messages)),
              Row(
                children: [
                  Expanded(

                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: appBlue
                        ),
                        child: TextField(
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          controller: _controller,
                          style: const TextStyle(color: Colors.white),
                          decoration:  InputDecoration(

                            border: InputBorder.none,
                            hintText: 'enter_something'.tr,
                            hintStyle: TextStyle(fontFamily: "Gilroy",fontSize: 16,color: Colors.white),
                            contentPadding: EdgeInsets.only(right: 20,left: 20),
                          ),
                        ),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: appBlue
                    ),
                    child: IconButton(
                        onPressed: () {
                          sendMessage(_controller.text);
                          _controller.clear();
                        },
                        icon: Icon(Icons.send,color: Colors.white,)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }
  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}



