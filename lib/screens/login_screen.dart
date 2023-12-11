import 'package:flutter/material.dart';
import 'package:game_manager/screens/home_screen.dart';
import 'package:game_manager/services/connector.dart';
import 'package:game_manager/services/sql_queries.dart';
import 'package:mysql1/mysql1.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/';

  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  var db = Connector();
  String randomSkinPath = '';
  bool isLoading = true;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  bool error = false;

  void _getCustomer() async {
    MySqlConnection conn = await db.getConnection();
    Results results = await db.getQueryResults(conn, getRandomSkin);
    setState(() {
      isLoading = true;
    });
    for (var result in results) {
      randomSkinPath = '${result[0]}_${result[1]}.jpg';
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _getCustomer,
        child: const Icon(
          Icons.add,
        ),
      ),
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
                    'Sign in with your Game Manager Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: controller1,
                      cursorColor: Colors.black,
                      textAlign: TextAlign.center,
                      onChanged: (String value) {
                        setState(() {
                          error = false;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'USERNAME',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: controller2,
                      onChanged: (String value) {
                        setState(() {
                          error = false;
                        });
                      },
                      obscureText: true,
                      cursorColor: Colors.black,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'PASSWORD',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1.5),
                        ),
                      ),
                    ),
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
                        if (controller1.text.isEmpty || controller2.text.isEmpty) {
                          setState(() {
                            error = true;
                          });
                          await Future.delayed(const Duration(seconds: 1));
                          setState(() {
                            error = false;
                          });
                          return;
                        }
                        db.getConnection().then(
                              (conn) => db.getQueryResults(
                                conn,
                                verifyLoginUser,
                                [controller1.text, controller2.text],
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
                            );
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
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: const Text(
                        'Register an Account',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Builder(builder: (context) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Image.asset(
                'assets/skins/$randomSkinPath',
                fit: BoxFit.cover,
              );
            }),
          ),
        ],
      ),
    );
  }
}
