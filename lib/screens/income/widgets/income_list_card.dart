import 'package:flutter/material.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/models/income_model.dart';
import 'package:get/get.dart';

class IncomeListCard extends StatelessWidget {
  final Data? myData;
  const IncomeListCard({Key? key, this.myData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: myData?.orders?.length ?? 0,
      itemBuilder: (context, index) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 18, left: 17, right: 17, bottom: 18),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'order'.tr,
                    style: FontStyles.boldStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: const Color(0xff646974),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Id ' + myData!.orders![index].id.toString(),
                    style: FontStyles.boldStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: Color(0xff323637),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
                color: Color(0xffEAECF1),
              ),
              Row(
                children: [
                  Text(
                    'deliveryPrice'.tr,
                    style: FontStyles.boldStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: Color(0xff646974),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    myData!.orders![index].productTotalSum.toString(),
                    // myIncomeController.myIncomeDayList[0]
                    //     .orders[index].productTotalSum
                    //     .toString(),
                    style: FontStyles.boldStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      color: const Color(0xff323637),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => index.remainder(3) == 1
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(myData!.orders![index].date.toString()),
                  const SizedBox(height: 12),
                ],
              ),
            )
          : const SizedBox(height: 12),
    );
  }
}
