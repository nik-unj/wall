import 'package:flutter/material.dart';
import 'package:wall/style/styles.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String name;

  const CustomButton({
    Key? key,
    this.onTap,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.black),
        child: Center(
          child: Text(
            name,
            style: CustomStyle.blackNeue(30).copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
