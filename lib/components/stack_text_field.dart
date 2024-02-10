import 'package:flutter/material.dart';

class StackedTextField extends StatelessWidget {
  const StackedTextField({
    super.key,
    this.onChanged,
    required this.positionedButtons,
    this.hintText = '',
    this.initialText = '',
    this.validationText = 'نص فارغ',
  });

  final void Function(String)? onChanged;
  final List<Widget> positionedButtons;
  final String? hintText;
  final String? validationText;
  final String? initialText;

  @override
  Widget build(BuildContext context) {
    final TextEditingController descriptionController = TextEditingController();
    descriptionController.text = initialText!;
    final width = MediaQuery.of(context).size.width;
    return Stack(children: [
      Container(
        padding: EdgeInsets.all(width * 0.03),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.top,
          expands: true,
          onChanged: onChanged,
          controller: descriptionController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            hintMaxLines: 5,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * 0.03),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * 0.03),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
          ),
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          validator: (value) {
            if (value!.isEmpty) {
              return validationText;
            }
            return null;
          },
        ),
      ),
      Positioned(
          left: 12,
          bottom: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var item in positionedButtons)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: item,
                )
            ],
          ))
    ]);
  }
}
