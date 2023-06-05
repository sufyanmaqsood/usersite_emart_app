import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/controllers/profile_controller.dart';
import 'package:emart/views/auth_screen/login_screen.dart';
import 'package:emart/views/chat_screen/messaging_screen.dart';
import 'package:emart/views/orders_screen/order_screen.dart';
import 'package:emart/views/wishlist_screen/wishlist_screen.dart';
import 'package:emart/widgets_common/bg_widget.dart';
import 'package:emart/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';
import '../services/firestore_services.dart';
import 'components/details_card.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FirestoreServices.getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                // edit Profile Button
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.edit,
                      color: whiteColor,
                    ),
                  ).onTap(() {
                    controller.nameController.text = data['name'];
                    //controller.passController.text = data['password'];
                    Get.to(() => EditProfileScreen(data: data));
                  }),
                ),

                //users Details Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      data['imageUrl'] == ''
                          ? Image.asset(
                              imgProfile2,
                              width: 50,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              data['imageUrl'],
                              width: 50,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                      10.widthBox,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                            "${data['email']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                          ],
                        ),
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                            color: whiteColor,
                          )),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signoutMethod(context);
                            Get.offAll(() => const LoginScreen());
                          },
                          child: logout.text.white.fontFamily(semibold).make())
                    ],
                  ),
                ),
                20.heightBox,
                FutureBuilder(
                    future: FirestoreServices.getCounts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: loadingIndicator());
                      } else {
                        var countData = snapshot.data;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                              title: "in your cart",
                              count: countData[0].toString(),
                              width: context.screenWidth / 3.3,
                            ),
                            detailsCard(
                              title: "in your wish list",
                              count: countData[1].toString(),
                              width: context.screenWidth / 3.3,
                            ),
                            detailsCard(
                                title: "your orders",
                                count: countData[2].toString(),
                                width: context.screenWidth / 3.3),
                          ],
                        );
                      }
                    }),
                10.heightBox,

                //buttons Section

                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: lightGrey,
                    );
                  },
                  itemCount: profileButtonList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.to(() => const OrdersScreen());
                            break;
                          case 1:
                            Get.to(() => const WishlistScreen());
                            break;
                          case 2:
                            Get.to(() => const MessagesScreen());
                            break;
                        }
                      },
                      leading: Image.asset(
                        profileButtonIcon[index],
                        width: 22,
                      ),
                      title: profileButtonList[index]
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                    );
                  },
                )
                    .box
                    .white
                    .padding(const EdgeInsets.symmetric(horizontal: 16))
                    .rounded
                    .shadowSm
                    .margin(const EdgeInsets.all(12))
                    .make()
                    .box
                    .color(redColor)
                    .make(),
              ],
            ),
          );
        }
      },
    )));
  }
}
