import 'package:flutter/material.dart';

class EcoTextField extends StatelessWidget {
  EcoTextField(
      {required this.hintxt,
      this.validate,
      this.contrl,
      this.icon,
      this.check = false,
      this.obsecure = false,
      this.focusnode,
      this.textinputAction
      //required this.obsecure
      });
  String hintxt;
  String Function(String?)? validate;
  TextEditingController? contrl;
  //bool obsecure;
  Widget? icon;
  bool check;
  bool obsecure;
  final TextInputAction? textinputAction;
  final FocusNode? focusnode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.5),
      ),
      child: TextFormField(
        validator: validate,
        controller: contrl,
        focusNode: focusnode,
        textInputAction: textinputAction,
        obscureText: obsecure,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: icon,
          hintText: hintxt,
          // labelText: hinttxt,
          contentPadding: EdgeInsets.all(13),
        ),
      ),
    );
  }
}
