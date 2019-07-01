import 'package:fluttertoast/fluttertoast.dart';

class Useful
{
  static  void printMessage(String message)
  {
    print("Toast");
    Fluttertoast.showToast(
        msg:message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM);

  }
}