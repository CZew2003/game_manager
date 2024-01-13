import 'package:flutter/material.dart';

import '../constants/snack_bar.dart';
import 'text_field_login.dart';

class DialogEditClient extends StatefulWidget {
  const DialogEditClient({
    super.key,
    required this.title,
    required this.initialValue,
  });

  final String title;
  final String initialValue;

  @override
  State<DialogEditClient> createState() => _DialogEditClientState();
}

class _DialogEditClientState extends State<DialogEditClient> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.text = widget.initialValue;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 150,
              child: TextFieldLogin(controller: controller, hintText: '', hideText: false),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton.tonal(
                onPressed: () {
                  final double? value = double.tryParse(controller.text);
                  if (value == null) {
                    showSnackBar(context, 'Invalid input');
                    controller.text = widget.initialValue;
                    return;
                  }
                  Navigator.pop(context, value);
                },
                child: const Text('Update'))
          ],
        ),
      ),
    );
  }
}
