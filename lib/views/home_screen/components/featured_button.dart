import 'package:emart/category_screen/category_details.dart';
import 'package:emart/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget featuredButton({required title, icon}) {
  return Row(
    children: [
      Image.asset(icon, width: 60, fit: BoxFit.fill),
      10.widthBox,
      Text(title).text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .white
      .roundedSM
      .padding(const EdgeInsets.all(4))
      .outerShadowSm
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .make()
      .onTap(() {
    Get.to(() => CategoryDetails(title: title));
  });
}
