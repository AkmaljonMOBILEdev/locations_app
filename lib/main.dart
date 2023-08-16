import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locations_app/data/network/api_service.dart';
import 'package:locations_app/providers/call_adress_provider.dart';
import 'package:locations_app/providers/location_provider.dart';
import 'package:locations_app/providers/marker_provider.dart';
import 'package:locations_app/providers/saved_list_provider.dart';
import 'package:locations_app/providers/tab_box_provider.dart';
import 'package:locations_app/ui/splash_screen/splash_screen.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TabBoxProvider()),
      ChangeNotifierProvider(create: (context) => LocationProvider()),
      ChangeNotifierProvider(create: (context) => SavedListProvider()),
      ChangeNotifierProvider(create: (context) => CallAddressProvider(apiService: ApiService())),
      ChangeNotifierProvider(create: (context)=>MarkerProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return  ScreenUtilInit(
      designSize: Size(screenSize.width, screenSize.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.deepPurple
              )
          ),colorScheme: const ColorScheme.light()),
          home: const SplashScreen(),
        );
      },

    );

  }
}

