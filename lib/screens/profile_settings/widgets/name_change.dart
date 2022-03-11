import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/providers/profile_fetch_provider.dart';
import 'package:provider/provider.dart';

class UserNameChange extends StatelessWidget {
  final TextEditingController? nameController;
  const UserNameChange({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'name'.tr,
            style: FontStyles.regularStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
              color: const Color(0xff232323),
            ),
          ),
          TextFormField(
            controller: nameController,
            onChanged: (value) {
              Provider.of<ProfileFetchProvider>(context, listen: false)
                  .userNameChanger(context, value);
            },
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 0.0),
              hintText: 'hintName'.tr,
              hintStyle: FontStyles.regularStyle(
                fontSize: 17,
                fontFamily: 'Ubuntu',
                color: Color(0xff232323),
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
