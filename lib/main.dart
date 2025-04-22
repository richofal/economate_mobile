import 'package:economate_mobile/provider/auth_provider.dart';
import 'package:economate_mobile/screens/splash_screen.dart';
import 'package:economate_mobile/pages/sign_in_page.dart';
import 'package:economate_mobile/pages/sign_up_page.dart';
import 'package:economate_mobile/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// import 'package:economate_mobile/pages/history.dart';
// import 'package:economate_mobile/pages/wallet.dart';
// import 'package:economate_mobile/pages/profile.dart';
// import 'package:economate_mobile/pages/insert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(demoProjectId: "demo-project-id");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        title: 'EconoMate',
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/signIn': (context) => SignInPage(),
          '/signUp': (context) => SignUpPage(),
          '/home': (context) => HomeScreen(),
        },
        debugShowCheckedModeBanner: false, // Menghilangkan banner debug
        // home: SplashScreen(),
      ),
    );
  }
}

//  Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'EconoMate',
//       initialRoute: '/',
//       routes: {
//         '/': (context) => SplashScreen(),
//         '/signIn': (context) => SignInPage(),
//         '/signUp': (context) => SignUpPage(),
//         '/home': (context) => HomeScreen()
//       },
//       debugShowCheckedModeBanner: false,  // Menghilangkan banner debug
//       // home: SplashScreen(),
//     ); 
//   }