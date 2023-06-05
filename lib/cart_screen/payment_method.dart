import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controllers/cart_controller.dart';
import 'package:emart/widgets_common/loading_indicator.dart';
import 'package:emart/widgets_common/our_button.dart';
import 'package:get/get.dart';
import '../views/home_screen/home.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
          backgroundColor: whiteColor,
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(child: loadingIndicator())
              : ourButton(
                  color: redColor,
                  title: "Place my order",
                  textColor: whiteColor,
                  onPress: () async {
                    controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);
                    await controller.clearCart();
                    VxToast.show(context, msg: "Order placed successfully");
                    Get.offAll(const Home());
                  },
                ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(
                paymentMethodsImg.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.changePaymentIndex(index);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: controller.paymentIndex.value == index
                                ? redColor
                                : Colors.transparent,
                            width: 4,
                          )),
                      margin: const EdgeInsets.only(bottom: 12.0),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(
                            paymentMethodsImg[index],
                            width: double.infinity,
                            height: 120,
                            colorBlendMode:
                                controller.paymentIndex.value == index
                                    ? BlendMode.color
                                    : BlendMode.darken,
                            color: controller.paymentIndex.value == index
                                ? Colors.transparent
                                : Colors.black.withOpacity(0.6),
                            fit: BoxFit.cover,
                          ),
                          controller.paymentIndex.value == index
                              ? Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    value: true,
                                    onChanged: (value) {},
                                  ),
                                )
                              : Container(),
                          Positioned(
                              bottom: 0,
                              right: 10,
                              child: paymentMethods[index]
                                  .text
                                  .fontFamily(bold)
                                  .white
                                  .size(16)
                                  .make()),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
