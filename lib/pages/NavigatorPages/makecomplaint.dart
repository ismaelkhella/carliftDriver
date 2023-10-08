import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagxisuperdriver/functions/functions.dart';
import 'package:tagxisuperdriver/pages/loadingPage/loading.dart';
import 'package:tagxisuperdriver/pages/login/signupmethod.dart';
import 'package:tagxisuperdriver/pages/noInternet/nointernet.dart';
import 'package:tagxisuperdriver/styles/styles.dart';
import 'package:tagxisuperdriver/translation/translation.dart';
import 'package:tagxisuperdriver/widgets/widgets.dart';

class MakeComplaint extends StatefulWidget {
  final int fromPage;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  MakeComplaint({required this.fromPage});

  @override
  State<MakeComplaint> createState() => _MakeComplaintState();
}

int complaintType = 0;
String complaintDesc = '';

class _MakeComplaintState extends State<MakeComplaint> {
  bool _isLoading = true;
  bool _showOptions = false;
  TextEditingController complaintText = TextEditingController();
  bool _success = false;
  bool userSelect=false;
  bool vechSelect=false;
  bool otherSelect=false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  navigateLogout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignupMethod()));
  }

//get complaint data
  getData() async {
    if (mounted) {
      setState(() {
        complaintType = 0;
        complaintDesc = '';
        generalComplaintList = [];
      });
    }
    dynamic val;
    if (widget.fromPage == 1) {
      val = await getGeneralComplaint("request");
    } else {
      val = await getGeneralComplaint("general");
    }
    if (val == 'logout') {
      navigateLogout();
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
        if (generalComplaintList.isNotEmpty) {
          complaintType = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return true;
      },
      child: Material(
        child: Directionality(
          textDirection: (languageDirection == 'rtl')
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Stack(
            children: [
              SingleChildScrollView(

                child: Container(
                  height: media.height * 1,
                  width: media.width * 1,
                  color: page,
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
                              languages[choosenLanguage]['text_make_complaints'],
                              style: GoogleFonts.roboto(
                                  fontSize: media.width * twenty,
                                  fontWeight: FontWeight.w600,
                                  color: buttonColor),
                            ),
                          ),
                          Positioned(
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context, false);
                                  },
                                  child:
                                      Icon(Icons.arrow_back, color: buttonColor)))
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    userSelect=!userSelect;
                                    if(userSelect==true){
                                      vechSelect=false;
                                      otherSelect=false;
                                    }
                                  });
                                },
                                icon: userSelect?Icon(Icons.check_circle):Icon(Icons.circle_outlined),
                              ),
                              Text(languages[choosenLanguage]['text_complaints_catigory_report_client'] ,style: TextStyle(color: buttonColor,fontSize: 17)),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  print(generalComplaintList);
                                  setState(() {
                                    vechSelect=!vechSelect;
                                    if(vechSelect==true){
                                      userSelect=false;
                                      otherSelect=false;
                                    }
                                  });
                                },
                                icon: vechSelect?Icon(Icons.check_circle):Icon(Icons.circle_outlined),
                              ),
                              Text( languages[choosenLanguage]['text_complaints_catigory_suspicious'],style: TextStyle(color: buttonColor,fontSize: 17)),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    otherSelect=!otherSelect;
                                    if(otherSelect==true){
                                      userSelect=false;
                                      vechSelect=false;
                                    }
                                  });
                                },
                                icon: otherSelect?Icon(Icons.check_circle):Icon(Icons.circle_outlined),
                              ),
                              Text(languages[choosenLanguage]['text_complaints_catigory_lost_found'] ,style: TextStyle(color: buttonColor,fontSize: 17)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      (generalComplaintList.isNotEmpty&&(vechSelect||userSelect||otherSelect))
                          ? Expanded(
                              child: Column(children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_showOptions == false) {
                                      _showOptions = true;
                                    } else {
                                      _showOptions = false;
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: media.width * 0.05,
                                      right: media.width * 0.05),
                                  height: media.width * 0.12,
                                  width: media.width * 0.8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: borderLines, width: 1.2)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        generalComplaintList[complaintType]
                                            ['title'],
                                        style: TextStyle(color: buttonColor),
                                      ),
                                      RotatedBox(
                                        quarterTurns:
                                            (_showOptions == true) ? 2 : 0,
                                        child: Container(
                                          height: media.width * 0.08,
                                          width: media.width * 0.08,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/chevron-down.png'),
                                                  fit: BoxFit.contain)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: media.width * 0.08,
                              ),
                              Container(
                                padding: EdgeInsets.all(media.width * 0.025),
                                width: media.width * 0.8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: borderLines, width: 1.2)),
                                child: TextField(
                                  controller: complaintText,
                                  minLines: 5,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: GoogleFonts.roboto(
                                        color: buttonColor.withOpacity(0.6),
                                        fontSize: media.width * fourteen),
                                    hintText: languages[choosenLanguage]
                                            ['text_complaint_2'] +
                                        ' (' +
                                        languages[choosenLanguage]
                                            ['text_complaint_3'] +
                                        ')',
                                  ),
                                  style: GoogleFonts.roboto(
                                    color: buttonColor,
                                  ),
                                ),
                              ),
                            ]))
                          : Container(),
                      (generalComplaintList.isNotEmpty&&(vechSelect||userSelect||otherSelect))
                          ? Container(

                              padding: EdgeInsets.all(media.width * 0.05),
                              child: Button(
                                color: Colors.black,
                                  onTap: () async {
                                    if (complaintText.text.length >= 10) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      complaintDesc = complaintText.text;
                                      dynamic result;
                                      if (widget.fromPage == 1) {
                                        result = await makeRequestComplaint();
                                      } else {
                                        result = await makeGeneralComplaint();
                                      }
                                      if (result == 'logout') {
                                        navigateLogout();
                                      }
                                      setState(() {
                                        if (result == 'success') {
                                          _success = true;
                                        }

                                        _isLoading = false;
                                      });
                                    }
                                  },
                                  text: languages[choosenLanguage]
                                      ['text_submit']),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),

              //complaint options

              (_showOptions == true)
                  ? Positioned(
                      top: media.width * 0.19 +
                          MediaQuery.of(context).padding.top,
                      child: Container(
                        padding: EdgeInsets.all(media.width * 0.025),
                        margin: EdgeInsets.only(
                            left: media.width * 0.1, right: media.width * 0.05),
                        height: media.width * 0.4,
                        width: media.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1.2, color: borderLines),
                          color: page,
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: generalComplaintList
                                .asMap()
                                .map((i, value) {
                                  return MapEntry(
                                      i,
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            complaintType = i;
                                            _showOptions = false;
                                          });
                                        },
                                        child: Container(
                                          width: media.width * 0.7,
                                          padding: EdgeInsets.only(
                                              top: media.width * 0.025,
                                              bottom: media.width * 0.025),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1.1,
                                                      color: (i ==
                                                              generalComplaintList
                                                                      .length -
                                                                  1)
                                                          ? Colors.transparent
                                                          : borderLines))),
                                          child: Text(
                                            generalComplaintList[i]['title'],
                                            style: TextStyle(color: buttonColor),
                                          ),
                                        ),
                                      ));
                                })
                                .values
                                .toList(),
                          ),
                        ),
                      ))
                  : Container(),

              //success
              (_success == true)
                  ? Positioned(
                      child: Container(
                      height: media.height * 1,
                      width: media.width * 1,
                      color: (isDarkTheme == true)
                          ? textColor.withOpacity(0.2)
                          : Colors.transparent.withOpacity(0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(media.width * 0.05),
                            width: media.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: page,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: media.width * 0.7,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ['text_complaint_success'],
                                    style: GoogleFonts.roboto(
                                        fontSize: media.width * sixteen,
                                        fontWeight: FontWeight.w600,
                                        color: buttonColor),
                                  ),
                                ),
                                SizedBox(
                                  height: media.width * 0.025,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: media.width * 0.7,
                                  child: Text(
                                    languages[choosenLanguage]
                                        ['text_complaint_success_2'],
                                    style: GoogleFonts.roboto(
                                        fontSize: media.width * sixteen,
                                        fontWeight: FontWeight.w600,
                                        color: buttonColor),
                                  ),
                                ),
                                SizedBox(
                                  height: media.width * 0.05,
                                ),
                                Button(
                                  color: Colors.black,
                                    onTap: () {
                                      Navigator.pop(context, true);
                                    },
                                    text: languages[choosenLanguage]
                                        ['text_thankyou'])
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
                  : Container(),
              //loader
              (_isLoading == true)
                  ? const Positioned(top: 0, child: Loading())
                  : Container(),

              //no internet
              (internet == false)
                  ? Positioned(
                      top: 0,
                      child: NoInternet(
                        onTap: () {
                          internetTrue();
                        },
                      ))
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
