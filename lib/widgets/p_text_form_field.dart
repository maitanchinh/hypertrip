import 'package:flutter/material.dart';

class PTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;

  const PTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    required this.obscureText,
    required this.validator,
    required this.keyboardType,
  }) : super(key: key);

  @override
  State<PTextFormField> createState() => _TextField2State();
}

class _TextField2State extends State<PTextFormField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = _focusNode.hasFocus
        ? Theme.of(context).colorScheme.primary
        : Colors.grey.shade500;

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              // border by focusNode
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                isDense: true,
                labelText: widget.label,
                contentPadding: const EdgeInsets.only(
                  // default
                  top: 8,
                  bottom: 10,
                  left: 15,
                  right: 15,
                ),
                hintStyle: const TextStyle(
                  height: 1.5,
                  fontSize: 8,
                  color: Colors.grey,
                ),
                labelStyle: TextStyle(
                  // height: 1.5,
                  // fontSize: 16,
                  color: borderColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
