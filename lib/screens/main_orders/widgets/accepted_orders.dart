import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/providers/all_accepted_orders_provider.dart';
import 'package:hamd_driver/screens/main_orders/location/map_sheet.dart';
import 'package:hamd_driver/screens/main_orders/widgets/my_icons.dart';
import 'package:hamd_driver/services/all_services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';

class AcceptedOrders extends StatefulWidget {
  const AcceptedOrders({Key? key}) : super(key: key);

  @override
  State<AcceptedOrders> createState() => _AcceptedOrdersState();
}

class _AcceptedOrdersState extends State<AcceptedOrders> {
  double? destinationLatitude;
  double? destinationLongitude;
  String destinationTitle = 'Ocean Beach';
  double originLatitude = 39.645293;

  double originLongitude = 66.954771;

  String originTitle = 'Pier 33';

  @override
  Widget build(BuildContext context) {
    return Material(child: Consumer<AllAcceptedOrdersProvider>(
        builder: (context, accepted, child) {
      return accepted.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          // : Text(accepted.acceptedOrders.length.toString());
          : accepted.acceptedOrders.isNotEmpty ||
                  accepted.acceptedOrders.length > 0
              ? RefreshIndicator(
                  color: ColorPalatte.strongRedColor,
                  onRefresh: () => context
                      .read<AllAcceptedOrdersProvider>()
                      .fetchAllAcceptedOrders(),
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                      itemCount: accepted.acceptedOrders.length,
                      itemBuilder: (context, index) {
                        print('the length is ');
                        print(accepted.acceptedOrders.length);
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        accepted.acceptedOrders[index].id
                                            .toString(),
                                        // 'Id ${acceptedOrders.[index].id}',
                                        style: FontStyles.regularStyle(
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color: const Color(0xff646974),
                                        ),
                                      ),
                                      Text(
                                        accepted.acceptedOrders[index].date
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
                                                  color:
                                                      const Color(0xffAAAEB7),
                                                ),
                                              ),
                                              Text(
                                                // 'Ул. Нукусская, 92, кв.21',
                                                accepted.acceptedOrders[index]
                                                    .address
                                                    .toString(),
                                                style: FontStyles.boldStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Montserrat',
                                                  color:
                                                      const Color(0xff232323),
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
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        accepted.acceptedOrders[index]
                                                .productTotalSum
                                                .toString() +
                                            '(${accepted.acceptedOrders[index].deliveryPrice}' +
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
                                        // acceptedOrdersController
                                        //             .allAcceptedOrdersList[index]
                                        //             .paymentType ==
                                        //         16
                                        'payCash'.tr,
                                        // : 'C Карты',
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      MyIcons(
                                        icon: IconButton(
                                          icon: const Icon(
                                            Icons.delivery_dining,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            AllServices.driverLeft(accepted
                                                .acceptedOrders[index].id!);
                                            // DriverLeft.finishOrder(
                                            //     acceptedOrdersController
                                            //         .allAcceptedOrdersList[index].id);
                                            //to testing
                                          },
                                        ),
                                      ),
                                      MyIcons(
                                        icon: IconButton(
                                          icon: const Icon(
                                            Icons.map,
                                            color: Colors.black,
                                          ),
                                          // onPressed: () => Get.to(() => MapLauncherDemo()),
                                          onPressed: () {
                                            print(accepted.acceptedOrders[index]
                                                .mapLocation
                                                .toString());

                                            var x = accepted
                                                .acceptedOrders[index]
                                                .mapLocation!
                                                .split(',');
                                            print('*******');
                                            print(x[0]);
                                            print('++++++');

                                            print(accepted.acceptedOrders[index]
                                                .deliveryType!.name
                                                .toString());
                                            print(x[1]);
                                            setState(() {
                                              destinationLatitude =
                                                  double.parse(x[0]);
                                              destinationLongitude =
                                                  double.parse(x[1]);
                                            });
                                            // print(MyPref.driverSecondToken);

                                            MapsSheet.show(
                                              context: context,
                                              onMapTap: (map) {
                                                map.showDirections(
                                                  destination: Coords(
                                                    destinationLatitude!,
                                                    destinationLongitude!,
                                                  ),
                                                  destinationTitle:
                                                      destinationTitle,
                                                  origin:
                                                      originLatitude == null ||
                                                              originLongitude ==
                                                                  null
                                                          ? null
                                                          : Coords(
                                                              originLatitude,
                                                              originLongitude),
                                                  originTitle: originTitle,
                                                  // waypoints: waypoints,
                                                  // directionsMode: directionsMode,
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      MyIcons(
                                        icon: IconButton(
                                            icon: const Icon(
                                              Icons.phone,
                                              color: Colors.green,
                                            ),
                                            onPressed: () => launch(
                                                'tel://${accepted.acceptedOrders[index].user!.phone}')
                                            // print(
                                            //     acceptedOrdersController
                                            //         .allAcceptedOrdersList[index]
                                            //         .user
                                            //         .phone),
                                            ),
                                      ),
                                      MyIcons(
                                        icon: IconButton(
                                          icon: const Icon(
                                            Icons.done,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        'areYouSureToFinishOrder'
                                                            .tr),
                                                    actions: [
                                                      FlatButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        child: Text(
                                                          'no'.tr,
                                                          style: TextStyle(
                                                            color: ColorPalatte
                                                                .strongRedColor,
                                                          ),
                                                        ),
                                                      ),
                                                      FlatButton(
                                                        onPressed: () async {
                                                          await AllServices
                                                              .finishOrder(accepted
                                                                  .acceptedOrders[
                                                                      index]
                                                                  .id!);
                                                          context
                                                              .read<
                                                                  AllAcceptedOrdersProvider>()
                                                              .fetchAllAcceptedOrders();
                                                          Get.back();
                                                          // await FinishOrder.finishOrder(
                                                          //     acceptedOrdersController
                                                          //         .allAcceptedOrdersList[
                                                          //             index]
                                                          //         .id);
                                                          // // Get.back();
                                                          // await acceptedOrdersController
                                                          //     .fetchAllAcceptedOrders();
                                                          // Get.back();
                                                        },
                                                        child: Text(
                                                          'yes'.tr,
                                                          style: TextStyle(
                                                            color: ColorPalatte
                                                                .strongRedColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                });
                                            // await FinishOrder.finishOrder(
                                            //     acceptedOrdersController
                                            //         .allAcceptedOrdersList[index]
                                            //         .id);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        );
                      }),
                )
              : Center(
                  child: Text('noAcceptedOrderYet'.tr),
                );
    }));
  }
}
