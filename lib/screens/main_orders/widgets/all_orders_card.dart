import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/providers/all_orders_provider.dart';
import 'package:hamd_driver/services/all_services.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lyuboy2 = Provider.of<AllOrderProvider>(context, listen: false)
        .allOrders
        .where((e) => e.deliveryType!.id! == 12)
        .toList();

    return Material(
      child: Consumer<AllOrderProvider>(builder: (context, allOrders, child) {
        return allOrders.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : allOrders.allOrders.length > 0 || allOrders.allOrders.isNotEmpty
                ? RefreshIndicator(
                    color: ColorPalatte.strongRedColor,
                    child: ListView.separated(
                        itemCount: allOrders.allOrders.length,
                        // itemCount: allOrders.allOrders.length,
                        // itemCount: allOrderProivder.allOrderModel.data.length,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 15,
                            ),
                        itemBuilder: (context, index) {
                          // Datam allOrder = allOrderProivder.allOrderModel.data[index];
                          // Datam myFilter = lyuboy2[index];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 17, vertical: 19),
                              child: Column(
                                children: [
                                  // Text(lyuboy2.length.toString()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ID: ' +
                                            allOrders.allOrders[index].id
                                                .toString(),
                                        // 'ID: ' + allOrder.id.toString(),
                                        style: FontStyles.regularStyle(
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color: const Color(0xff646974),
                                        ),
                                      ),
                                      Text(
                                        allOrders.allOrders[index].date
                                            .toString(),
                                        style: FontStyles.regularStyle(
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color: const Color(0xff646974),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .1,
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
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .9,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'orderFrom'.tr,
                                                style: FontStyles.regularStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  color:
                                                      const Color(0xffAAAEB7),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                'centerHamd'.tr,
                                                style: FontStyles.boldStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Montserrat',
                                                  color:
                                                      const Color(0xff232323),
                                                ),
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
                                        'price'.tr +
                                            allOrders.allOrders[index]
                                                .productTotalSum
                                                .toString() +
                                            'sum'.tr,
                                        style: FontStyles.regularStyle(
                                          fontSize: 16,
                                          fontFamily: 'Montserrat',
                                          color: const Color(0xff646974),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
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
                                        'deliveryPrice'.tr +
                                            ' ' +
                                            allOrders
                                                .allOrders[index].deliveryPrice
                                                .toString() +
                                            'sum'.tr,
                                        style: FontStyles.regularStyle(
                                          fontSize: 16,
                                          fontFamily: 'Montserrat',
                                          color: const Color(0xff646974),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
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
                                        allOrders.allOrders[index].paymentType
                                                    ?.id ==
                                                16
                                            ? 'payCash'.tr
                                            : 'card'.tr,
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
                                  index == 0
                                      ? SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.86,
                                          height: 50,
                                          child: RaisedButton(
                                            elevation: 0,
                                            color: const Color(0xff9F111B),
                                            onPressed: () async {
                                              await AllServices.acceptOrder(
                                                  context,
                                                  allOrders
                                                      .allOrders[index].id!);

                                              // await AcceptOrder.acceptOrder(
                                              //     myFilter.id);
                                              // screenController.selectTwo();
                                              // allOrdersController.fetchAllOrders();
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Text(
                                              'acceptOrder'.tr,
                                              style: FontStyles.mediumStyle(
                                                fontSize: 16,
                                                fontFamily: 'Montserrat',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          );
                        }),
                    onRefresh: () =>
                        context.read<AllOrderProvider>().fetchAllOrders())
                : Center(
                    child: Text('thereIsNotOrderYet'.tr),
                  );
      }),
    );
  }
}
