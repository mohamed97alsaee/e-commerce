import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/widgets/clickable_widgets/main_button.dart';
import 'package:e_commerce/widgets/input_widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(onPressed: () {
        _scaffoldKey.currentState!.showBottomSheet(
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.green,
                height: 200,
              ),
            ],
          ),
        );
      }),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.burst_mode),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: const [
              Text("TAHA"),
              SizedBox(height: 10),
              Text("AMALEED"),
              SizedBox(height: 10),
              Text("ZENTANI"),
              SizedBox(height: 10),
              Text("MOHAMED"),
            ],
          ),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Login Screen'),
                TextFieldWidget(
                    digitsOnly: true,
                    controller: phoneController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (value.length != 9) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                    hintText: "92 XXX XX XX"),
                TextFieldWidget(
                    controller: passwordController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password ';
                      }

                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }

                      return null;
                    },
                    hintText: "********"),
                const SizedBox(
                  height: 30,
                ),
                MainButton(
                    text: 'Login',
                    withBorder: false,
                    isloading: false,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // print('Validated');
                        Provider.of<AuthProvider>(context, listen: false)
                            .login({
                          "phone": phoneController.text,
                          "password": passwordController.text,
                          "device_name": "iphone"
                        });
                      } else {
                        // print('Not Validated');
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
