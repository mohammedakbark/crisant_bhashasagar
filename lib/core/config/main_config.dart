
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class MainConfig {
  


  // static Future<void> initFirebase() async {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }

  static Future<void> lockOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,

      // Add `DeviceOrientation.portraitDown` if you want upside down too
    ]);
  }

  static Future<void> initHiveBox()async{
      await Hive.initFlutter(); // Initializes Hive for Flutter

  await Hive.openBox('apiCache'); // Open a box (like a table)

  }
}
