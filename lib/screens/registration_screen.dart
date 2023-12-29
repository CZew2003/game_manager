import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/snack_bar.dart';
import '../models/client_model.dart';
import '../services/sql_data_retriver_registration.dart';
import '../widgets/button_text.dart';
import '../widgets/login_button.dart';
import '../widgets/skin_animation.dart';
import '../widgets/text_field_login.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const String route = '/registration-screen';
  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  String randomSkinPath = '';
  bool isLoading = true;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  bool animation = true;
  SqlDataRetriverRegistration sqlDataRetriverRegistration = SqlDataRetriverRegistration();
  String? region = 'Eune';
  List<String> regions = <String>['Eune', 'Euw', 'Na'];

  Future<void> _getCustomSkin() async {
    while (animation) {
      randomSkinPath = await sqlDataRetriverRegistration.getRandomSkinFromDatabase();
      setState(() => isLoading = false);
      await Future<void>.delayed(const Duration(seconds: 3));
    }
  }

  Future<bool> _getRegistrationVerify() async {
    bool result;
    if (controller2.text != controller3.text) {
      result = false;
    } else {
      result = await sqlDataRetriverRegistration.registerAccount(
        controller1.text,
        controller2.text,
        region ?? '',
      );
    }
    return result;
  }

  Future<void> _verifyRegistration() async {
    await _getRegistrationVerify().then((bool result) async {
      if (result) {
        context.read<ClientModel>().user = controller1.text;
        sqlDataRetriverRegistration.setClient(context, controller1.text);
        Navigator.popAndPushNamed(context, HomeScreen.route);
      } else {
        controller1.clear();
        controller2.clear();
        controller3.clear();
        setState(() => region = 'Eune');
        showSnackBar(context, 'Invalid inputs');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getCustomSkin();
  }

  @override
  void dispose() {
    animation = false;
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.07,
                      child: Image.asset('assets/images/lol_black_logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                  const Text(
                    'Register an account to Game Manager!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                  ),
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
                  TextFieldLogin(
                    controller: controller3,
                    hintText: 'REPEAT PASSWORD',
                    hideText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Wrap(
                        spacing: 20,
                        children: regions.map((String value) {
                          return FilterChip(
                              showCheckmark: false,
                              selectedColor: Colors.lightBlue,
                              label: Text(
                                value,
                                style: TextStyle(
                                  color: value == region ? Colors.white : Colors.black,
                                ),
                              ),
                              selected: value == region,
                              onSelected: (bool selected) {
                                setState(() {
                                  region = value;
                                });
                              });
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.08,
                  ),
                  LoginButton(onPressed: _verifyRegistration),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                  ButtonText(
                    toggleOnPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Go back to login',
                  ),
                ],
              ),
            ),
          ),
          SkinAnimation(
            isLoading: isLoading,
            skinPath: randomSkinPath,
          ),
        ],
      ),
    );
  }
}
