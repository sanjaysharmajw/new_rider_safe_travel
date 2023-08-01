
import 'package:flutter/material.dart';
import 'package:ride_safe_travel/color_constant.dart';


class ChatTextField extends StatelessWidget {
  final VoidCallback fabClick;
  final TextEditingController textEditingController;
  const ChatTextField({super.key, required this.fabClick, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 1,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      maxLines: 1,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Write a message',
                          contentPadding:
                          EdgeInsets.only(right: 20, left: 20),
                          hintStyle: TextStyle(fontFamily: 'Gilroy')),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FloatingActionButton(
            heroTag: "fab1",
            elevation: 1,
            mini: true,
            backgroundColor: appBlue,
            onPressed: fabClick,
            child:  const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
