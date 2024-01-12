import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../constants/snack_bar.dart';
import '../models/client_info_model.dart';
import '../models/client_model.dart';
import '../services/sql_data_retriever_client.dart';
import '../widgets/appbar_navigation.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/friends_widget.dart';
import '../widgets/show_client_infos.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String route = '/Home-Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqlDataRetriverClient sqlDataRetriverClient = SqlDataRetriverClient();
  late ClientInfoModel clientInfoModel;
  bool isLoading = true;
  bool showTextField = false;
  TextEditingController controller = TextEditingController();

  Future<void> fetchData() async {
    setState(() => isLoading = true);
    clientInfoModel = await sqlDataRetriverClient.getClientInformation(context.read<ClientModel>().user);
    setState(() => isLoading = false);
  }

  Future<void> addFriend(String friend) async {
    if (friend == context.read<ClientModel>().user) {
      showSnackBar(context, 'Cannot add yoursef');
      return;
    }
    await sqlDataRetriverClient.addFriend(context.read<ClientModel>().user, friend).then((bool result) {
      if (result) {
        setState(() => clientInfoModel.friends.add(friend));
      } else {
        showSnackBar(context, 'Cannot find $friend or already friends');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarNavigation(
        toggleOnTap: () {
          Navigator.pop(context);
        },
      ).build(context),
      bottomNavigationBar: const BottomNavigation(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              appBarColor,
              bottomAppBarColor,
            ],
          ),
        ),
        child: Builder(
          builder: (BuildContext context) {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: <Widget>[
                Text(
                  'Welcome back ${clientInfoModel.username}!',
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ShowClientInfos(
                        clientInfoModel: clientInfoModel,
                      ),
                      const VerticalDivider(
                        color: Colors.black54,
                        thickness: 1.5,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.3,
                        child: FriendsWidget(
                          toggleOnPressedIcon: () {
                            setState(() => showTextField = !showTextField);
                            if (!showTextField) {
                              controller.clear();
                            }
                          },
                          toggleOnPressedBtn: () {
                            addFriend(controller.text);
                            controller.clear();
                          },
                          showTextField: showTextField,
                          controller: controller,
                          friends: clientInfoModel.friends,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
