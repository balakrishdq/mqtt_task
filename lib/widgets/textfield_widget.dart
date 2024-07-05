import '../../imports/index.dart';

class CustomInputField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String placeHolder;
  final TextInputType keyBoardType;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final Color? filledColor;
  final Color? placeHolderColor;
  final Color? hintColor;
  final bool? isPassword;
  final bool? viewHelperText;
  final bool? readOnly;
  final int maxLines;
  final int? lengthLimit;
  final int? maxLength;
  final EdgeInsetsGeometry? margin;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const CustomInputField({
    required this.controller,
    required this.placeHolder,
    required this.keyBoardType,
    this.prefixIcon,
    this.readOnly,
    this.validator,
    this.focusNode,
    this.margin,
    this.onFieldSubmitted,
    this.isPassword,
    this.filledColor,
    this.placeHolderColor,
    this.hintColor,
    this.viewHelperText,
    this.onChanged,
    this.onTap,
    this.lengthLimit,
    this.maxLength,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(bottom: 1.h),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: maxLength,
        onChanged: onChanged,
        style: Style.textStyles.primary(
          color: Style.colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        autofocus: true,
        controller: controller,
        readOnly: readOnly ?? false,
        validator: validator,
        textCapitalization: textCapitalization,
        keyboardType: keyBoardType,
        onTap: onTap,
        minLines: maxLines,
        maxLines: maxLines,
        inputFormatters: [
          LengthLimitingTextInputFormatter(lengthLimit),
        ],
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          helperText: '',
          labelText: placeHolder,
          labelStyle: Style.textStyles.primary(
            color: placeHolderColor,
            fontWeight: FontWeight.w400,
          ),
          isDense: true,
          fillColor: filledColor ?? Style.colors.white,
          filled: true,
          errorStyle: Style.textStyles.primary(
            color: Style.colors.red,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Style.colors.red,
            ),
            borderRadius: BorderRadius.circular(8.sp),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Style.colors.red,
            ),
            borderRadius: BorderRadius.circular(8.sp),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Style.colors.primary,
            ),
            borderRadius: BorderRadius.circular(8.sp),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Style.colors.grey.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(8.sp),
          ),
        ),
      ),
    );
  }
}
