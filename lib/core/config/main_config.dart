import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/features/settings/data/models/ui_created_at.dart';
import 'package:bashasagar/features/settings/data/models/ui_instruction_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class MainConfig {
  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> lockOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,

      // Add `DeviceOrientation.portraitDown` if you want upside down too
    ]);
  }

  static Future<void> setToolBarColor() async {
    SystemUiOverlayStyle(
    statusBarColor: AppColors.kPrimaryColor, // Android only
    statusBarIconBrightness: Brightness.dark, // Android
    statusBarBrightness: Brightness.light, // iOS - Light means dark icons, Dark means light icons
  );
  }

  static Future<void> initHiveBox() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(UiInstructionModelAdapter());
    Hive.registerAdapter(UiLangCreatedAtAdapter());
  }
}
