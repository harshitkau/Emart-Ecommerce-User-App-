import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/consts/consts.dart';
import 'package:ecommerce/consts/list.dart';
import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/controller/profile_controller.dart';
import 'package:ecommerce/services/firestore_services.dart';
import 'package:ecommerce/views/auth_screen/login_screen.dart';
import 'package:ecommerce/views/chat_screen/message_screen.dart';
import 'package:ecommerce/views/order_screen/order_screen.dart';
import 'package:ecommerce/views/profile_screen/components/details_card.dart';
import 'package:ecommerce/views/profile_screen/edit_profile_screen.dart';
import 'package:ecommerce/views/wishlist_screen/wishlist_screen.dart';
import 'package:ecommerce/widgets_common/bg_widget.dart';
import 'package:ecommerce/widgets_common/loadin_indecator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ).onTap(() {
                        controller.nameController.text = data['name'];
                        Get.to(() => EditProfileScreen(data: data));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          data['imageUrl'] == null
                              ? Image.asset(userProfile,
                                      width: 90, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make()
                              : Image.network('${data['imageUrl']}',
                                      width: 90, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make(),
                          10.widthBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ' ${data['name']}'
                                  .text
                                  .white
                                  .fontFamily(semibold)
                                  .make(),
                              "${data['email']}".text.white.make(),
                            ],
                          )),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: whiteColor)),
                              onPressed: () async {
                                await Get.put(AuthController())
                                    .signOutMethod(context);

                                Get.offAll(() => LoginScreen());
                                VxToast.show(context, msg: logoutSucees);
                              },
                              child:
                                  logout.text.fontFamily(semibold).white.make())
                        ],
                      ),
                    ),
                    20.heightBox,
                    FutureBuilder(
                      future: FirestoreServices.getCounts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: loadinIndicator());
                        } else {
                          var countData = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              detailsCard(
                                  width: context.screenWidth / 3.5,
                                  count: countData[0].toString(),
                                  title: "in your cart"),
                              detailsCard(
                                  width: context.screenWidth / 3.5,
                                  count: countData[1].toString(),
                                  title: "in your wishlist"),
                              detailsCard(
                                  width: context.screenWidth / 3.5,
                                  count: countData[2].toString(),
                                  title: "your order"),
                            ],
                          );
                        }
                      },
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     detailsCard(
                    //         width: context.screenWidth / 3.5,
                    //         count: data['cart_count'],
                    //         title: "in your cart"),
                    //     detailsCard(
                    //         width: context.screenWidth / 3.5,
                    //         count: data['wishlist_count'],
                    //         title: "in your wishlist"),
                    //     detailsCard(
                    //         width: context.screenWidth / 3.5,
                    //         count: data['order_count'],
                    //         title: "your order"),
                    //   ],
                    // ),
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(color: lightGrey);
                      },
                      itemCount: profileButtonList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => OrderScreen());
                                break;
                              case 1:
                                Get.to(() => WishlistScreen());
                                break;
                              case 2:
                                Get.to(() => MessageScreen());
                                break;
                            }
                          },
                          leading: Image.asset(profileButtonIconList[index],
                              width: 22),
                          title: profileButtonList[index]
                              .text
                              .fontFamily(bold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      },
                    )
                        .box
                        .white
                        .rounded
                        .margin(EdgeInsets.all(12))
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .shadowSm
                        .make()
                        .box
                        .make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
