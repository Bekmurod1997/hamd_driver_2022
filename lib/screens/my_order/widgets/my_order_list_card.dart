import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/models/accepted_order_model.dart';
import 'package:get/get.dart';

class MyOrderListCard extends StatelessWidget {
  final List<Data> myOrders;
  const MyOrderListCard({Key? key, required this.myOrders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: myOrders.length,
      itemBuilder: (context, index) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 19),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Id: ${myOrders[index].id}',
                    style: FontStyles.regularStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: Color(0xff646974),
                    ),
                  ),
                  Text(
                    '${myOrders[index].date}',
                    style: FontStyles.regularStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: Color(0xff646974),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .1,
                      color: Colors.white,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/location.svg',
                            height: 35,
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffB6C5EE),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffB6C5EE),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffB6C5EE),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff9F111B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'order'.tr,
                            style: FontStyles.regularStyle(
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              color: Color(0xffAAAEB7),
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'centerHamd'.tr,
                            style: FontStyles.boldStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              color: Color(0xff232323),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'goingTo'.tr,
                            style: FontStyles.regularStyle(
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              color: Color(0xffAAAEB7),
                            ),
                          ),
                          Text(
                            '${myOrders[index].address}',
                            style: FontStyles.boldStyle(
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              color: Color(0xff232323),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    'price'.tr,
                    style: FontStyles.regularStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: Color(0xff646974),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${myOrders[index].productTotalSum}' +
                        'sum'.tr +
                        '(2500' +
                        'sum'.tr +
                        ')',
                    style: FontStyles.regularStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset('assets/images/cards.png'),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    'payCash'.tr,
                    style: FontStyles.boldStyle(
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
