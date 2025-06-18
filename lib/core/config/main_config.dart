
import 'package:flutter/services.dart';
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
}
