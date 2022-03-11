import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hamd_driver/components/custom_appbar.dart';
import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/providers/income_provder.dart';
import 'package:hamd_driver/screens/income/widgets/income_list_card.dart';
import 'package:hamd_driver/screens/income/widgets/tab_button.dart';
import 'package:provider/provider.dart';

class IncomeSreen extends StatefulWidget {
  @override
  _IncomeSreenState createState() => _IncomeSreenState();
}

class _IncomeSreenState extends State<IncomeSreen> {
  // final MyIncomeController myIncomeController = Get.find<MyIncomeController>();

  @override
  void initState() {
    // myIncomeController.fetchMyIncomeDay();
    // myIncomeController.fetchMyIncomeWeek();
    // myIncomeController.fetchMyIncomeMonth();
    super.initState();
  }

  String incomeTotal = '0';
  int selectedIndex = 0;

  // _callContent() {
  //   int totalIncome = 0;
  //   return Obx(
  //     () {
  //       if (myIncomeController.isLoading()) {
  //         return Center(
  //           child: CircularProgressIndicator(
  //             valueColor: AlwaysStoppedAnimation<Color>(
  //               ColorPalatte.strongRedColor,
  //             ),
  //           ),
  //         );
  //       }
  //       else if (selectedIndex == 0) {
  //         // myIncomeController.myIncomeDayList[0].orders.length == 0 ||
  //         //         myIncomeController.myIncomeDayList.isNotEmpty
  //         //     ?
  //         // totalIncome =
  //         //     myIncomeController.myIncomeDayList[0].orders?.length ?? 0 * 12500;
  //         // : totalIncome;
  //         return TabButton(
  //             title: 'forDay',
  //             income:
  //                 //  myIncomeController.myIncomeDayList[0].total == 0
  //                 // ?
  //                 'youHaveNotEarnedYet'.tr
  //             // : (12500 * totalIncome).toString() + 'sum'.tr,
  //             // income: totalIncome.toString(),
  //             // myIncomeController.myIncomeDayList[0].total.toString() + ' сум',
  //             );
  //       } else if (selectedIndex == 1) {
  //         // totalIncome = myIncomeController.myIncomeWeekList[0].orders?.length ??
  //         //     0 * 12500;
  //         // : totalIncome;
  //         return TabButton(
  //             title: 'forWeek',
  //             income:
  //                 // myIncomeController.myIncomeWeekList[0].total == 0
  //                 //     ?
  //                 'youHaveNotEarnedYet'.tr
  //             // : (12500 * totalIncome).toString() + 'sum'.tr,
  //             );
  //       }

  //       // totalIncome =
  //       // myIncomeController.myIncomeMonthList[0].orders?.length ?? 0 * 12500;
  //       // : totalIncome;
  //       return TabButton(
  //           title: 'forMonth',
  //           income:
  //               //  myIncomeController.myIncomeDayList[0].total == 0
  //               //     ?
  //               'youHaveNotEarnedYet'.tr
  //           // : (12500 * totalIncome).toString() + 'sum'.tr,
  //           // income: totalIncome.toString() + 'sum'.tr,
  //           );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalatte.mainPageColor,
        appBar: PreferredSize(
          child: customAppBar(
            context,
            title: 'myIncome',
            onpress1: () => Get.back(),
          ),
          preferredSize: Size.fromHeight(
              kToolbarHeight + MediaQuery.of(context).viewPadding.top),
        ),
        body: Consumer<IncomeProvider>(
          builder: (context, income, child) {
            return income.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
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
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 3),
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
                                        if (selectedIndex == 1 ||
                                            selectedIndex == 2) {
                                          setState(() {
                                            selectedIndex = 0;
                                          });
                                          // myIncomeController.fetchMyIncomeDay();
                                          context
                                              .read<IncomeProvider>()
                                              .fetchMyIncome('day');
                                          print(selectedIndex.toString());
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
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
                                        if (selectedIndex == 0 ||
                                            selectedIndex == 2) {
                                          setState(() {
                                            selectedIndex = 1;
                                          });
                                          context
                                              .read<IncomeProvider>()
                                              .fetchMyIncome('week');
                                          // myIncomeController.fetchMyIncomeWeek();
                                        }
                                        print(selectedIndex.toString());
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
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
                                      if (selectedIndex == 0 ||
                                          selectedIndex == 1) {
                                        setState(() {
                                          selectedIndex = 2;
                                        });
                                        context
                                            .read<IncomeProvider>()
                                            .fetchMyIncome('month');
                                        // myIncomeController.fetchMyIncomeMonth();
                                      }
                                      print(selectedIndex.toString());
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
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
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                            // children: [_callContent()],
                            ),
                      ),
                      const SizedBox(height: 15),
                      // Expanded(
                      //     child: Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 16),
                      //   child: IncomeListCard(selected: selectedIndex),
                      // )),
                      TabButton(
                          title: selectedIndex == 0
                              ? 'forDay'
                              : selectedIndex == 1
                                  ? 'forWeek'
                                  : 'forMonth',
                          income: income.myIncomeList!.total.toString()),
                      const SizedBox(height: 15),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: IncomeListCard(
                              myData: income.myIncomeList,
                            )
                            // child: selectedIndex == 0
                            //     ? IncomeListCardDay()
                            //     : selectedIndex == 1
                            //         ? IncomeListCardWeek()
                            //         : IncomeListCardMonth(),
                            ),
                      ),
                    ],
                  );
          },
        ));
  }
}
