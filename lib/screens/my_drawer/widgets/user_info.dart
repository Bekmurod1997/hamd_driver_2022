import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/providers/profile_fetch_provider.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  // final UserProfileController ppController = Get.find<UserProfileController>();
  // final MyProfileController myProfileController =
  //     Get.find<MyProfileController>();
  @override
  Widget build(BuildContext context) {
    // final UserDataController userDataController = Get.put(UserDataController());
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Consumer<ProfileFetchProvider>(
          builder: (context, profile, child) {
            return profile.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            'http://hamd.loko.uz/' + profile.userInfo!.photo!),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // ppController.profileList.first.name ?? '',
                              profile.userInfo?.name ?? '',
                              style: FontStyles.regularStyle(
                                fontSize: 15,
                                fontFamily: 'Ubuntu',
                                color: Color(0xff232323),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              // ppController.profileList.first.phone,
                              profile.userInfo!.phone!,
                              style: FontStyles.boldStyle(
                                fontSize: 15,
                                fontFamily: 'Ubuntu',
                                color: Color(0xff232323),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       'rating'.tr,
                            //       style: FontStyles.regularStyle(
                            //         fontSize: 15,
                            //         fontFamily: 'Ubuntu',
                            //         color: const Color(0xff232323),
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(right: 20),
                            //       child: Row(
                            //         mainAxisAlignment:
                            //             MainAxisAlignment.spaceAround,
                            //         children: [
                            //           Text(
                            //             '${profile.userInfo!.rating}',
                            //             style: FontStyles.lightStyle(
                            //               fontSize: 15,
                            //               fontFamily: 'Ubuntu',
                            //               color: Color(0xff232323),
                            //             ),
                            //           ),
                            //           const Icon(
                            //             Icons.star,
                            //             size: 15,
                            //             color: Color(0xff9F111B),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ],
                  );
          },
        ));
  }
}
