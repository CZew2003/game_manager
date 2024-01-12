import 'package:flutter/material.dart';

import '../models/client_info_model.dart';
import 'show_client_specific.dart';

class ShowClientInfos extends StatelessWidget {
  const ShowClientInfos({
    super.key,
    required this.clientInfoModel,
  });

  final ClientInfoModel clientInfoModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0, top: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/banner.png',
              height: 400,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/ranks/${clientInfoModel.rank}.png',
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    clientInfoModel.rank,
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ShowClientSpecific(
                        title: 'Status',
                        text: clientInfoModel.statusMatches.toString(),
                        foreground: Colors.white,
                        background: Colors.blue,
                      ),
                      ShowClientSpecific(
                        title: 'Region',
                        text: clientInfoModel.region,
                        foreground: Colors.white,
                        background: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
