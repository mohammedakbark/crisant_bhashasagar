import 'package:bashasagar/core/bloc_provider.dart';
import 'package:bashasagar/core/config/main_config.dart';
import 'package:bashasagar/core/routes/route_provider.dart';
import 'package:bashasagar/core/theme/app_theme.dart';
import 'package:bashasagar/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainConfig.lockOrientation();
  await MainConfig.setToolBarColor();
  await MainConfig.initHiveBox();
  await MainConfig.initFirebase();
  runApp(AppBlocProvider(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ResponsiveHelper.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Bhashasagar',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(),
      routerConfig: RouteProvider.router,
    );
  }
}
