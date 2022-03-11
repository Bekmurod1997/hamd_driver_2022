import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamd_driver/constants/fonts.dart';

class TabButton extends StatelessWidget {
  final String title;
  final String income;

  TabButton({required this.title, required this.income});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Text(
              title.tr,
              style: FontStyles.boldStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Color(0xff232323),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              income,
              style: FontStyles.boldStyle(
                fontSize: 21,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
