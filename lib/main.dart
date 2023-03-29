import './screens/handling_screens/loading_screen.dart';
import './screens/home_screen.dart';
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.aBeeZeeTextTheme(),
          primarySwatch: Colors.blue,
        ),
        home: const ScreenRouter(),
      ),
    );
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).startProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.status == Status.authenticated) {
          return const HomeScreen();
        } else if ((authProvider.status == Status.unauthenticated)) {
          return const LoginScreen();
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
