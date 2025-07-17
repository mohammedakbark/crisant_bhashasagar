import 'package:bashasagar/core/const/appcolors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, {bool isError = false}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    
    backgroundColor: isError ? AppColors.kRed : AppColors.kBlack,
    textColor: AppColors.kWhite,
    fontSize: 12.0,
  );
}
