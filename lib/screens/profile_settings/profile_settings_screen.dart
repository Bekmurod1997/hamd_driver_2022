import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/masks/mask_format.dart';
import 'package:hamd_driver/providers/plastic_card_provider.dart';
import 'package:hamd_driver/providers/profile_fetch_provider.dart';
import 'package:hamd_driver/providers/profile_images_provider.dart';
import 'package:hamd_driver/screens/profile_settings/widgets/name_change.dart';
import 'package:hamd_driver/screens/profile_settings/widgets/payment_card.dart';
import 'package:hamd_driver/screens/profile_settings/widgets/profile_appbar.dart';
import 'package:hamd_driver/screens/profile_settings/widgets/send_button.dart';
import 'package:hamd_driver/screens/profile_settings/widgets/user_phone.dart';
import 'package:hamd_driver/services/all_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileSettingsScreen extends StatefulWidget {
  final String? userName;
  final String? phoneNumber;
  const ProfileSettingsScreen({Key? key, this.userName, this.phoneNumber})
      : super(key: key);

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController humoCardController = TextEditingController();
  TextEditingController uzCardController = TextEditingController();
  TextEditingController dateHumoController = TextEditingController();
  TextEditingController dateUzCardController = TextEditingController();
  TextEditingController phoneHumoController = TextEditingController();
  TextEditingController phoneUzCardController = TextEditingController();
  File? _userImage;
  File? drivingLicence;
  File? _drivingPassport;
  int? selectedRadio;
  final uzCard = 1;
  final humoCard = 2;
  var _imageAvatar;
  var imagePicker;
  Map<int, Map<String, String>> chooseCardModalData = {
    0: {
      'name': 'Uzcard',
      'image': 'assets/icons/uzcard.svg',
    },
    1: {
      'name': 'Humo',
      'image': 'assets/images/humo.png',
    },
  };
  final ImagePicker _picker = ImagePicker();

  void selectAvatar(BuildContext context) async {
    final XFile? imageAvatar =
        await _picker.pickImage(source: ImageSource.gallery);

    if (imageAvatar == null) return;
    setState(() {
      _imageAvatar = imageAvatar.path;
      _userImage = File(imageAvatar.path);
      print('photo link $_imageAvatar');
      print('file photo link $_userImage');
    });
    context
        .read<ProfileFetchProvider>()
        .imageAvatarChanger(context, imageAvatar.path);
  }

  void selectDrivingLicence(BuildContext context) async {
    final XFile? drivingLicencePhoto =
        await _picker.pickImage(source: ImageSource.gallery);

    if (drivingLicencePhoto == null) return;
    setState(() {
      // _imageAvatar = imageAvatar.path;
      drivingLicence = File(drivingLicencePhoto.path);
      print('photo link $drivingLicence');
      print('file photo link $drivingLicence');
    });
    context
        .read<ProfileFetchProvider>()
        .drivingLicencePhotoChanger(context, drivingLicencePhoto.path);
  }

  void selectdrivingPassport(BuildContext context) async {
    final XFile? drivingPassport =
        await _picker.pickImage(source: ImageSource.gallery);

    if (drivingPassport == null) return;
    setState(() {
      // _imageAvatar = imageAvatar.path;
      _drivingPassport = File(drivingPassport.path);
      print('photo link $drivingPassport');
      print('file photo link $drivingPassport');
    });
    context
        .read<ProfileFetchProvider>()
        .drivingLicencePhotoChanger(context, drivingPassport.path);
  }

  @override
  void initState() {
    nameController..text = widget.userName.toString();
    context.read<ProfileFetchProvider>().fetchUserInfo();
    context.read<PlasticCardProvider>().fetchPlasticCard();
    // nameController
    //   ..text = Provider.of<ProfileFetchProvider>(context).userInfo?.name ??
    //       'nothing';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorPalatte.mainPageColor,
      appBar: buildProfleSettingsAppBar(context),
      body: SingleChildScrollView(
          child: Consumer2<ProfileFetchProvider, PlasticCardProvider>(
        builder: (context, userInfo, plasticCard, child) {
          return userInfo.isLoading || plasticCard.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: ColorPalatte.strongRedColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 33, bottom: 45),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    selectAvatar(context);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 95,
                                        width: 95,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: _userImage == null
                                            ? CircleAvatar(
                                                radius: 60,
                                                backgroundImage: NetworkImage(
                                                    'http://hamd.loko.uz/' +
                                                        userInfo
                                                            .userInfo!.photo!),
                                              )
                                            : CircleAvatar(
                                                radius: 60,
                                                backgroundImage:
                                                    FileImage(_userImage!),
                                              ),
                                      ),
                                      Positioned(
                                        right: 25,
                                        top: 50,
                                        bottom: 0,
                                        child: Container(
                                          width: 36,
                                          height: 36,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Color(0xff575F6B),
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              UserNameChange(nameController: nameController)
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 35.0, bottom: 10.0),
                            child: Text(
                              'phoneNumber'.tr,
                              style: FontStyles.regularStyle(
                                fontSize: 15,
                                fontFamily: 'Ubuntu',
                                color: Color(0xff232323),
                              ),
                            ),
                          ),
                          UserPhoneNumber(
                              phoneNumber: userInfo.userInfo!.phone!),
                          const SizedBox(height: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'driverLicense'.tr,
                                style: FontStyles.regularStyle(
                                  fontSize: 13,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xffAAAEB7),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Container(
                                    child: drivingLicence == null
                                        ? GestureDetector(
                                            //Uploading driving licenc
                                            onTap: () {
                                              selectDrivingLicence(context);
                                            },
                                            child: userInfo.userInfo
                                                        ?.driverLicensePhoto ==
                                                    null
                                                ? const SizedBox(
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 35,
                                                    ),
                                                  )
                                                : Stack(
                                                    children: [
                                                      Container(
                                                        height: 140,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                'http://hamd.loko.uz/' +
                                                                    userInfo
                                                                        .userInfo!
                                                                        .driverLicensePhoto!),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        right: 0,
                                                        top: 0,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            print('ss');
                                                            selectDrivingLicence(
                                                                context);
                                                          },
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: ColorPalatte
                                                                .strongRedColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          )
                                        : Stack(
                                            children: [
                                              Container(
                                                height: 140,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                      drivingLicence!,
                                                      scale: 1.0,
                                                    ),
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    print('ss');
                                                    selectDrivingLicence(
                                                        context);
                                                  },
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: ColorPalatte
                                                        .strongRedColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'passport'.tr,
                                style: FontStyles.regularStyle(
                                  fontSize: 13,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xffAAAEB7),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Container(
                                    child: _drivingPassport == null
                                        ? GestureDetector(
                                            //Another mehod
                                            onTap: () {
                                              selectdrivingPassport(context);
                                            },
                                            child: userInfo.userInfo!
                                                        .passportPhoto ==
                                                    null
                                                ? const SizedBox(
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 35,
                                                    ),
                                                  )
                                                : Stack(
                                                    children: [
                                                      Container(
                                                        height: 140,
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                              'http://hamd.loko.uz/' +
                                                                  userInfo
                                                                      .userInfo!
                                                                      .passportPhoto!,
                                                            ),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        right: 0,
                                                        top: 0,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            print('ss');
                                                            selectdrivingPassport(
                                                                context);
                                                          },
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: ColorPalatte
                                                                .strongRedColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          )
                                        : Stack(
                                            // overflow: Overflow.visible,
                                            children: [
                                              Container(
                                                height: 140,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                      _drivingPassport!,
                                                      scale: 1.0,
                                                    ),
                                                    fit: BoxFit.scaleDown,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    print('ss');
                                                    selectdrivingPassport(
                                                        context);
                                                  },
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: ColorPalatte
                                                        .strongRedColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                              //starts plastic card
                              plasticCard.myPlastic.isEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        Get.bottomSheet(
                                          StatefulBuilder(
                                            builder: (context, state) => Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                    left: 20,
                                                    right: 20,
                                                  ),
                                                  width: double.infinity,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20.0),
                                                      topRight:
                                                          Radius.circular(20.0),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'addNewCard'.tr,
                                                        style: FontStyles
                                                            .mediumStyle(
                                                          fontSize: 20,
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: const Color(
                                                              0xff0E0E0E),
                                                        ),
                                                      ),
                                                      Column(
                                                        children: List.generate(
                                                          chooseCardModalData
                                                              .length,
                                                          (index) => Row(
                                                            children: [
                                                              Container(
                                                                child: index ==
                                                                        0
                                                                    ? SvgPicture
                                                                        .asset(
                                                                        chooseCardModalData[index]![
                                                                            'image']!,
                                                                        width:
                                                                            40,
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        chooseCardModalData[index]![
                                                                            'image']!,
                                                                        width:
                                                                            40,
                                                                      ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    RadioListTile(
                                                                  activeColor:
                                                                      const Color(
                                                                          0xffFFBC41),
                                                                  controlAffinity:
                                                                      ListTileControlAffinity
                                                                          .trailing,
                                                                  value: index ==
                                                                          0
                                                                      ? uzCard
                                                                      : humoCard,
                                                                  groupValue:
                                                                      selectedRadio,
                                                                  onChanged:
                                                                      (val) {
                                                                    setState(
                                                                        () {
                                                                      selectedRadio =
                                                                          val as int?;
                                                                    });
                                                                    Get.back();
                                                                    buildCardChange();
                                                                  },
                                                                  title: Text(
                                                                    chooseCardModalData[
                                                                            index]![
                                                                        'name']!,
                                                                    style: FontStyles
                                                                        .mediumStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      color: const Color(
                                                                          0xff0E0E0E),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 40),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  'addCard'.tr,
                                                  style:
                                                      FontStyles.regularStyle(
                                                    fontSize: 17,
                                                    fontFamily: 'Montserrat',
                                                    color:
                                                        const Color(0xff232323),
                                                  ),
                                                ),
                                                const SizedBox(height: 20.0),
                                                const Icon(
                                                  Icons.add_circle_outline,
                                                  size: 50,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  // : Column(
                                  //     children: [
                                  //       Text(plasticCard
                                  //           .myPlastic.first.cardNumber!.length
                                  //           .toString()),
                                  // ],
                                  // )
                                  : PlasticCard(
                                      plasticId: plasticCard.myPlastic.first.id
                                          .toString(),
                                      cardType: plasticCard
                                          .myPlastic.first.paymentType!.name!,
                                      cardNumber: plasticCard
                                          .myPlastic.first.cardNumber,
                                      dateExpire: plasticCard
                                          .myPlastic.first.cardExpire,
                                      phoneNumber: plasticCard
                                          .myPlastic.first.cardPhoneNumber,
                                      name: userInfo.userInfo?.name ??
                                          'Enter Name',
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // plasticCard.myPlastic.isEmpty
                    //     ? GestureDetector()
                    //     : const Text('some card Number'),
                    SendButton(
                      userName: userInfo.userName ?? 'Driver',
                      drivingLicence: drivingLicence,
                      userImage: _userImage,
                      drivingPassport: _drivingPassport,
                    ),
                  ],
                );
        },
      )),
    );
  }

  buildCardChange() {
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, state) => Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: StatefulBuilder(builder: (context, StateSetter state) {
                return Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'addCard'.tr,
                          style: FontStyles.regularStyle(
                            fontSize: 17,
                            fontFamily: 'Montserrat',
                            color: const Color(0xff232323),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 17),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'cardNumber'.tr,
                                    style: FontStyles.regularStyle(
                                      fontSize: 13,
                                      fontFamily: 'Montserrat',
                                      color: const Color(0xff646974),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          width: 1,
                                          color: const Color(0xffE1E1E1),
                                        )),
                                    child: TextFormField(
                                      controller: selectedRadio == uzCard
                                          ? uzCardController
                                          : humoCardController,
                                      onChanged: (text) {
                                        print(text);
                                      },
                                      inputFormatters: [
                                        selectedRadio == uzCard
                                            ? InputMask.maskUzCard
                                            : InputMask.maskHumo
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            left: 8.0, bottom: 2, top: 2),
                                        hintText: selectedRadio == uzCard
                                            ? '8600'
                                            : '9860',
                                        hintStyle: FontStyles.regularStyle(
                                            fontSize: 12,
                                            fontFamily: 'Ubuntu',
                                            color: const Color(0xff9E9E9E)),
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'fieldCannotBeEmpty'.tr;
                                        } else if (value.length < 19) {
                                          return 'fieldCannotBeLess16'.tr;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'yearMonth'.tr,
                                              style: FontStyles.regularStyle(
                                                fontSize: 13,
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xff646974),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffFFFFFF),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Color(0xffE1E1E1),
                                                  )),
                                              child: TextFormField(
                                                controller:
                                                    selectedRadio == uzCard
                                                        ? dateUzCardController
                                                        : dateHumoController,
                                                onChanged: (text) {
                                                  print(text);
                                                },
                                                inputFormatters: [
                                                  InputMask.maskDate
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          bottom: 2,
                                                          top: 2),
                                                  hintText: '08/24',
                                                  hintStyle:
                                                      FontStyles.regularStyle(
                                                          fontSize: 12,
                                                          fontFamily: 'Ubuntu',
                                                          color: const Color(
                                                              0xff9E9E9E)),
                                                  border: InputBorder.none,
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.0,
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'fieldCannotBeEmpty'
                                                        .tr;
                                                  } else if (value.length < 5) {
                                                    return 'fieldCannotBeLess4'
                                                        .tr;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          // mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'telNumber'.tr,
                                              style: FontStyles.regularStyle(
                                                fontSize: 13,
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xff646974),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffFFFFFF),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                    width: 1,
                                                    color:
                                                        const Color(0xffE1E1E1),
                                                  )),
                                              child: TextFormField(
                                                controller:
                                                    selectedRadio == uzCard
                                                        ? phoneUzCardController
                                                        : phoneHumoController,
                                                onChanged: (text) {
                                                  print(text);
                                                },
                                                inputFormatters: [
                                                  InputMask.maskPhoneNumber
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 8.0,
                                                          bottom: 2,
                                                          top: 2),
                                                  hintText: '+998',
                                                  hintStyle: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.0,
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'fieldCannotBeEmpty'
                                                        .tr
                                                        .tr;
                                                  } else if (value.length <
                                                      17) {
                                                    return 'fieldCannotBeLess'
                                                        .tr;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 54,
                          width: double.infinity,
                          child: RaisedButton(
                            elevation: 0,
                            color: ColorPalatte.strongRedColor,
                            onPressed: () async {
                              print('pressing add');
                              print(uzCardController.text);
                              print(humoCardController.text);
                              print(phoneUzCardController.text);
                              print(phoneHumoController.text);
                              print(dateUzCardController.text);
                              print(dateHumoController.text);
                              if (_formKey.currentState!.validate()) {
                                AllServices.addPlasticCard(
                                    context: context,
                                    typeId: selectedRadio == uzCard ? 14 : 15,
                                    cardNumber: selectedRadio == uzCard
                                        ? uzCardController.text
                                        : humoCardController.text,
                                    cardPhoneNumber: selectedRadio == uzCard
                                        ? phoneUzCardController.text
                                            .replaceAll(' ', '')
                                            .replaceAll('+', '')
                                        : phoneHumoController.text
                                            .replaceAll(' ', '')
                                            .replaceAll('+', ''),
                                    cardExpire: selectedRadio == uzCard
                                        ? dateUzCardController.text
                                        : dateHumoController.text);
                              }
                              // if (_formKey.currentState.validate()) {
                              //   await AddPlasticCardType.addPlasticCardType(
                              //     typeId: selectedRadio == uzCard ? 14 : 15,
                              //     cardNumber: selectedRadio == uzCard
                              //         ? uzCardController.text
                              //         : humoCardController.text,
                              //     cardPhoneNumber: selectedRadio == uzCard
                              //         ? phoneUzCardController.text
                              //         : phoneHumoController.text,
                              //     cardExpire: selectedRadio == uzCard
                              //         ? dateUzCardController.text
                              //         : dateHumoController.text,
                              //   );
                              //   await plasticCardUzcardController
                              //       .fetchPlasticCardType(14);
                              //   await plasticCardHumoController
                              //       .fetchPlasticCardHumo(15);
                              // } else {
                              //   print('no');
                              // }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'add'.tr,
                              style: FontStyles.boldStyle(
                                  fontSize: 16,
                                  fontFamily: 'Ubuntu',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
