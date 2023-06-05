import 'package:emart/cart_screen/payment_method.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/cart_controller.dart';
import 'package:emart/widgets_common/custom_textfield.dart';
import 'package:emart/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: redColor,
          onPress: () {
            if (controller.addressController.text.length > 4 &&
                controller.cityController.text.length > 4 &&
                controller.stateController.text.length > 4 &&
                controller.postalcodeController.text.length > 4 &&
                controller.phoneController.text.length == 11) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(context, msg: "All Fields are Required!");
            }
          },
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                hint: "Address should be More than 4 letters",
                title: "Address",
                controller: controller.addressController,
                isPass: false),
            customTextField(
                hint: "City name should contain minimum 4 letters",
                title: "City",
                controller: controller.cityController,
                isPass: false),
            customTextField(
                hint: "State",
                title: "State",
                controller: controller.stateController,
                isPass: false),
            customTextField(
                hint: "Postal Code Should be more then 5 letters",
                title: "Postal Code",
                controller: controller.postalcodeController,
                isPass: false),
            customTextField(
                hint: "Phone should be 03011234567 in this formats",
                title: "Phone",
                controller: controller.phoneController,
                isPass: false),
          ],
        ),
      ),
    );
  }
}
