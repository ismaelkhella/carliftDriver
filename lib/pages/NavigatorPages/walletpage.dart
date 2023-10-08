import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagxisuperdriver/functions/functions.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/cashfreepage.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/flutterwavepayment.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/paystackpayment.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/razorpaypage.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/selectwallet.dart';
import 'package:tagxisuperdriver/pages/NavigatorPages/withdraw.dart';
import 'package:tagxisuperdriver/pages/loadingPage/loading.dart';
import 'package:tagxisuperdriver/pages/login/signupmethod.dart';
import 'package:tagxisuperdriver/pages/noInternet/nointernet.dart';
import 'package:tagxisuperdriver/styles/styles.dart';
import 'package:tagxisuperdriver/translation/translation.dart';
import 'package:tagxisuperdriver/widgets/widgets.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

dynamic addMoney;

class _WalletPageState extends State<WalletPage> {
  TextEditingController addMoneyController = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController amount = TextEditingController();

  bool _completed = false;
  bool _isLoading = true;
  bool _addPayment = false;
  bool _choosePayment = false;
  bool showtoast = false;
  @override
  void initState() {
    getWallet();
    super.initState();
  }

  getWallet() async {
    var val = await getWalletHistory();
    if (val == 'logout') {
      navigateLogout();
    }
    if (mounted) {
      if (val == 'success') {
        _isLoading = false;
        _completed = true;
        valueNotifierHome.incrementNotifier();
      }
    }
  }

