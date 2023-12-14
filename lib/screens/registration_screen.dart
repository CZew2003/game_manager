import 'package:flutter/material.dart';
import 'package:game_manager/screens/home_screen.dart';
import 'package:game_manager/screens/registration_screen.dart';
import 'package:game_manager/services/connector.dart';
import 'package:game_manager/services/sql_queries.dart';
import 'package:game_manager/widgets/skin_animation.dart';
import 'package:game_manager/widgets/text_field_login.dart';
import 'package:mysql1/mysql1.dart';

import '../services/sql_data_retriver_registration.dart';

class RegistrationScreen extends StatefulWidget {
  static const route = '/registration-screen';

  const RegistrationScreen({super.key});
  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  String randomSkinPath = '';
  bool isLoading = true;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  bool error = false;
  bool animation = true;
  SqlDataRetriverRegistration sqlDataRetriverRegistration = SqlDataRetriverRegistration();
  String dropdownValue = 'na';

  void _getCustomSkin() async {
    while (animation) {
      randomSkinPath = await sqlDataRetriverRegistration.getRandomSkinFromDatabase();
      setState(() => isLoading = false);
      await Future.delayed(const Duration(seconds: 3));
    }
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
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
              child: ListView(
                children: [
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
                    controller: controller1,
                    hintText: 'REPEAT PASSWORD',
                    hideText: true,
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    items: <String>['eune', 'euw', 'na'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
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
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.08,
                  ),
                  Center(
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () async {
                        if (controller1.text.isEmpty || controller2.text.isEmpty || controller3.text.isEmpty) {
                          setState(() {
                            error = true;
                          });
                          await Future.delayed(const Duration(seconds: 1));
                          setState(() {
                            error = false;
                          });
                          return;
                        }
                        /*db.getConnection().then(
                              (conn) => db.getQueryResults(
                                conn,
                                callProcedura,
                                [controller1.text, controller2.text, controller3.text, controller4.text],
                              ).then((results) async {
                                if (results.isNotEmpty) {
                                  Navigator.pushNamed((context), HomeScreen.route);
                                } else {
                                  setState(() {
                                    error = true;
                                  });
                                  await Future.delayed(const Duration(seconds: 1));
                                  setState(() {
                                    error = false;
                                  });
                                }
                              }),
                            ); */
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
