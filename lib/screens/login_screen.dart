import 'package:flutter/material.dart';
import 'package:game_manager/models/client_model.dart';
import 'package:game_manager/screens/registration_screen.dart';
import 'package:game_manager/services/sql_data_retriver_registration.dart';
import 'package:game_manager/widgets/button_text.dart';
import 'package:game_manager/widgets/login_button.dart';
import 'package:game_manager/widgets/lol_black_logo.dart';
import 'package:game_manager/widgets/skin_animation.dart';
import 'package:game_manager/widgets/text_field_login.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/';

  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String randomSkinPath = '';
  bool isLoading = true;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  bool error = false;
  bool animation = true;
  SqlDataRetriverRegistration sqlDataRetriverRegistration = SqlDataRetriverRegistration();

  void _getCustomSkin() async {
    while (animation) {
      randomSkinPath = await sqlDataRetriverRegistration.getRandomSkinFromDatabase();
      setState(() => isLoading = false);
      await Future.delayed(const Duration(seconds: 3));
    }
  }

  void _verifyAccount() async {
    await sqlDataRetriverRegistration.verifyAccount(controller1.text, controller2.text).then(
      (result) async {
        if (result) {
          print('Entered in homeScreen');
          context.read<ClientModel>().setUser = controller1.text;
          context.read<ClientModel>().setUser = controller1.text;
          sqlDataRetriverRegistration.setClient(context, controller1.text);
          Navigator.pushNamed(context, HomeScreen.route);
        } else {
          controller1.clear();
          controller2.clear();
          setState(() => error = true);
          await Future.delayed(const Duration(seconds: 2));
          setState(() => error = false);
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
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
              child: ListView(
                children: [
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
                  if (error)
                    const Center(
                      child: Text(
                        'Try again with other values!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
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
