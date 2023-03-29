import 'package:e_commerce/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Provider.of<AuthProvider>(context, listen: false).logOut();

        // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
      }),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
