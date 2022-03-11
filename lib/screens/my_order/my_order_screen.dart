import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamd_driver/components/custom_appbar.dart';
import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/providers/my_orders_provider.dart';
import 'package:hamd_driver/screens/my_order/widgets/my_order_list_card.dart';
import 'package:provider/provider.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int selectedIndex = 0;
  // final MyAcceptedOrdersUniversalController
  //     myAccpetedOrdersUniversalController =
  //     Get.find<MyAcceptedOrdersUniversalController>();
  @override
  void initState() {
    // myAccpetedOrdersUniversalController.fetchAllAcceptedOrdersDay();
    // myAccpetedOrdersUniversalController.fetchAllAcceptedOrdersWeek();
    // myAccpetedOrdersUniversalController.fetchAllAcceptedOrdersMonth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalatte.mainPageColor,
      appBar: PreferredSize(
        child: customAppBar(
          context,
          title: 'myOrders',
          onpress1: () => Get.back(),
          icon: null,
        ),
        preferredSize: Size.fromHeight(
            kToolbarHeight + MediaQuery.of(context).viewPadding.top),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: ColorPalatte.strongRedColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 14),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffC3696F),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  color: ColorPalatte.strongRedColor,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: RaisedButton(
                          elevation: 0,
                          color: selectedIndex == 0
                              ? Colors.white
                              : Colors.transparent,
                          onPressed: () {
                            if (selectedIndex == 1 || selectedIndex == 2) {
                              setState(() {
                                selectedIndex = 0;
                              });
                              context
                                  .read<MyOrdersProvider>()
                                  .fetchMyOrders('day');
                              // myAccpetedOrdersUniversalController
                              //     .fetchAllAcceptedOrdersDay();
                              print(selectedIndex.toString());
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            'forDay'.tr,
                            style: FontStyles.boldStyle(
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              color: selectedIndex == 0
                                  ? Colors.black
                                  : const Color(
                                      0xffCDE8F4,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: RaisedButton(
                          elevation: 0,
                          color: selectedIndex == 1
                              ? Colors.white
                              : Colors.transparent,
                          onPressed: () {
                            if (selectedIndex == 0 || selectedIndex == 2) {
                              setState(() {
                                selectedIndex = 1;
                              });
                              context
                                  .read<MyOrdersProvider>()
                                  .fetchMyOrders('week');
                              // myAccpetedOrdersUniversalController
                              //     .allAcceptedOrdersWeekList();
                            }
                            print(selectedIndex.toString());
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: Text(
                            'forWeek'.tr,
                            style: FontStyles.boldStyle(
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              color: selectedIndex == 1
                                  ? Colors.black
                                  : const Color(
                                      0xffCDE8F4,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 44,
                      child: RaisedButton(
                        elevation: 0,
                        color: selectedIndex == 2
                            ? Colors.white
                            : Colors.transparent,
                        onPressed: () {
                          if (selectedIndex == 0 || selectedIndex == 1) {
                            setState(() {
                              selectedIndex = 2;
                            });
                            context
                                .read<MyOrdersProvider>()
                                .fetchMyOrders('month');
                            // myAccpetedOrdersUniversalController
                            //     .allAcceptedOrdersMonthList();
                          }
                          print(selectedIndex.toString());
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          'forMonth'.tr,
                          style: FontStyles.boldStyle(
                            fontSize: 13,
                            fontFamily: 'Montserrat',
                            color: selectedIndex == 2
                                ? Colors.black
                                : const Color(
                                    0xffCDE8F4,
                                  ),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Consumer<MyOrdersProvider>(
            builder: (context, myOrders, child) {
              return myOrders.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: MyOrderListCard(
                        myOrders: myOrders.myOrders,
                        // selected: selectedIndex,
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}
