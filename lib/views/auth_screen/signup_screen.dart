import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/views/home_screen/home.dart';
import 'package:emart/widgets_common/applogo_widget.dart';
import 'package:emart/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      hint: nameHint,
                      title: name,
                      controller: nameController,
                      isPass: false),
                  customTextField(
                      hint: emailHint,
                      title: email,
                      controller: emailController,
                      isPass: false),
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      controller: passwordController,
                      isPass: true),
                  customTextField(
                      hint: retypePasswordHint,
                      title: retypePassword,
                      controller: passwordRetypeController,
                      isPass: true),
                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          activeColor: redColor,
                          checkColor: whiteColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          }),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                              text: termsAndCondition,
                              style: TextStyle(
                                fontFamily: regular,
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(
                              text: " & ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  5.heightBox,
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(
                          title: signup,
                          color: isCheck == true ? redColor : lightGrey,
                          textColor: whiteColor,
                          onPress: () async {
                            if (isCheck != false) {
                              controller.isloading(true);
                              try {
                                await controller
                                    .signupMethod(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context,
                                )
                                    .then((value) {
                                  return controller.storeUserData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                  );
                                }).then((value) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isloading(false);
                              }
                            }
                          },
                        ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyHaveAccount.text.color(fontGrey).make(),
                      login.text.color(redColor).make().onTap(() {
                        Get.back();
                      }),
                    ],
                  ),
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
          ],
        ),
      ),
    ));
  }
}
