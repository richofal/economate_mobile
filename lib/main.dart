import 'package:economate_mobile/firebase_options.dart';
import 'package:economate_mobile/provider/authentication_provider.dart';
import 'package:economate_mobile/screens/splash_screen.dart';
import 'package:economate_mobile/pages/sign_in_page.dart';
import 'package:economate_mobile/pages/sign_up_page.dart';
import 'package:economate_mobile/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => AuthenticationProvider())],
    child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'EconoMate',
        initialRoute: '/',
        routes: {
          '/': (context) => StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(), 
            builder: (ctx, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return SplashScreen();
              }
              return snapshot.hasData ? HomeScreen() : SignInPage();
            }),
          '/signIn': (context) => SignInPage(),
          '/signUp': (context) => SignUpPage(),
          '/home': (context) => HomeScreen(),
        },
        debugShowCheckedModeBanner: false, // Menghilangkan banner debug
        // home: SplashScreen(),
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