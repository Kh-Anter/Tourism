import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourism/constants.dart';
import 'package:tourism/size_config.dart';
import 'package:tourism/views/all_trips_screen.dart';
import 'package:tourism/views/authentication/auth_screen.dart';
import 'package:tourism/views/authentication/forgot_password_screen.dart';
import 'package:tourism/views/booking_screen.dart';
import 'package:tourism/views/check_out_screen.dart';
import 'package:tourism/views/home_screen.dart';
import 'package:tourism/views/region_screen.dart';
import 'package:tourism/views/trip_details_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.grey,
      getPages: [
        GetPage(name: AuthScreen.routeName, page: () => const AuthScreen()),
        GetPage(
            name: ForgotPasswordScreen.routeName,
            page: () => ForgotPasswordScreen()),
        GetPage(name: HomeScreen.routeName, page: () => HomeScreen()),
        GetPage(name: RegionScreen.routeName, page: () => RegionScreen()),
        GetPage(name: BookingScreen.routeName, page: () => BookingScreen()),
        GetPage(name: CheckOutScreen.routeName, page: () => CheckOutScreen()),
        GetPage(name: AllTripScreen.routeName, page: () => AllTripScreen()),
        GetPage(
            name: TripDetailsScreen.routeName, page: () => TripDetailsScreen()),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: myscaffoldBackgroundColor,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SafeArea(
                  child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return const Center(child: Text("an error occured"));
            } else if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return const AuthScreen();
            }
          }),
    );
  }
}
