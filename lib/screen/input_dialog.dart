import 'package:flutter/material.dart';

class MyInputDialog extends StatefulWidget {
  final String initialValue;
  final String title;
  final String hintText;
  const MyInputDialog(
      {super.key,
      this.initialValue = '',
      this.title = 'أدخل نصا',
      this.hintText = 'أدخل نصا'});
  @override
  State<MyInputDialog> createState() => _MyInputDialogState();
}

class _MyInputDialogState extends State<MyInputDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.initialValue;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text(widget.title),
        content: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(fontSize: 14)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, _textEditingController.text);
            },
            child: const Text(
              'موافق',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