  navigateLogout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignupMethod()));
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          value: "user",
          child: Text("User", style: TextStyle(color: buttonColor))),
      DropdownMenuItem(
          value: "driver",
          child: Text("Driver", style: TextStyle(color: buttonColor))),
      DropdownMenuItem(
          value: "owner",
          child: Text("Owner", style: TextStyle(color: buttonColor))),
    ];
    return menuItems;
  }

  showToast() {
    setState(() {
      showtoast = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showtoast = false;
      });
    });
  }

  String dropdownValue = 'user';
  bool error = false;
  String errortext = '';
  bool ispop = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: ValueListenableBuilder(
          valueListenable: valueNotifierHome.value,
          builder: (context, value, child) {
            return Directionality(
              textDirection: (languageDirection == 'rtl')
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Scaffold(
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(media.width * 0.05,
                          media.width * 0.05, media.width * 0.05, 0),
                      height: media.height * 1,
                      width: media.width * 1,
                      color: page,
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).padding.top),
                          Stack(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(bottom: media.width * 0.05),
                                width: media.width * 1,
                                alignment: Alignment.center,
                                child: Text(
                                  languages[choosenLanguage]
                                      ['text_enable_wallet'],
                                  style: GoogleFonts.roboto(
                                      fontSize: media.width * twenty,
                                      fontWeight: FontWeight.w600,
                                      color: buttonColor),
                                ),
                              ),
                              Positioned(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back,
                                          color: buttonColor)))
                            ],
                          ),
                          SizedBox(
                            height: media.width * 0.05,
                          ),
                          (walletBalance.isNotEmpty)
                              ? Column(
                                  children: [
                                    Text(
                                      languages[choosenLanguage]
                                          ['text_availablebalance'],
                                      style: GoogleFonts.roboto(
                                          fontSize: media.width * twelve,
                                          color: buttonColor),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.01,
                                    ),
                                    Text(
                                      walletBalance['currency_symbol'] +
                                          walletBalance['wallet_balance']
                                              .toString(),
                                      style: GoogleFonts.roboto(
                                          color: buttonColor,
                                          fontSize: media.width * fourty,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    Button(
                                      onTap: () {
                                        setState(() {
                                          ispop = true;
                                        });
                                      },
                                      text: languages[choosenLanguage]
                                          ['text_share_money'],
                                      width: media.width * 0.3,
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    SizedBox(
                                      width: media.width * 0.9,
                                      child: Text(
                                        languages[choosenLanguage]
                                            ['text_recenttransactions'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * fourteen,
                                            color: buttonColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          Expanded(
                              child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                //wallet history
                                (walletHistory.isNotEmpty)
                                    ? Column(
                                        children: walletHistory
                                            .asMap()
                                            .map((i, value) {
                                              return MapEntry(
                                                  i,
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: media.width * 0.02,
                                                        bottom:
                                                            media.width * 0.02),
                                                    width: media.width * 0.9,
                                                    padding: EdgeInsets.all(
                                                        media.width * 0.025),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: borderLines,
                                                            width: 1.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: page),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: media.width *
                                                              0.1067,
                                                          width: media.width *
                                                              0.1067,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: (isDarkTheme ==
                                                                      true)
                                                                  ? textColor
                                                                      .withOpacity(
                                                                          0.2)
                                                                  : const Color(
                                                                          0xff000000)
                                                                      .withOpacity(
                                                                          0.05)),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            (walletHistory[i][
                                                                        'is_credit'] ==
                                                                    1)
                                                                ? '+'
                                                                : '-',
                                                            style: GoogleFonts.roboto(
                                                                fontSize: media
                                                                        .width *
                                                                    twentyfour,
                                                                color:
                                                                buttonColor),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: media.width *
                                                              0.025,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  media.width *
                                                                      0.55,
                                                              child: Text(
                                                                walletHistory[i]
                                                                    ['remarks'],
                                                                style: GoogleFonts.roboto(
                                                                    fontSize: media
                                                                            .width *
                                                                        fourteen,
                                                                    color:
                                                                    buttonColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  media.width *
                                                                      0.02,
                                                            ),
                                                            Text(
                                                              walletHistory[i][
                                                                      'created_at']
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                fontSize: media
                                                                        .width *
                                                                    ten,
                                                                color: (isDarkTheme ==
                                                                        true)
                                                                    ? textColor
                                                                        .withOpacity(
                                                                            0.5)
                                                                    : hintColor,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Expanded(
                                                            child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              width:
                                                                  media.width *
                                                                      0.15,
                                                              child: Text(
                                                                walletHistory[i]
                                                                        [
                                                                        'currency_symbol'] +
                                                                    ' ' +
                                                                    walletHistory[i]
                                                                            [
                                                                            'amount']
                                                                        .toString(),
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontSize: media
                                                                          .width *
                                                                      twelve,
                                                                  color: const Color(
                                                                      0xffE60000),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ))
                                                      ],
                                                    ),
                                                  ));
                                            })
                                            .values
                                            .toList(),
                                      )
                                    : (_completed == true)
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: media.width * 0.05,
                                              ),
                                              Container(
                                                height: media.width * 0.7,
                                                width: media.width * 0.7,
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/nodatafound.gif'),
                                                        fit: BoxFit.contain)),
                                              ),
                                              SizedBox(
                                                height: media.width * 0.02,
                                              ),
                                              SizedBox(
                                                width: media.width * 0.9,
                                                child: Text(
                                                  languages[choosenLanguage]
                                                      ['text_noDataFound'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          media.width * sixteen,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: buttonColor),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          )
                                        : Container(),
                                (walletPages.isNotEmpty)
                                    ? (walletPages['current_page'] <
                                            walletPages['total_pages'])
                                        ? InkWell(
                                            onTap: () async {
                                              setState(() {
                                                _isLoading = true;
                                              });

                                              var val = await getWalletHistoryPage(
                                                  (walletPages['current_page'] +
                                                          1)
                                                      .toString());
                                              if (val == 'logout') {
                                                navigateLogout();
                                              }

                                              setState(() {
                                                _isLoading = false;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                  media.width * 0.025),
                                              margin: EdgeInsets.only(
                                                  bottom: media.width * 0.05),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: page,
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2)),
                                              child: Text(
                                                languages[choosenLanguage]
                                                    ['text_loadmore'],
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        media.width * sixteen,
                                                    color: buttonColor),
                                              ),
                                            ),
                                          )
                                        : Container()
                                    : Container()
                              ],
                            ),
                          )),

                          //withdraw money
                          (_addPayment == false)
                              ? Container(
                                  padding: EdgeInsets.only(
                                      top: media.width * 0.05,
                                      bottom: media.width * 0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Button(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Withdraw()));
                                        },
                                        text: languages[choosenLanguage]
                                            ['text_withdraw'],
                                        width: media.width * 0.4,
                                      ),
                                      Button(
                                        onTap: () {
                                          if (_addPayment == false) {
                                            setState(() {
                                              _addPayment = true;
                                            });
                                          }
                                        },
                                        text: languages[choosenLanguage]
                                            ['text_addmoney'],
                                        width: media.width * 0.4,
                                      ),
                                    ],
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    //add money
                    (_addPayment == true)
                        ? Positioned(
                            bottom: 0,
                            child: Container(
                              height: media.height * 1,
                              width: media.width * 1,
                              color: Colors.transparent.withOpacity(0.6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: media.width * 0.05),
                                    width: media.width * 0.9,
                                    padding:
                                        EdgeInsets.all(media.width * 0.025),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: borderLines, width: 1.2),
                                        color: page),
                                    child: Column(children: [
                                      Container(
                                        height: media.width * 0.128,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: borderLines, width: 1.2),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                                width: media.width * 0.1,
                                                height: media.width * 0.128,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        (languageDirection ==
                                                                'ltr')
                                                            ? const BorderRadius
                                                                .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        12),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        12),
                                                              )
                                                            : const BorderRadius
                                                                .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        12),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                    color: const Color(
                                                        0xffF0F0F0)),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  walletBalance[
                                                          'currency_symbol']
                                                      .toString(),
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          media.width * fifteen,
                                                      color:
                                                          (isDarkTheme == true)
                                                              ? Colors.black
                                                              : textColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                            SizedBox(
                                              width: media.width * 0.05,
                                            ),
                                            Container(
                                              height: media.width * 0.128,
                                              width: media.width * 0.6,
                                              alignment: Alignment.center,
                                              child: TextField(
                                                controller: addMoneyController,
                                                onChanged: (val) {
                                                  setState(() {
                                                    addMoney =
                                                        double.parse(val);
                                                  });
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      languages[choosenLanguage]
                                                          ['text_enteramount'],
                                                  hintStyle: GoogleFonts.roboto(
                                                      fontSize:
                                                          media.width * twelve,
                                                      color: (isDarkTheme ==
                                                              true)
                                                          ? textColor
                                                              .withOpacity(0.4)
                                                          : hintColor),
                                                ),
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        media.width * fourteen,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: buttonColor),
                                                maxLines: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: media.width * 0.05,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                addMoneyController.text = '100';
                                                addMoney = 100;
                                              });
                                            },
                                            child: Container(
                                              height: media.width * 0.11,
                                              width: media.width * 0.17,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2),
                                                  color: page,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: Text(
                                                walletBalance[
                                                        'currency_symbol'] +
                                                    '100',
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        media.width * twelve,
                                                    color: buttonColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: media.width * 0.05,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                addMoneyController.text = '500';
                                                addMoney = 500;
                                              });
                                            },
                                            child: Container(
                                              height: media.width * 0.11,
                                              width: media.width * 0.17,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2),
                                                  color: page,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: Text(
                                                walletBalance[
                                                        'currency_symbol'] +
                                                    '500',
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        media.width * twelve,
                                                    color: buttonColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: media.width * 0.05,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                addMoneyController.text =
                                                    '1000';
                                                addMoney = 1000;
                                              });
                                            },
                                            child: Container(
                                              height: media.width * 0.11,
                                              width: media.width * 0.17,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2),
                                                  color: page,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: Text(
                                                walletBalance[
                                                        'currency_symbol'] +
                                                    '1000',
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        media.width * twelve,
                                                    color: buttonColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: media.width * 0.1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Button(
                                            onTap: () async {
                                              setState(() {
                                                _addPayment = false;
                                                addMoney = null;
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                                addMoneyController.clear();
                                              });
                                            },
                                            text: languages[choosenLanguage]
                                                ['text_cancel'],
                                            width: media.width * 0.4,
                                          ),
                                          Button(
                                            onTap: () async {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              if (addMoney != 0 &&
                                                  addMoney != null) {
                                                // var nav = await  Navigator.push(context, MaterialPageRoute(builder: (context)=>KhaltiPage()));
                                                //   if(nav != null){
                                                //     if(nav){
                                                //       setState(() {
                                                //         _choosePayment = false;
                                                //         _addPayment = false;
                                                //       });
                                                //     }
                                                //   }
                                                setState(() {
                                                  _choosePayment = true;
                                                  _addPayment = false;
                                                });
                                              }
                                            },
                                            text: languages[choosenLanguage]
                                                ['text_addmoney'],
                                            width: media.width * 0.4,
                                          ),
                                        ],
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                            ))
                        : Container(),

                    //choose payment method
                    (_choosePayment == true)
                        ? Positioned(
                            child: Container(
                            height: media.height * 1,
                            width: media.width * 1,
                            color: Colors.transparent.withOpacity(0.6),
                            child: SingleChildScrollView(
                              child: SizedBox(
                                height: media.height * 1,
                                width: media.width * 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: media.width * 0.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                _choosePayment = false;
                                                _addPayment = true;
                                              });
                                            },
                                            child: Container(
                                              height: media.height * 0.05,
                                              width: media.height * 0.05,
                                              decoration: BoxDecoration(
                                                color: page,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(Icons.cancel,
                                                  color: buttonColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: media.width * 0.025),
                                    Container(
                                      padding:
                                          EdgeInsets.all(media.width * 0.05),
                                      width: media.width * 0.8,
                                      height: media.height * 0.6,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: topBar),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                              width: media.width * 0.7,
                                              child: Text(
                                                languages[choosenLanguage]
                                                    ['text_choose_payment'],
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        media.width * eighteen,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                          SizedBox(
                                            height: media.width * 0.05,
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              child: Column(
                                                children: [
                                                  (walletBalance['stripe'] ==
                                                          true)
                                                      ? Container(
                                                          margin: EdgeInsets.only(
                                                              bottom:
                                                                  media.width *
                                                                      0.025),
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              media.width * 0.7,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              var val = await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const SelectWallet()));
                                                              if (val) {
                                                                setState(() {
                                                                  _choosePayment =
                                                                      false;
                                                                  _addPayment =
                                                                      false;
                                                                  addMoney =
                                                                      null;
                                                                  addMoneyController
                                                                      .clear();
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              width:
                                                                  media.width *
                                                                      0.25,
                                                              height:
                                                                  media.width *
                                                                      0.125,
                                                              decoration: const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/images/stripe-icon.png'),
                                                                      fit: BoxFit
                                                                          .contain)),
                                                            ),
                                                          ))
                                                      : Container(),
                                                  (walletBalance['paystack'] ==
                                                          true)
                                                      ? Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin: EdgeInsets.only(
                                                              bottom:
                                                                  media.width *
                                                                      0.025),
                                                          width:
                                                              media.width * 0.7,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              var val = await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const PayStackPage()));
                                                              if (val) {
                                                                setState(() {
                                                                  _choosePayment =
                                                                      false;
                                                                  _addPayment =
                                                                      false;
                                                                  addMoney =
                                                                      null;
                                                                  addMoneyController
                                                                      .clear();
                                                                  _isLoading =
                                                                      true;
                                                                });
                                                                getWallet();
                                                              }
                                                            },
                                                            child: Container(
                                                              width:
                                                                  media.width *
                                                                      0.25,
                                                              height:
                                                                  media.width *
                                                                      0.125,
                                                              decoration: const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/images/paystack-icon.png'),
                                                                      fit: BoxFit
                                                                          .contain)),
                                                            ),
                                                          ))
                                                      : Container(),
                                                  (walletBalance[
                                                              'flutter_wave'] ==
                                                          true)
                                                      ? Container(
                                                          margin: EdgeInsets.only(
                                                              bottom:
                                                                  media.width *
                                                                      0.025),
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              media.width * 0.7,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              var val = await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const FlutterWavePage()));
                                                              if (val) {
                                                                setState(() {
                                                                  _choosePayment =
                                                                      false;
                                                                  _addPayment =
                                                                      false;
                                                                  addMoney =
                                                                      null;
                                                                  addMoneyController
                                                                      .clear();
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              width:
                                                                  media.width *
                                                                      0.25,
                                                              height:
                                                                  media.width *
                                                                      0.125,
                                                              decoration: const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/images/flutterwave-icon.png'),
                                                                      fit: BoxFit
                                                                          .contain)),
                                                            ),
                                                          ))
                                                      : Container(),
                                                  (walletBalance['razor_pay'] ==
                                                          true)
                                                      ? Container(
                                                          margin: EdgeInsets.only(
                                                              bottom:
                                                                  media.width *
                                                                      0.025),
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              media.width * 0.7,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              var val = await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const RazorPayPage()));
                                                              if (val) {
                                                                setState(() {
                                                                  _choosePayment =
                                                                      false;
                                                                  _addPayment =
                                                                      false;
                                                                  addMoney =
                                                                      null;
                                                                  addMoneyController
                                                                      .clear();
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              width:
                                                                  media.width *
                                                                      0.25,
                                                              height:
                                                                  media.width *
                                                                      0.125,
                                                              decoration: const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/images/razorpay-icon.jpeg'),
                                                                      fit: BoxFit
                                                                          .contain)),
                                                            ),
                                                          ))
                                                      : Container(),
                                                  (walletBalance['cash_free'] ==
                                                          true)
                                                      ? Container(
                                                          margin: EdgeInsets.only(
                                                              bottom:
                                                                  media.width *
                                                                      0.025),
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              media.width * 0.7,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              var val = await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const CashFreePage()));
                                                              if (val) {
                                                                setState(() {
                                                                  _choosePayment =
                                                                      false;
                                                                  _addPayment =
                                                                      false;
                                                                  addMoney =
                                                                      null;
                                                                  addMoneyController
                                                                      .clear();
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              width:
                                                                  media.width *
                                                                      0.25,
                                                              height:
                                                                  media.width *
                                                                      0.125,
                                                              decoration: const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'assets/images/cashfree-icon.jpeg'),
                                                                      fit: BoxFit
                                                                          .contain)),
                                                            ),
                                                          ))
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                        : Container(),

                    //no internet
                    (internet == false)
                        ? Positioned(
                            top: 0,
                            child: NoInternet(
                              onTap: () {
                                setState(() {
                                  internetTrue();
                                  _completed = false;
                                  _isLoading = true;
                                  getWallet();
                                });
                              },
                            ))
                        : Container(),

                    (ispop == true)
                        ? Positioned(
                            top: 0,
                            child: Container(
                              height: media.height * 1,
                              width: media.width * 1,
                              color: (isDarkTheme == true)
                                  ? textColor.withOpacity(0.2)
                                  : Colors.transparent.withOpacity(0.6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.all(media.width * 0.05),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: page),
                                      width: media.width * 0.8,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: page,
                                              ),
                                              dropdownColor: page,
                                              value: dropdownValue,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownValue = newValue!;
                                                });
                                              },
                                              items: dropdownItems),
                                          InputField(
                                              text: languages[choosenLanguage]
                                                  ['text_enteramount'],
                                              textController: amount,
                                              inputType: TextInputType.number),
                                          // InputField(
                                          //     text: languages[choosenLanguage]
                                          //         ['text_phone_number'],
                                          //     textController: phonenumber,
                                          //     inputType: TextInputType.number),
                                          TextFormField(
                                            controller: phonenumber,
                                            onChanged: (val) {
                                              if (phonenumber.text.length ==
                                                  countries[phcode]
                                                      ['dial_max_length']) {
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              }
                                            },
                                            // maxLength: countries[phcode]
                                            //     ['dial_max_length'],
                                            style: GoogleFonts.roboto(
                                                fontSize: media.width * sixteen,
                                                color: buttonColor,
                                                letterSpacing: 1),
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText:
                                                  languages[choosenLanguage]
                                                      ['text_phone_number'],
                                              counterText: '',
                                              hintStyle: GoogleFonts.roboto(
                                                  fontSize:
                                                      media.width * sixteen,
                                                  color: textColor
                                                      .withOpacity(0.5)),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: (isDarkTheme == true)
                                                    ? textColor
                                                    : inputfocusedUnderline,
                                                width: 1.2,
                                                style: BorderStyle.solid,
                                              )),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                color: (isDarkTheme == true)
                                                    ? textColor.withOpacity(0.3)
                                                    : inputUnderline,
                                                width: 1.2,
                                                style: BorderStyle.solid,
                                              )),
                                            ),
                                          ),
                                          SizedBox(
                                            height: media.width * 0.05,
                                          ),
                                          error == true
                                              ? Text(
                                                  errortext,
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                )
                                              : Container(),
                                          SizedBox(
                                            height: media.width * 0.05,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Button(
                                                  width: media.width * 0.2,
                                                  height: media.width * 0.09,
                                                  onTap: () {
                                                    setState(() {
                                                      ispop = false;
                                                      dropdownValue = 'user';
                                                      error = false;
                                                      errortext = '';
                                                      phonenumber.text = '';
                                                      amount.text = '';
                                                    });
                                                  },
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_close']),
                                              SizedBox(
                                                width: media.width * 0.05,
                                              ),
                                              Button(
                                                  width: media.width * 0.2,
                                                  height: media.width * 0.09,
                                                  onTap: () async {
                                                    setState(() {
                                                      _isLoading = true;
                                                    });
                                                    if (phonenumber.text ==
                                                            '' ||
                                                        amount.text == '') {
                                                      setState(() {
                                                        error = true;
                                                        errortext = languages[
                                                                choosenLanguage]
                                                            [
                                                            'text_fill_fileds'];
                                                        _isLoading = false;
                                                      });
                                                    } else {
                                                      var result =
                                                          await sharewalletfun(
                                                              amount:
                                                                  amount.text,
                                                              mobile:
                                                                  phonenumber
                                                                      .text,
                                                              role:
                                                                  dropdownValue);
                                                      if (result == 'success') {
                                                        // navigate();
                                                        setState(() {
                                                          ispop = false;
                                                          dropdownValue =
                                                              'user';
                                                          error = false;
                                                          errortext = '';
                                                          phonenumber.text = '';
                                                          amount.text = '';
                                                          getWallet();
                                                          showToast();
                                                        });
                                                      } else if (result ==
                                                          'logout') {
                                                        navigateLogout();
                                                      } else {
                                                        setState(() {
                                                          error = true;
                                                          errortext =
                                                              result.toString();
                                                          _isLoading = false;
                                                        });
                                                      }
                                                    }
                                                  },
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_share']),
                                            ],
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          )
                        : Container(),

                    //loader
                    (_isLoading == true)
                        ? const Positioned(child: Loading())
                        : Container(),

                    (showtoast == true)
                        ? Positioned(
                            bottom: media.height * 0.2,
                            left: media.width * 0.2,
                            right: media.width * 0.2,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(media.width * 0.025),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent.withOpacity(0.6)),
                              child: Text(
                                languages[choosenLanguage]
                                    ['text_transferred_successfully'],
                                style: GoogleFonts.roboto(
                                    fontSize: media.width * twelve,
                                    color: Colors.white),
                              ),
                            ))
                        : Container()
                  ],
                ),
              ),
            );
          }),
    );
  }
}
