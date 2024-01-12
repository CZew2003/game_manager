import 'package:flutter/material.dart';
import 'package:game_manager/widgets/text_field_login.dart';

class FriendsWidget extends StatelessWidget {
  const FriendsWidget({
    super.key,
    required this.toggleOnPressedIcon,
    required this.toggleOnPressedBtn,
    required this.showTextField,
    required this.controller,
    required this.friends,
  });

  final void Function() toggleOnPressedIcon;
  final void Function() toggleOnPressedBtn;
  final bool showTextField;
  final TextEditingController controller;
  final List<String> friends;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Friends',
                  style: TextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
              ),
              TextButton(
                onPressed: toggleOnPressedIcon,
                style: const ButtonStyle(
                    overlayColor: MaterialStatePropertyAll<Color>(
                  Colors.transparent,
                )),
                child: Icon(
                  showTextField ? Icons.close : Icons.add,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        if (showTextField)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFieldLogin(
                      controller: controller,
                      hintText: 'Add a friend',
                      hideText: false,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: toggleOnPressedBtn,
                    child: const Text('Add'),
                  ),
                ],
              ),
            ),
          ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '\u2022',
                        style: TextStyle(
                          fontSize: 32,
                          height: 0.5,
                          color: Colors.blue[800],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        friends[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[600],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: friends.length,
          ),
        ),
      ],
    );
  }
}
