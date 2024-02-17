import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildTextFormField({
  required BuildContext context,
  required String hintText,
  required TextInputType keyboardType,
  required void Function(String?) onSaved,
  void Function(String)? onChanged,
  final String? Function(String?)? validator,
  TextEditingController? controller,
  bool readOnly = false,
  void Function()? onTap,
  bool obscureText = false,
  int? maxlines = 1,
  final Icon? icon,
  FocusNode? focusNode,
  FocusNode? nextFocusNode,
}) {
  const double paddingValue = 30;

  return Padding(
    padding: const EdgeInsets.fromLTRB(paddingValue, 0, paddingValue, 0),
    child: TextFormField(
      onChanged: onChanged,
      readOnly: readOnly,
      maxLines: maxlines,
      controller: controller,
      onTap: onTap,
      validator: validator,
      cursorColor: Colors.white,
      cursorWidth: 1,
      cursorHeight: 20,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      onSaved: onSaved,
      focusNode: focusNode,
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },
      keyboardType: keyboardType,
      decoration: InputDecoration(
        icon: icon,
        filled: true,
        fillColor: Colors.transparent,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 14,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x8062F4F4), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x8062F4F4), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x8062F4F4), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x8062F4F4), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x8062F4F4), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 10,
        ),
      ),
      obscureText: obscureText,
    ),
  );
}

Widget buildPasswordTextFormField(
    {required BuildContext context,
    required String hintText,
    final Text? labelText,
    required TextInputType keyboardType,
    required void Function(String?) onSaved,
    final String? Function(String?)? validator,
    TextEditingController? controller,
    bool readOnly = false,
    void Function()? onTap,
    bool obscureText = false,
    int? maxlines = 1,
    final Widget? trailingicon}) {
  const double paddingValue = 30;

  return Padding(
    padding: const EdgeInsets.fromLTRB(paddingValue, 0, paddingValue, 0),
    child: TextFormField(
      readOnly: readOnly,
      maxLines: maxlines,
      controller: controller,
      onTap: onTap,
      cursorColor: Colors.white,
      cursorWidth: 1,
      cursorHeight: 20,
      validator: validator,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      onSaved: onSaved,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: trailingicon,
        filled: true,
        fillColor: Colors.transparent,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x8062F4F4), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x8062F4F4), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x8062F4F4), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x8062F4F4), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x8062F4F4), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 10,
        ),
      ),
      obscureText: obscureText,
    ),
  );
}

Widget buildGenderRadioButtons({
  required BuildContext context,
  required void Function(String) onSaved,
  String? groupValue,
  void Function(String?)? onChanged,
}) {
  const double paddingValue = 30;

  return Padding(
    padding: const EdgeInsets.fromLTRB(paddingValue, 0, paddingValue, 0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 10,
        ),
        Row(
          children: [
            Radio<String>(
              activeColor: const Color(0x9024CCCC),
              visualDensity: const VisualDensity(vertical: -2, horizontal: -2),
              value: 'M',
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            SvgPicture.asset(
              "assets/icons/male.svg",
              height: 20,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Male',
              style: TextStyle(
                color:
                    groupValue == 'M' ? const Color(0xFF24CCCC) : Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Row(
          children: [
            Radio<String>(
              activeColor: const Color(0x9024CCCC),
              visualDensity: const VisualDensity(vertical: -2, horizontal: -2),
              value: 'F',
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            SvgPicture.asset(
              "assets/icons/female.svg",
              height: 18,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Female',
              style: TextStyle(
                color:
                    groupValue == 'F' ? const Color(0xFF24CCCC) : Colors.white,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
