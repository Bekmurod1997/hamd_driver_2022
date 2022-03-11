import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamd_driver/constants/fonts.dart';

class MenuOptions extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  MenuOptions({required this.title, required this.onpress});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpress,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(
          title.tr,
          style: FontStyles.regularStyle(
            fontSize: 15,
            fontFamily: 'Ubuntu',
            color: const Color(0xff232323),
          ),
        ),
      ),
    );
  }
}
