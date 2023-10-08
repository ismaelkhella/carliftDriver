import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/selectlanguage.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/sos.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/updatevehicle.dart';

import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translation/translation.dart';
import '../onTripPage/map_page.dart';
import '../vehicleInformations/upload_docs.dart';
import 'about.dart';
import 'bankdetails.dart';
import 'faq.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Stack(children: [
          Container(
            height: media.height * 1,
            width: media.width * 1,
            color: Colors.black,
            padding: EdgeInsets.only(
                left: media.width * 0.05, right: media.width * 0.05),
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).padding.top +
                        media.width * 0.05),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: media.width * 0.05),
                      width: media.width * 1,
                      alignment: Alignment.center,
                      child: Text(
                        languages[choosenLanguage]['text_drawer_account'],
                        style: GoogleFonts.roboto(
                            fontSize: media.width * twenty,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    Positioned(
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context, false);
                            },
                            child: Icon(Icons.arrow_back, color: Colors.white)))
                  ],
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Container(
                  padding: choosenLanguage == 'ar'
                      ? EdgeInsets.only(right: media.width * 0.05)
                      : EdgeInsets.only(left: media.width * 0.05),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: media.width * 0.025,
                                bottom: media.width * 0.025),
                            child: Row(
                              children: [
                                Icon(
                                  isDarkTheme
                                      ? Icons.brightness_4_outlined
                                      : Icons.brightness_3_rounded,
                                  size: media.width * 0.075,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: media.width * 0.025,
                                ),
                                SizedBox(
                                  width: media.width * 0.35,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ['text_select_theme'],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        fontSize: media.width * sixteen,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Switch(
                              activeColor: Color(0xfffdc600),
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey,
                              value: isDarkTheme,
                              onChanged: (toggle) async {
                                isDarkTheme = toggle;
                                await darktheme();

                                setState(() {
                                  if (toggle == true) {
                                    page = Colors.black;
                                    textColor = Colors.white;
                                    buttonColor = Colors.white;
                                    loaderColor = Colors.white;
                                    buttonText = Colors.black;
                                  } else {
                                    page = Colors.white;
                                    textColor = Colors.black;
                                    buttonColor = theme;
                                    loaderColor = theme;
                                    buttonText = const Color(0xffFFFFFF);
                                  }
                                  pref.setBool('isDarkTheme', isDarkTheme);
                                  valueNotifierHome.incrementNotifier();
                                });
                              }),
                        ],
                      ),

                      userDetails['owner_id'] == null &&
                              userDetails['role'] == 'driver'
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UpdateVehicle()));
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: media.width * 0.025,
                                    bottom: media.width * 0.025),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/updateVehicleInfo.png',
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
                                            ['text_updateVehicle'],
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * sixteen,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      InkWell(
                        onTap: () async {
                          var nav = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Docs(
                                        fromPage: '2',
                                      )));
                          if (nav) {
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: media.width * 0.025,
                              bottom: media.width * 0.025),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/manageDocuments.png',
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
                                      ['text_manage_docs'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * sixteen,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      //bank details
                      userDetails['owner_id'] == null
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BankDetails()));
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: media.width * 0.025,
                                    bottom: media.width * 0.025),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.account_balance,
                                      size: media.width * 0.075,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: media.width * 0.025,
                                    ),
                                    SizedBox(
                                      width: media.width * 0.55,
                                      child: Text(
                                        languages[choosenLanguage]
                                            ['text_updateBank'],
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * sixteen,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      InkWell(
                        onTap: () async {
                          var nav = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SelectLanguage()));
                          if (nav) {
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: media.width * 0.025,
                              bottom: media.width * 0.025),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/changeLanguage.png',
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
                                      ['text_change_language'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * sixteen,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      //faq
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Faq()));
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: media.width * 0.025,
                              bottom: media.width * 0.025),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/faq.png',
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
                                  languages[choosenLanguage]['text_faq'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * sixteen,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      //sos
                      userDetails['role'] != 'owner'
                          ? InkWell(
                              onTap: () async {
                                var nav = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Sos()));

                                if (nav) {
                                  setState(() {});
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: media.width * 0.025,
                                    bottom: media.width * 0.025),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/sos.png',
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
                                        languages[choosenLanguage]['text_sos'],
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * sixteen,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      //about
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const About()));
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: media.width * 0.025,
                              bottom: media.width * 0.025),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: media.width * 0.075,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: media.width * 0.025,
                              ),
                              SizedBox(
                                width: media.width * 0.55,
                                child: Text(
                                  languages[choosenLanguage]['text_about'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * sixteen,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      //logout
                      InkWell(
                        onTap: () {
                          setState(() {
                            logout = true;
                          });
                          valueNotifierHome.incrementNotifier();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: media.width * 0.025,
                              bottom: media.width * 0.025),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/logout.png',
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
                                  languages[choosenLanguage]['text_logout'],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * sixteen,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      const Divider(
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                        color: Colors.white,
                      ),
                      userDetails['owner_id'] == null
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  deleteAccount = true;
                                });
                                valueNotifierHome.incrementNotifier();
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: media.width * 0.025,
                                    bottom: media.width * 0.025),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete_forever,
                                      size: media.width * 0.075,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: media.width * 0.025,
                                    ),
                                    SizedBox(
                                      width: media.width * 0.55,
                                      child: Text(
                                        languages[choosenLanguage]
                                            ['text_delete_account'],
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * sixteen,
                                            color: Colors.red),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
