import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/snack_bar.dart';
import '../models/client_model.dart';
import '../services/sql_data_retriver_registration.dart';
import '../widgets/button_text.dart';
import '../widgets/login_button.dart';
import '../widgets/lol_black_logo.dart';
import '../widgets/skin_animation.dart';
import '../widgets/text_field_login.dart';
import 'home_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String route = '/';
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String randomSkinPath = '';
  bool isLoading = true;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  bool animation = true;
  SqlDataRetriverRegistration sqlDataRetriverRegistration = SqlDataRetriverRegistration();

  Future<void> _getCustomSkin() async {
    while (animation) {
      randomSkinPath = await sqlDataRetriverRegistration.getRandomSkinFromDatabase();
      setState(() => isLoading = false);
      await Future<void>.delayed(const Duration(seconds: 3));
    }
  }

  Future<void> _verifyAccount() async {
    await sqlDataRetriverRegistration.verifyAccount(controller1.text, controller2.text).then(
      (bool result) async {
        if (result) {
          context.read<ClientModel>().user = controller1.text;
          sqlDataRetriverRegistration.setClient(context, controller1.text);
          Navigator.pushNamed(context, HomeScreen.route);
        } else {
          controller1.clear();
          controller2.clear();
          showSnackBar(context, 'Invalid inputs');
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getCustomSkin();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    animation = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
              child: ListView(
                children: <Widget>[
                  const LolBlackLogo(),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                  const Text(
                    'Sign in with your Game Manager Account!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                  TextFieldLogin(
                    controller: controller1,
                    hintText: 'USERNAME',
                    hideText: false,
                  ),
                  TextFieldLogin(
                    controller: controller2,
                    hintText: 'PASSWORD',
                    hideText: true,
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
                  LoginButton(
                    onPressed: _verifyAccount,
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                  ButtonText(
                    toggleOnPressed: () {
                      controller1.clear();
                      controller2.clear();
                      Navigator.pushNamed(context, RegistrationScreen.route);
                    },
                    text: 'Register an account',
                  ),
                ],
              ),
            ),
          ),
          SkinAnimation(isLoading: isLoading, skinPath: randomSkinPath),
        ],
      ),
    );
  }
}
