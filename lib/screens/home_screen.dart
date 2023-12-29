import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../models/client_info_model.dart';
import '../models/client_model.dart';
import '../services/sql_dta_retriver_client.dart';
import '../widgets/appbar_navigation.dart';
import '../widgets/bottom_navigation.dart';

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

  Future<void> fetchData() async {
    setState(() => isLoading = true);
    clientInfoModel = await sqlDataRetriverClient.getClientInformation(context.read<ClientModel>().user);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/ranks/${clientInfoModel.rank}.png',
                              height: 200,
                              width: 200,
                            ),
                            const Text('Your rank is'),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.black54,
                        thickness: 1.5,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.3,
                        child: CustomScrollView(
                          slivers: <Widget>[
                            const SliverToBoxAdapter(
                              child: Text(
                                'Friends',
                                style: TextStyle(fontSize: 32),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Card(
                                    color: Colors.grey[300],
                                    child: Text(clientInfoModel.friends[index]),
                                  );
                                },
                                childCount: clientInfoModel.friends.length,
                              ),
                            ),
                          ],
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
