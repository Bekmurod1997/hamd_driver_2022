import 'package:flutter/material.dart';

class UserPhoneNumber extends StatelessWidget {
  final String phoneNumber;
  const UserPhoneNumber({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 55.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.phone_android,
              color: Colors.grey,
            ),
          ),
          Flexible(
              child: Text(
            phoneNumber,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          )),
        ],
      ),
    );
  }
}
