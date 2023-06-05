import 'dart:io';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/profile_controller.dart';
import 'package:emart/profile_screen/profile_screen.dart';
import 'package:emart/widgets_common/bg_widget.dart';
import 'package:emart/widgets_common/custom_textfield.dart';
import 'package:emart/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                    ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make()
                    : data['imageUrl'] != '' &&
                            controller.profileImgPath.isEmpty
                        ? Image.network(data['imageUrl'],
                                width: 100, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make()
                        : Image.file(
                            File(controller.profileImgPath.value),
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ourButton(
                  color: redColor,
                  textColor: whiteColor,
                  title: "Change Image",
                  onPress: () {
                    controller.changeImage(context);
                  },
                ),
                const Divider(),
                20.heightBox,
                customTextField(
                  controller: controller.nameController,
                  hint: nameHint,
                  title: name,
                  isPass: false,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.oldpassController,
                  hint: passwordHint,
                  title: oldpass,
                  isPass: true,
                ),
                10.heightBox,
                customTextField(
                  controller: controller.newpassController,
                  hint: passwordHint,
                  title: newpass,
                  isPass: true,
                ),
                20.heightBox,
                controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 50,
                        child: ourButton(
                          color: redColor,
                          textColor: whiteColor,
                          title: "Save All",
                          onPress: () async {
                            controller.isloading(true);
                            //if image is not sellected
                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImageLink = data['imageUrl'];
                            }
                            //if old password mathes database

                            if (data['password'] ==
                                controller.oldpassController.text) {
                              await controller.changeAuthPassword(
                                  email: data['email'],
                                  password: controller.oldpassController.text,
                                  newpassword:
                                      controller.newpassController.text);
                              await controller.updateProfile(
                                name: controller.nameController.text,
                                password: controller.newpassController.text,
                                imgUrl: controller.profileImageLink,
                              );
                              VxToast.show(
                                context,
                                msg:
                                    "Congratulations! Your Profile Updated Successfully!",
                              );
                              Get.offAll(() => const ProfileScreen());
                            } else {
                              VxToast.show(
                                context,
                                msg: "Wrong Old Password! try again.",
                              );
                              controller.isloading(false);
                            }
                          },
                        ),
                      ),
              ],
            )
                .box
                .white
                .shadowSm
                .rounded
                .padding(const EdgeInsets.all(16))
                .margin(const EdgeInsets.only(top: 50, right: 12, left: 12))
                .make(),
          ),
        ),
      ),
    );
  }
}
