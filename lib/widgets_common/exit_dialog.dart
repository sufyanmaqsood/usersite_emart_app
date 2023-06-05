import 'package:emart/consts/consts.dart';
import 'package:emart/widgets_common/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    backgroundColor: darkFontGrey,
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      "Confirm Eixt".text.fontFamily(bold).size(28).color(redColor).make(),
      Divider(),
      10.heightBox,
      "Are you sure you want to exit?"
          .text
          .size(18)
          .fontFamily(semibold)
          .color(whiteColor)
          .make(),
      10.heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ourButton(
            color: redColor,
            onPress: () {
              SystemNavigator.pop();
            },
            textColor: whiteColor,
            title: "Yes",
          ),
          ourButton(
            color: Colors.green,
            onPress: () {
              Navigator.pop(context);
            },
            textColor: whiteColor,
            title: "No",
          )
        ],
      ),
    ]).box.color(darkFontGrey).padding(EdgeInsets.all(12)).roundedSM.make(),
  );
}
