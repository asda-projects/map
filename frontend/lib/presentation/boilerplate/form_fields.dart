import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final bool obscureText;
  final String? Function(String?)? validator; // Validator parameter
  final double? fontSize;
  
  const CustomTextFormField({
    super.key, 
    required this.controller,
    required this.labelText,
    this.hintText,
    this.obscureText = false, 
    this.validator, 
    this.fontSize, 
    
  });

  



  @override
  Widget build(BuildContext context) {

    

    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: fontSize
        ),
      decoration: InputDecoration(
      labelStyle: TextStyle(fontSize: fontSize),
        hintStyle:  TextStyle(fontSize: fontSize),
        errorMaxLines: 3,
        labelText: labelText,
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200], // Background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5), // Rounded corners
          borderSide: const BorderSide(color: Colors.blueGrey), // Border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5), // Rounded corners for focused state
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ), // Border color when focused
        ),
        floatingLabelStyle: TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
    ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5), // Default border corners
          borderSide: const BorderSide(color: Colors.grey), // Default border color
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5), // Error border corners
          borderSide: const BorderSide(color: Colors.red), // Error border color
        ),
      ),
      obscureText: obscureText,
      validator: validator, // Use the validator
    );
  }
}
