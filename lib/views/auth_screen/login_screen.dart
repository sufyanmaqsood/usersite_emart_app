import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/views/auth_screen/signup_screen.dart';
import 'package:emart/widgets_common/applogo_widget.dart';
import 'package:emart/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

import '../../consts/lists.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';
import '../home_screen/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Login to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      hint: emailHint,
                      title: email,
                      isPass: false,
                      controller: controller.emailController),
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      isPass: true,
                      controller: controller.passwordController),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgetPass.text.make(),
                    ),
                  ),
                  5.heightBox,
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(
                          title: login,
                          color: redColor,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isloading(true);
                            try {
                              await controller
                                  .loginMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: loggedin);

                                  Get.offAll(() => const Home());
                                } else {
                                  controller.isloading(false);
                                }
                              });
                            } catch (error) {
                              print('An error occurred during login: $error');
                            }
                          },

                          // onPress: () async {
                          //   await controller
                          //       .loginMethod(context: context)
                          //       .then((value) {
                          //     if (value != null) {
                          //       VxToast.show(context, msg: loggedin);
                          //       Get.offAll(() => const Home());
                          //     }
                          //   });
                          // },
                        ).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(
                      title: signup,
                      color: lightGolden,
                      textColor: redColor,
                      onPress: () {
                        Get.to(() => const SignupScreen());
                      }).box.width(context.screenWidth - 50).make(),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
            10.heightBox,
            loginWith.text.color(fontGrey).make(),
            25.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: lightGrey,
                    radius: 25,
                    child: Image.asset(
                      socialIconList[index],
                      width: 30,
                      //height: 50,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
