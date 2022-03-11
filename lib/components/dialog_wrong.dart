import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamd_driver/constants/colors.dart';

wrongDialog() {
  return Get.dialog(
    GestureDetector(
      onTap: () => Get.back(),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(.1),
        body: Center(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              color: Colors.white,
              width: double.infinity,
              // height: 140.0,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      // GestureDetector(
                      //   onTap: () {
                      //     Get.back();
                      //   },
                      //   child: Container(
                      //     alignment:
                      //         Alignment.topRight,
                      //     child: Icon(
                      //       Icons.cancel,
                      //       color:
                      //           ColorPalate.mainColor,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      Text('someThingWentWrong'.tr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 30),
                    ],
                  ),
                  Positioned(
                    top: 15,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.cancel,
                          color: ColorPalatte.strongRedColor,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    ),
  );
}
