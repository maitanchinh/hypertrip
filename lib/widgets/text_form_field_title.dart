import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:nb_utils/nb_utils.dart';

class TextFormFieldTitle extends StatefulWidget {
  const TextFormFieldTitle({
    super.key,
    this.title,
    this.style,
    this.keyboardType,
    this.obscureText = false,
    this.inputFormatters,
    this.readOnly = false,
    this.contentPadding,
    this.onChanged,
    this.onSubmit,
    this.onTap,
    this.validator,
    this.errorText = '',
    this.hintText,
    this.hintStyle,
    this.widthPrefix,
    this.heightPrefix,
    this.prefixIcon,
    this.widthSuffix,
    this.heightSuffix,
    this.suffixIcon,
    this.paddingBottom,
    this.minLines,
    this.maxLines = 1,
    this.initialValue,
    this.controller,
    this.textInputAction,
    this.backgroundColor,
    this.borderRadius = 12,
    this.isRequired = false,
  });

  final String? title;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextStyle? hintStyle;
  final String errorText;
  final double? widthPrefix;
  final double? heightPrefix;
  final Widget? prefixIcon;
  final double? widthSuffix;
  final double? heightSuffix;
  final Widget? suffixIcon;
  final double? paddingBottom;
  final int? minLines;
  final int maxLines;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final Color? backgroundColor;
  final double borderRadius;
  final bool isRequired;

  @override
  State<TextFormFieldTitle> createState() => _WidgetTextFormFieldState();
}

class _WidgetTextFormFieldState extends State<TextFormFieldTitle> {
  final FocusNode _focusNode = FocusNode();
  bool isFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocus = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null && widget.title!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: RichText(
              text: TextSpan(
                text: widget.title,
                style: boldTextStyle(size: 16, color: AppColors.textColor),
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.only(bottom: widget.paddingBottom ?? 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: widget.controller,
                textInputAction: widget.textInputAction ?? TextInputAction.done,
                onTap: widget.onTap,
                autocorrect: false,
                onChanged: widget.onChanged,
                onFieldSubmitted: widget.onSubmit,
                validator: widget.validator,
                readOnly: widget.readOnly,
                keyboardType: widget.keyboardType ?? TextInputType.text,
                obscureText: widget.obscureText,
                cursorColor: AppColors.textColor,
                inputFormatters: widget.inputFormatters,
                style:
                    widget.style ?? primaryTextStyle(size: 14, color: AppColors.textColor),
                initialValue: widget.initialValue,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  isCollapsed: true,
                  isDense: true,
                  filled: true,
                  fillColor: widget.backgroundColor ?? Colors.grey.shade100,
                  contentPadding:
                      widget.contentPadding ?? const EdgeInsets.fromLTRB(16, 18, 16, 20),
                  hintText: widget.hintText ?? '',
                  hintStyle: widget.hintStyle ??
                      primaryTextStyle(size: 14, color: AppColors.textColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: widget.readOnly
                          ? Colors.grey
                          : (widget.errorText.isNotEmpty ? Colors.red : AppColors.primaryColor),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: widget.errorText.isNotEmpty ? Colors.red : Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints.tightFor(
                    width: widget.widthPrefix ?? 25,
                    height: widget.heightPrefix ?? 20,
                  ),
                  prefixIcon: widget.prefixIcon,
                  suffixIconConstraints: BoxConstraints.tightFor(
                    width: widget.widthSuffix ?? 25,
                    height: widget.heightSuffix ?? 20,
                  ),
                  suffixIcon: widget.suffixIcon,
                ),
                minLines: widget.minLines,
                maxLines: widget.maxLines,
              ),
              if (widget.errorText.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    Text(
                      widget.errorText,
                      style: secondaryTextStyle(color: Colors.red),
                    )
                  ],
                )
              ]
            ],
          ),
        ),
      ],
    );
  }
}
