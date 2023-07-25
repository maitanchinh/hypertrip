import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';

class PTextFormField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChange;

  const PTextFormField({
    Key? key,
    this.label,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.onChange,
  }) : super(key: key);

  @override
  State<PTextFormField> createState() => _TextField2State();
}

class _TextField2State extends State<PTextFormField> {
  late FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor =
        _focusNode.hasFocus ? AppColors.primaryColor : Colors.grey.shade500;
    print(_focusNode);
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: _focusNode.hasFocus
                  ? AppColors.primaryColor.withOpacity(0.2)
                  : AppColors.primaryColor.withOpacity(0.1),
              // border by focusNode
            ),
            child: TextFormField(
              onChanged: widget.onChange,
              controller: widget.controller,
              focusNode: _focusNode,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              decoration: InputDecoration(
                focusColor: AppColors.primaryColor.withOpacity(0.2),
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
