import 'package:emart/consts/consts.dart';

Widget ourButton(
    {required color, required title, required textColor, required onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress,
    child: Text(title).text.color(textColor).fontFamily(bold).make(),
  );
}
