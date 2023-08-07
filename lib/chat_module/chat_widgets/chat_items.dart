
import 'package:flutter/material.dart';
import 'package:ride_safe_travel/chat_module/models/message.dart';

import '../../color_constant.dart';

class ChatItems extends StatelessWidget {
  final Message message;
  const ChatItems({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return  Wrap(
      alignment: message.fromMe!
          ? WrapAlignment.end
          : WrapAlignment.start,
      children: [
        Column(
          crossAxisAlignment:
          message.fromMe!
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxWidth:
                  MediaQuery.of(context).size.width /
                      1.3),
              decoration: BoxDecoration(
                color: message.fromMe!
                    ? appBlue
                    : appLightBlue,
                borderRadius: message.fromMe!
                    ? const BorderRadius.only(
                    topRight: Radius.circular(13),
                    topLeft: Radius.circular(13),
                    bottomLeft: Radius.circular(13))
                    : const BorderRadius.only(
                    topRight: Radius.circular(13),
                    bottomRight: Radius.circular(13),
                    bottomLeft: Radius.circular(13)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  children: [
                    Text(message.msg.toString(),
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            color: message.fromMe!
                                ? Colors.white
                                : Colors.black,
                            fontSize: 15)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,top: 10,bottom: 10),
              child: Text(message.chatTime.toString(),style: const TextStyle(fontSize: 12,fontFamily: 'Gilroy')),
            ),
          ],
        )
      ],
    );
  }
}
