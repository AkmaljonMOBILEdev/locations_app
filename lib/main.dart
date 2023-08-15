import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:locations_app/data/network/api_service.dart';
import 'package:locations_app/providers/call_adress_provider.dart';
import 'package:locations_app/providers/location_provider.dart';
import 'package:locations_app/providers/saved_list_provider.dart';
import 'package:locations_app/providers/tab_box_provider.dart';
import 'package:locations_app/ui/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TabBoxProvider()),
      ChangeNotifierProvider(create: (context) => LocationProvider()),
      ChangeNotifierProvider(create: (context) => SavedListProvider()),
      ChangeNotifierProvider(create: (context) => CallAddressProvider(apiService: ApiService())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.deepPurple
        )
      ),colorScheme: const ColorScheme.light()),
      home: const SplashScreen(),
    );

  }
}

