import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_itmu/framework/core/style/app_colors.dart';

class ItindoTextField extends StatefulWidget {
  const ItindoTextField(
      {super.key,
      this.hintText,
      this.controller,
      this.isPassword = false,
      this.suffixIcon,
      this.validator,
      this.onChanged,
      this.inputFormatters,
      this.prefixIcon,
      TextInputType? keyboardType,
      this.maxLength,
      this.contentPaddingVertikal,
      this.labelText})
      : keyboardType = keyboardType ?? (TextInputType.text),
        assert(maxLength == null ||
            maxLength == TextField.noMaxLength ||
            maxLength > 0);

  final String? hintText, labelText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool isPassword;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final int? maxLength;
  final Widget? prefixIcon;
  final double? contentPaddingVertikal;

  @override
  State<ItindoTextField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<ItindoTextField> {
  late final TextEditingController controller;

  late bool obsecureText;
  late bool isError;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();

    obsecureText = widget.isPassword;
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorRadius: const Radius.circular(16),
      cursorColor: Colors.grey,
      obscureText: obsecureText,
      controller: controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      // onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: AppColors.blackColor),
      decoration: InputDecoration(
        label: Text(
          widget.labelText ?? '-',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: AppColors.blackColor),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        suffixIconColor: AppColors.primaryColor,
        suffixIcon: widget.suffixIcon ??
            (widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        obsecureText = !obsecureText;
                      });
                    },
                    icon: Icon(
                        obsecureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.blackColor),
                  )
                : null),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
