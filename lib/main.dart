import 'package:economate_mobile/provider/transaction_provider.dart';
import 'package:economate_mobile/provider/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:economate_mobile/screens/splash_screen.dart';
import 'package:economate_mobile/pages/sign_in_page.dart';
import 'package:economate_mobile/pages/sign_up_page.dart';
import 'package:economate_mobile/screens/home_screen.dart';
import 'package:economate_mobile/provider/authentication_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://utlptgfifjmxhirwkbuz.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV0bHB0Z2ZpZmpteGhpcndrYnV6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2MjY4MTQsImV4cCI6MjA2MzIwMjgxNH0.MxaN3BbP7jbzZMzaayQ-tTcgK2ff5_mCft98O2SMuA8",
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(
          create: (_) => TransactionProvider()..loadTransactions(),
        ),
        ChangeNotifierProvider(
          create: (_) => WalletProvider()..loadWallets(),
        ),
      ],
      child: MaterialApp(
        title: 'EconoMate',
        home: const SplashScreen(),
        routes: {
          '/signIn': (context) => const SignInPage(),
          '/signUp': (context) => const SignUpPage(),
          '/home': (context) => const HomeScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}