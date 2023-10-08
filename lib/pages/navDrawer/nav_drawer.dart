import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagxisuperdriver/functions/functions.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/about.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/bankdetails.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/driverdetails.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/driverearnings.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/editprofile.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/faq.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/history.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/makecomplaint.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/myroutebookings.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/notification.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/referral.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/selectlanguage.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/sos.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/updatevehicle.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/walletpage.dart';
import 'package:tagxisuperdriver/pages/loadingPage/loading.dart';
import 'package:tagxisuperdriver/pages/login/signupmethod.dart';
import 'package:tagxisuperdriver/pages/onTripPage/map_page.dart';
import 'package:tagxisuperdriver/pages/vehicleInformations/upload_docs.dart';
import 'package:tagxisuperdriver/styles/styles.dart';
import 'package:tagxisuperdriver/translation/translation.dart';
import 'package:tagxisuperdriver/widgets/widgets.dart';

import '../NavigatorPages/account_setting.dart';
import '../NavigatorPages/fleetdetails.dart';
import '../NavigatorPages/managevehicles.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  bool _isLoading = false;
  String _error = '';
  bool showAcc = false;
  bool showSet = false;

  navigateLogout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignupMethod()));
  }
  OverlayEntry? entry;
  Offset offset=Offset(20, 40);
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: valueNotifierHome.value,
        builder: (context, value, child) {
          return Stack(
            children: [
              SizedBox(
                width: media.width * 0.8,
                child: Directionality(
                  textDirection: (languageDirection == 'rtl')
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: Drawer(
                      backgroundColor: Colors.black,
                      child: Stack(children: [
                        SizedBox(
                          width: media.width * 0.7,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: media.width * 0.05 +
                                      MediaQuery.of(context).padding.top,
                                ),
                                SizedBox(
                                  width: media.width * 0.7,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: media.width * 0.2,
                                        width: media.width * 0.2,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey,
                                            image: DecorationImage(
                                                image: NetworkImage(userDetails[
                                                        'profile_picture']
                                                    .toString()),
                                                fit: BoxFit.cover)),
                                      ),
                                      SizedBox(
                                        width: media.width * 0.025,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: media.width * 0.45,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: media.width * 0.3,
                                                  child: Text(
                                                    userDetails['name'],
                                                    style: GoogleFonts.roboto(
                                                        fontSize: media.width *
                                                            eighteen,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                //edit profile
                                                InkWell(
                                                  onTap: () async {
                                                    var val = await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const EditProfile()));
                                                    if (val != null) {
                                                      if (val) {
                                                        setState(() {});
                                                      }
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.edit,
                                                    size:
                                                        media.width * eighteen,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: media.width * 0.01,
                                          ),
                                          SizedBox(
                                            width: media.width * 0.45,
                                            child: Text(
                                              userDetails['mobile'],
                                              style: GoogleFonts.roboto(
                                                  fontSize:
                                                      media.width * fourteen,
                                                  color: Colors.white),
                                              maxLines: 1,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                    endIndent: 15,
                                    indent: 15),
                                Container(
                                  padding:
                                      EdgeInsets.only(top: media.width * 0.02),
                                  width: media.width * 0.7,
                                  child: Column(
                                    children: [
                                      //my route bookings
                                      userDetails['role'] != 'owner' &&
                                              userDetails[
                                                      'enable_my_route_booking_feature'] ==
                                                  "1" &&
                                              userDetails['transport_type'] !=
                                                  'delivery'
                                          ? InkWell(
                                              onTap: () async {
                                                var nav = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MyRouteBooking()));
                                                if (nav != null) {
                                                  if (nav) {
                                                    setState(() {});
                                                  }
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        media.width * 0.025),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                            'assets/images/myroute.png',
                                                            fit: BoxFit.contain,
                                                            width: media.width *
                                                                0.075,
                                                            color:
                                                                Colors.white),
                                                        SizedBox(
                                                          width: media.width *
                                                              0.025,
                                                        ),
                                                        SizedBox(
                                                          width: media.width *
                                                              0.45,
                                                          child: Text(
                                                            languages[
                                                                    choosenLanguage]
                                                                [
                                                                'text_my_route'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.roboto(
                                                                fontSize: media
                                                                        .width *
                                                                    sixteen,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),

                                                  // SizedBox(width: media.width*0.05,),
                                                  if (userDetails[
                                                          'my_route_address'] !=
                                                      null)
                                                    InkWell(

                                                      onTap: () async {
                                                        setState(() {
                                                          _isLoading = true;
                                                        });
                                                        var dist = calculateDistance(
                                                            center.latitude,
                                                            center.longitude,
                                                            double.parse(userDetails[
                                                                    'my_route_lat']
                                                                .toString()),
                                                            double.parse(userDetails[
                                                                    'my_route_lng']
                                                                .toString()));

                                                        if (dist > 5000.0 ||
                                                            userDetails[
                                                                    'enable_my_route_booking'] ==
                                                                "1") {
                                                          var val =
                                                              await enableMyRouteBookings(
                                                                  center
                                                                      .latitude,
                                                                  center
                                                                      .longitude);
                                                          if (val == 'logout') {
                                                            navigateLogout();
                                                          } else if (val !=
                                                              'success') {
                                                            setState(() {
                                                              _error = val;
                                                            });
                                                          }
                                                        } else {
                                                          _error = languages[
                                                                  choosenLanguage]
                                                              [
                                                              'text_myroute_warning'];
                                                        }

                                                        setState(() {
                                                          _isLoading = false;
                                                        });
                                                      },
                                                      child: Container(

                                                        padding:
                                                            EdgeInsets.only(
                                                                left: media
                                                                        .width *
                                                                    0.005,
                                                                right: media
                                                                        .width *
                                                                    0.005),
                                                        height:
                                                            media.width * 0.05,
                                                        width:
                                                            media.width * 0.1,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(media
                                                                          .width *
                                                                      0.025),
                                                          color: (userDetails[
                                                                      'enable_my_route_booking'] ==
                                                                  1)
                                                              ? Colors.green
                                                                  .withOpacity(
                                                                      0.4)
                                                              : Colors.grey
                                                                  .withOpacity(
                                                                      0.6),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: (userDetails[
                                                                      'enable_my_route_booking'] ==
                                                                  1)
                                                              ? MainAxisAlignment
                                                                  .end
                                                              : MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height:
                                                                  media.width *
                                                                      0.045,
                                                              width:
                                                                  media.width *
                                                                      0.045,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: (userDetails[
                                                                            'enable_my_route_booking'] ==
                                                                        1)
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .grey,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            )
                                          : Container(),

                                      if (userDetails['role'] == 'driver')
                                        //notification
                                        ValueListenableBuilder(
                                            valueListenable:
                                                valueNotifierNotification.value,
                                            builder: (context, value, child) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const NotificationPage()));
                                                  setState(() {
                                                    userDetails[
                                                        'notifications_count'] = 0;
                                                  });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(
                                                          media.width * 0.025),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            'assets/images/notification.png',
                                                            fit: BoxFit.contain,
                                                            width: media.width *
                                                                0.075,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: media.width *
                                                                0.025,
                                                          ),
                                                          SizedBox(
                                                            width: media.width *
                                                                0.49,
                                                            child: Text(
                                                              languages[choosenLanguage]
                                                                      [
                                                                      'text_notification']
                                                                  .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: media
                                                                          .width *
                                                                      sixteen,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    (userDetails[
                                                                'notifications_count'] ==
                                                            0)
                                                        ? Container()
                                                        : Container(
                                                            height: 20,
                                                            width: 20,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  buttonColor,
                                                            ),
                                                            child: Text(
                                                              userDetails[
                                                                      'notifications_count']
                                                                  .toString(),
                                                              style: GoogleFonts.roboto(
                                                                  fontSize: media
                                                                          .width *
                                                                      fourteen,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )
                                                  ],
                                                ),
                                              );
                                            }),
                                      //history
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const History()));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              media.width * 0.025),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/history.png',
                                                fit: BoxFit.contain,
                                                width: media.width * 0.075,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: media.width * 0.025,
                                              ),
                                              SizedBox(
                                                width: media.width * 0.55,
                                                child: Text(
                                                  languages[choosenLanguage]
                                                      ['text_enable_history'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          media.width * sixteen,
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),

                                      //wallet
                                      userDetails['owner_id'] == null
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const WalletPage()));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                    media.width * 0.025),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/walletImage.png',
                                                      fit: BoxFit.contain,
                                                      width:
                                                          media.width * 0.075,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          media.width * 0.025,
                                                    ),
                                                    SizedBox(
                                                      width: media.width * 0.55,
                                                      child: Text(
                                                        languages[
                                                                choosenLanguage]
                                                            [
                                                            'text_enable_wallet'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: media
                                                                        .width *
                                                                    sixteen,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      //earnings
                                      userDetails['owner_id'] == null
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const DriverEarnings()));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                    media.width * 0.025),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/Earnings.png',
                                                      fit: BoxFit.contain,
                                                      width:
                                                          media.width * 0.075,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          media.width * 0.025,
                                                    ),
                                                    SizedBox(
                                                      width: media.width * 0.55,
                                                      child: Text(
                                                        languages[
                                                                choosenLanguage]
                                                            ['text_earnings'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: media
                                                                        .width *
                                                                    sixteen,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),

                                      //referral
                                      userDetails['owner_id'] == null &&
                                              userDetails['role'] == 'driver'
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ReferralPage()));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                    media.width * 0.025),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/referral.png',
                                                      fit: BoxFit.contain,
                                                      width:
                                                          media.width * 0.075,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          media.width * 0.025,
                                                    ),
                                                    SizedBox(
                                                      width: media.width * 0.55,
                                                      child: Text(
                                                        languages[
                                                                choosenLanguage]
                                                            [
                                                            'text_enable_referal'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: media
                                                                        .width *
                                                                    sixteen,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),

                                      //manage vehicle

                                      userDetails['role'] == 'owner'
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ManageVehicles()));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                    media.width * 0.025),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/updateVehicleInfo.png',
                                                      fit: BoxFit.contain,
                                                      width:
                                                          media.width * 0.075,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          media.width * 0.025,
                                                    ),
                                                    SizedBox(
                                                      width: media.width * 0.55,
                                                      child: Text(
                                                        languages[
                                                                choosenLanguage]
                                                            [
                                                            'text_manage_vehicle'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: media
                                                                        .width *
                                                                    sixteen,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),

                                      //manage Driver

                                      userDetails['role'] == 'owner'
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const DriverList()));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                    media.width * 0.025),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/managedriver.png',
                                                      fit: BoxFit.contain,
                                                      width:
                                                          media.width * 0.075,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          media.width * 0.025,
                                                    ),
                                                    SizedBox(
                                                      width: media.width * 0.55,
                                                      child: Text(
                                                        languages[
                                                                choosenLanguage]
                                                            [
                                                            'text_manage_drivers'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: media
                                                                        .width *
                                                                    sixteen,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),

                                      //fleet details
                                      userDetails['owner_id'] != null &&
                                              userDetails['role'] == 'driver'
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const FleetDetails()));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                    media.width * 0.025),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/updateVehicleInfo.png',
                                                      fit: BoxFit.contain,
                                                      width:
                                                          media.width * 0.075,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          media.width * 0.025,
                                                    ),
                                                    SizedBox(
                                                      width: media.width * 0.55,
                                                      child: Text(
                                                        languages[
                                                                choosenLanguage]
                                                            [
                                                            'text_fleet_details'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: media
                                                                        .width *
                                                                    sixteen,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),

                                      //documents

                                      //make complaints
                                      InkWell(
                                        onTap: () async {
                                          // print(bearerToken[0].token);
                                          var nav = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MakeComplaint(
                                                        fromPage: 0,
                                                      )));
                                          if (nav) {
                                            setState(() {});
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              media.width * 0.025),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/makecomplaint.png',
                                                fit: BoxFit.contain,
                                                width: media.width * 0.075,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: media.width * 0.025,
                                              ),
                                              SizedBox(
                                                width: media.width * 0.55,
                                                child: Text(
                                                  languages[choosenLanguage]
                                                      ['text_make_complaints'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          media.width * sixteen,
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          var nav = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AccountSetting()));
                                          // if (nav) {
                                          //   setState(() {});
                                          // }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              media.width * 0.025),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.settings,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: media.width * 0.025,
                                              ),
                                              SizedBox(
                                                width: media.width * 0.55,
                                                child: Text(
                                                  languages[choosenLanguage]
                                                      ['text_drawer_account'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          media.width * sixteen,
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Divider(
                            //   thickness: 1,
                            //   color: Colors.white,
                            //   indent: 10,
                            // ),
                            Container(
                              // color: Colors.white,
                              width: media.width * 0.40,
                                height: media.width * 0.35,
                                child:
                                Image.asset('assets/images/logoCar.jpeg',fit: BoxFit.fill,))
                          ],
                        ),
                      ])),
                ),
              ),
              (_error != '')
                  ? Positioned(
                      top: 0,
                      child: Container(
                        height: media.height * 1,
                        width: media.width * 1,
                        color: Colors.transparent.withOpacity(0.6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(media.width * 0.05),
                              width: media.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: page),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: media.width * 0.8,
                                    child: Text(
                                      _error.toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          fontSize: media.width * sixteen,
                                          color:Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.05,
                                  ),
                                  Button(
                                    color: Colors.black,
                                      onTap: () async {
                                        setState(() {
                                          _error = '';
                                        });
                                      },
                                      text: languages[choosenLanguage]
                                          ['text_ok'])
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                  : Container(),
              if (_isLoading == true) const Positioned(child: Loading())
            ],
          );
        });
  }
  void showoverlay() {
    entry = OverlayEntry(
        builder: (context) => Positioned(
            left: offset.dx,
            top: offset.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  offset += details.delta;
                  entry!.markNeedsBuild();
                });
              },
              child: ElevatedButton.icon(
                  icon: Icon(Icons.stop_circle_rounded),
                  label: Text('Record'),
                  onPressed: () {}),
            )));
    final overlay = Overlay.of(context);
    overlay.insert(entry!);
  }

}
