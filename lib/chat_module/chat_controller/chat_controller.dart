import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/chat_module/models/message.dart';


class ChatController extends GetxController {
  final _messages = <Message>[].obs;
  ScrollController scrollController = ScrollController();
  List<Message> get messages => _messages;
  addNewMessage(Message message) {
    _messages.add(message);
  }
  // Scroll Chat
  Future<void> scrollAnimation() async {
    return await Future.delayed(
        const Duration(milliseconds: 100),
            () => scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear));
  }
}