import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/fonts.dart';

AppBar customAppBar(BuildContext context,
    {required String title,
    required VoidCallback onpress1,
    double? width1,
    double? height1,
    Widget? icon}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: ColorPalatte.strongRedColor,
    elevation: 0,
    flexibleSpace: Padding(
      padding: const EdgeInsets.only(top: 45, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: icon != null
                      ? icon
                      : IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 26,
                          ),
                          onPressed: onpress1),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                title.tr,
                textAlign: TextAlign.center,
                style: FontStyles.boldStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    ),
  );
}
