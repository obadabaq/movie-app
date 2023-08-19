import 'package:flutter/material.dart';
import 'package:flutter_movies_app/utils/constant.dart';
import 'package:flutter_movies_app/utils/injection_container.dart';
import 'package:flutter_movies_app/utils/route_generator.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Movies App',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: RouteNames.SPLASH_SCREEN,
          theme: ThemeData(
            primaryColor: BACKGROUND_COLOR,
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
