import 'package:bashasagar/core/const/appcolors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.kBlack,
    textColor: AppColors.kWhite,
    fontSize: 16.0,
  );
}
