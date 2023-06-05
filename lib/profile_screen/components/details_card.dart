import 'package:emart/consts/consts.dart';

Widget detailsCard({width, count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(title!).text.color(darkFontGrey).make(),
      5.heightBox,
      Text(count).text.fontFamily(bold).size(16).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .padding(const EdgeInsets.all(4))
      .rounded
      .width(width)
      .height(60)
      .make();
}
