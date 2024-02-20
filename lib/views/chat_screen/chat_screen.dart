import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/controller/chats_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/views/chat_screen/component/sender_bubble.dart';
import 'package:ecommerce/widgets_common/loadin_indecator_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "${controller.friendName}"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Obx(
          () => Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                controller.isLoading.value
                    ? Center(child: loadinIndicator())
                    : Expanded(
                        child: StreamBuilder(
                          stream: FirestoreServices.getChatsMessages(
                              controller.chatDocId.toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: loadinIndicator());
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                  child: "Send a message..."
                                      .text
                                      .color(darkFontGrey)
                                      .make());
                            } else {
                              return ListView(
                                  children: snapshot.data!.docs
                                      .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];

                                return Align(
                                  alignment: data['uid'] == currentUser!.uid
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: senderBubble(data),
                                );
                              }).toList());
                            }
                          },
                        ),
                      ),
                10.heightBox,
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: controller.msgController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: textfieldGrey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: textfieldGrey)),
                        hintText: "Type a message...",
                      ),
                    )),
                    IconButton(
                        onPressed: () {
                          controller.sendMsg(controller.msgController.text);
                          controller.msgController.clear();
                        },
                        icon: Icon(
                          Icons.send,
                          color: redColor,
                        ))
                  ],
                )
                    .box
                    .height(80)
                    .padding(EdgeInsets.all(12))
                    .margin(EdgeInsets.only(bottom: 8))
                    .make()
              ],
            ),
          ),
        ));
  }
}
