import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextF extends StatefulWidget {
  const TextF(
      {super.key,
      this.curFocusNode,
      this.nextFocusNode,
      this.hint,
      this.validator,
      this.onChanged,
      this.keyboardType,
      this.textInputAction,
      this.obscureText,
      this.suffixIcon,
      this.controller,
      this.onTap,
      this.textAlign,
      this.enable,
      this.inputFormatter,
      this.minLine,
      this.maxLine,
      this.prefixIcon,
      this.isHintVisible = true,
      this.prefixText,
      this.hintText,
      this.autofillHints,
      this.semantic,
      this.labelText,
      this.initialValue,
      this.maxLength,
      this.autofocus,
      this.focusBorderColor,
      this.onEditComplete,
      this.expands,
      this.filled,
      this.fillColor});

  final FocusNode? curFocusNode;
  final FocusNode? nextFocusNode;
  final String? hint;
  final String? labelText;
  final Function(String?)? validator;
  final Function(String)? onChanged;
  final Function()? onEditComplete;
  final Function? onTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? obscureText;
  final int? minLine;
  final int? maxLine;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final bool? enable;
  final List<TextInputFormatter>? inputFormatter;
  final bool isHintVisible;
  final Widget? prefixIcon;
  final String? prefixText;
  final String? hintText;
  final Iterable<String>? autofillHints;
  final String? semantic;
  final String? initialValue;
  final Color? focusBorderColor;
  final int? maxLength;
  final bool? autofocus;
  final bool? filled;
  final bool? expands;
  final Color? fillColor;

  @override
  TextFState createState() => TextFState();
}

class TextFState extends State<TextF> {
  bool isFocus = false;
  String currentVal = "";

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      initialValue: widget.initialValue,
      expands: widget.expands ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: widget.autofillHints,
      enabled: widget.enable,
      obscureText: widget.obscureText ?? false,
      focusNode: widget.curFocusNode,
      autofocus: widget.autofocus ?? false,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      textAlign: widget.textAlign ?? TextAlign.start,
      minLines: widget.minLine ?? 1,
      maxLines: widget.maxLine ?? 10,
      inputFormatters: widget.inputFormatter,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.bodySmall,
      cursorColor: Theme.of(context).colorScheme.primary,
      onEditingComplete: widget.onEditComplete,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixText: widget.prefixText,
        alignLabelWithHint: true,
        isDense: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        counterText: "",
        hintStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: const Color(0xff212121).withOpacity(.5), fontSize: 14.sp),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Transform.scale(
            scale: 1.4,
            child: SizedBox(
              width: 24.w,
              height: 24.h,
              child: widget.suffixIcon,
            ),
          ),
        ),
        prefixIcon: widget.prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Transform.scale(
                  scale: 1.4,
                  child: SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: widget.prefixIcon,
                  ),
                ),
              ),
        prefixIconConstraints: BoxConstraints(
          minHeight: 24.h,
          minWidth: 24.w,
        ),
        contentPadding: EdgeInsets.all(20.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 1.w),
        ),
      ),
    );
  }
}
