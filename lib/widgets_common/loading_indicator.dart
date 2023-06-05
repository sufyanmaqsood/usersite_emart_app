import 'package:emart/consts/consts.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(Colors.white),
  );
}
