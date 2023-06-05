import 'package:emart/consts/consts.dart';

Widget homeButtons(
    {required double width,
    required icon,
    required title,
    required onPress,
    required double height}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      Text(title).text.fontFamily(semibold).color(fontGrey).make(),
    ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}
