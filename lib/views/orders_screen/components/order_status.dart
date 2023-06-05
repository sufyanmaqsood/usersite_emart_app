import 'package:emart/consts/consts.dart';

Widget orderStatus(
    {required icon, required color, required title, required showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    )
        .box
        .border(color: color)
        .roundedSM
        .padding(const EdgeInsets.all(4.0))
        .make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone
              ? const Icon(
                  Icons.done,
                  color: redColor,
                )
              : Container(),
        ],
      ),
    ),
  );
}
