import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagxisuperdriver/functions/functions.dart';
import 'package:tagxisuperdriver/pages/onTripPage/review_page.dart';
import 'package:tagxisuperdriver/styles/styles.dart';
import 'package:tagxisuperdriver/translation/translation.dart';
import 'package:tagxisuperdriver/widgets/widgets.dart';

class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  State<Invoice> createState() => _InvoiceState();
}

int payby = 0;

class _InvoiceState extends State<Invoice> {
  @override
  void initState() {
    if (driverReq['is_paid'] == 0) {
      payby = 0;
    }
    super.initState();
  }

  String userPayAmount = '';

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: ValueListenableBuilder(
            valueListenable: valueNotifierHome.value,
            builder: (context, value, child) {
              return Container(
                padding: EdgeInsets.fromLTRB(
                    media.width * 0.05,
                    MediaQuery.of(context).padding.top + media.width * 0.05,
                    media.width * 0.05,
                    media.width * 0.05),
                height: media.height * 1,
                width: media.width * 1,
                color: page,
                //invoice data
                child: (driverReq.isNotEmpty)
                    ? Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    languages[choosenLanguage]
                                        ['text_tripsummary'],
                                    style: GoogleFonts.roboto(
                                        color: textColor,
                                        fontSize: media.width * sixteen,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: media.height * 0.04,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (driverReq.isNotEmpty)
                                        Container(
                                          height: media.width * 0.13,
                                          width: media.width * 0.13,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      driverReq['userDetail']
                                                              ['data']
                                                          ['profile_picture']),
                                                  fit: BoxFit.contain)),
                                        ),
                                      SizedBox(
                                        width: media.width * 0.05,
                                      ),
                                      Text(
                                        driverReq['userDetail']['data']['name'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * eighteen,
                                            color: textColor),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: media.height * 0.05,
                                  ),
                                  SizedBox(
                                    width: media.width * 0.72,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  languages[choosenLanguage]
                                                      ['text_reference'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          media.width * twelve,
                                                      color: const Color(
                                                          0xff898989)),
                                                ),
                                                SizedBox(
                                                  height: media.width * 0.02,
                                                ),
                                                Text(
                                                  driverReq['request_number'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize: media.width *
                                                          fourteen,
                                                      color: textColor),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  languages[choosenLanguage]
                                                      ['text_rideType'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          media.width * twelve,
                                                      color: const Color(
                                                          0xff898989)),
                                                ),
                                                SizedBox(
                                                  height: media.width * 0.02,
                                                ),
                                                Text(
                                                  (driverReq['is_rental'] ==
                                                          false)
                                                      ? languages[
                                                              choosenLanguage]
                                                          ['text_regular']
                                                      : languages[
                                                              choosenLanguage]
                                                          ['text_rental'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize: media.width *
                                                          fourteen,
                                                      color: textColor),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: media.height * 0.02,
                                        ),
                                        Container(
                                          height: 2,
                                          color: const Color(0xffAAAAAA),
                                        ),
                                        SizedBox(
                                          height: media.height * 0.02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  languages[choosenLanguage]
                                                      ['text_distance'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          media.width * twelve,
                                                      color: const Color(
                                                          0xff898989)),
                                                ),
                                                SizedBox(
                                                  height: media.width * 0.02,
                                                ),
                                                Text(
                                                  driverReq['total_distance'] +
                                                      ' ' +
                                                      driverReq['unit'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize: media.width *
                                                          fourteen,
                                                      color: textColor),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  languages[choosenLanguage]
                                                      ['text_duration'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          media.width * twelve,
                                                      color: const Color(
                                                          0xff898989)),
                                                ),
                                                SizedBox(
                                                  height: media.width * 0.02,
                                                ),
                                                Text(
                                                  '${driverReq['total_time']} mins',
                                                  style: GoogleFonts.roboto(
                                                      fontSize: media.width *
                                                          fourteen,
                                                      color: textColor),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: media.height * 0.05,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.info, color: textColor),
                                      SizedBox(
                                        width: media.width * 0.04,
                                      ),
                                      Text(
                                        languages[choosenLanguage]
                                            ['text_tripfare'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * fourteen,
                                            color: textColor),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: media.height * 0.05,
                                  ),
                                  (driverReq['is_rental'] == true)
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              bottom: media.width * 0.05),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                languages[choosenLanguage]
                                                    ['text_ride_type'],
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        media.width * fourteen,
                                                    color: textColor),
                                              ),
                                              Text(
                                                driverReq[
                                                    'rental_package_name'],
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        media.width * fourteen,
                                                    color: textColor),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        languages[choosenLanguage]
                                            ['text_baseprice'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                      Text(
                                        driverReq['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            double.parse(
                                                    driverReq['requestBill']
                                                                ['data']
                                                            ['base_price']
                                                        .toString())
                                                .toStringAsFixed(2),
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: media.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        languages[choosenLanguage]
                                            ['text_distprice'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                      Text(
                                        driverReq['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            double.parse(
                                                    driverReq['requestBill']
                                                                ['data']
                                                            ['distance_price']
                                                        .toString())
                                                .toStringAsFixed(2),
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: media.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        languages[choosenLanguage]
                                            ['text_timeprice'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                      Text(
                                        driverReq['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            double.parse(
                                                    driverReq['requestBill']
                                                                ['data']
                                                            ['time_price']
                                                        .toString())
                                                .toStringAsFixed(2),
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: media.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        languages[choosenLanguage]
                                                ['text_waiting_price'] +
                                            ' (' +
                                            driverReq['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            driverReq['requestBill']['data']
                                                    ['waiting_charge_per_min']
                                                .toString() +
                                            ' x ' +
                                            driverReq['requestBill']['data']
                                                    ['calculated_waiting_time']
                                                .toString() +
                                            ' mins' +
                                            ')',
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                      Text(
                                        driverReq['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            double.parse(
                                                    driverReq['requestBill']
                                                                ['data']
                                                            ['waiting_charge']
                                                        .toString())
                                                .toStringAsFixed(2),
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                    ],
                                  ),
                                  (driverReq['requestBill']['data']
                                              ['cancellation_fee'] !=
                                          0)
                                      ? SizedBox(
                                          height: media.height * 0.02,
                                        )
                                      : Container(),
                                  (driverReq['requestBill']['data']
                                              ['cancellation_fee'] !=
                                          0)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              languages[choosenLanguage]
                                                  ['text_cancelfee'],
                                              style: GoogleFonts.roboto(
                                                  fontSize:
                                                      media.width * twelve,
                                                  color: textColor),
                                            ),
                                            Text(
                                              driverReq['requestBill']['data'][
                                                      'requested_currency_symbol'] +
                                                  ' ' +
                                                  double.parse(driverReq[
                                                                      'requestBill']
                                                                  ['data'][
                                                              'cancellation_fee']
                                                          .toString())
                                                      .toStringAsFixed(2),
                                              style: GoogleFonts.roboto(
                                                  fontSize:
                                                      media.width * twelve,
                                                  color: textColor),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  (driverReq['requestBill']['data']
                                              ['airport_surge_fee'] !=
                                          0)
                                      ? SizedBox(
                                          height: media.height * 0.02,
                                        )
                                      : Container(),
                                  (driverReq['requestBill']['data']
                                              ['airport_surge_fee'] !=
                                          0)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              languages[choosenLanguage]
                                                  ['text_surge_fee'],
                                              style: GoogleFonts.roboto(
                                                  fontSize:
                                                      media.width * twelve,
                                                  color: textColor),
                                            ),
                                            Text(
                                              driverReq['requestBill']['data'][
                                                      'requested_currency_symbol'] +
                                                  ' ' +
                                                  double.parse(driverReq[
                                                                      'requestBill']
                                                                  ['data'][
                                                              'airport_surge_fee']
                                                          .toString())
                                                      .toStringAsFixed(2),
                                              style: GoogleFonts.roboto(
                                                  fontSize:
                                                      media.width * twelve,
                                                  color: textColor),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: media.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        languages[choosenLanguage]
                                            ['text_convfee'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                      Text(
                                        driverReq['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            double.parse(
                                                    driverReq['requestBill']
                                                                ['data']
                                                            ['admin_commision']
                                                        .toString())
                                                .toStringAsFixed(2),
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                    ],
                                  ),
                                  (driverReq['requestBill']['data']
                                              ['promo_discount'] !=
                                          null)
                                      ? SizedBox(
                                          height: media.height * 0.02,
                                        )
                                      : Container(),
                                  (driverReq['requestBill']['data']
                                              ['promo_discount'] !=
                                          null)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              languages[choosenLanguage]
                                                  ['text_discount'],
                                              style: GoogleFonts.roboto(
                                                  fontSize:
                                                      media.width * twelve,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              driverReq['requestBill']['data'][
                                                      'requested_currency_symbol'] +
                                                  ' ' +
                                                  double.parse(driverReq[
                                                                      'requestBill']
                                                                  ['data']
                                                              ['promo_discount']
                                                          .toString())
                                                      .toStringAsFixed(2),
                                              style: GoogleFonts.roboto(
                                                  fontSize:
                                                      media.width * twelve,
                                                  color: Colors.red),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: media.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        languages[choosenLanguage]
                                            ['text_taxes'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                      Text(
                                        driverReq['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            double.parse(
                                                    driverReq['requestBill']
                                                                ['data']
                                                            ['service_tax']
                                                        .toString())
                                                .toStringAsFixed(2),
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: media.height * 0.02,
                                  ),
                                  Container(
                                    height: 1.5,
                                    color: const Color(0xffE0E0E0),
                                  ),
                                  SizedBox(
                                    height: media.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        languages[choosenLanguage]
                                            ['text_totalfare'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                      Text(
                                        driverReq['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            double.parse(
                                                    driverReq['requestBill']
                                                                ['data']
                                                            ['total_amount']
                                                        .toString())
                                                .toStringAsFixed(2),
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * twelve,
                                            color: textColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: media.height * 0.02,
                                  ),
                                  Container(
                                    height: 1.5,
                                    color: const Color(0xffE0E0E0),
                                  ),
                                  SizedBox(
                                    height: media.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        (driverReq['payment_opt'] == '1')
                                            ? languages[choosenLanguage]
                                                ['text_cash']
                                            : (driverReq['payment_opt'] == '2')
                                                ? languages[choosenLanguage]
                                                    ['text_wallet']
                                                : languages[choosenLanguage]
                                                    ['text_card'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * sixteen,
                                            color: buttonColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        driverReq['requestBill']['data']
                                                ['requested_currency_symbol'] +
                                            ' ' +
                                            double.parse(
                                                    driverReq['requestBill']
                                                                ['data']
                                                            ['total_amount']
                                                        .toString())
                                                .toStringAsFixed(2),
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * sixteen,
                                            color: textColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: media.height * 0.02,
                                  ),
                                  driverReq['payment_opt'] == '1'
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(languages[choosenLanguage]['text_totalclientpayment'],
                                                style: GoogleFonts.roboto(
                                                    fontSize:
                                                        media.width * sixteen,
                                                    color: textColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: media.width * 0.03,
                                                  bottom: media.width * 0.015),
                                              width: media.width * 0.2,
                                              height: media.height * 0.05,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      width: 1.5,
                                                      color: buttonColor)),
                                              child: TextField(
                                                // enabled: tips,
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (val) async {
                                                  setState(() {
                                                    userPayAmount =
                                                        val.toString();
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    border: InputBorder.none),
                                                style: GoogleFonts.roboto(
                                                    color: textColor),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                          (driverReq['payment_opt'] == '0' &&
                                  driverReq['is_paid'] == 0)
                              ? Container(
                                  height: media.width * 0.12,
                                  width: media.width * 0.9,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: borderLines),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        languages[choosenLanguage]
                                            ['text_waitingforpayment'],
                                        style: GoogleFonts.roboto(
                                            fontSize: media.width * fourteen,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                      ),
                                      SizedBox(
                                        width: media.width * 0.05,
                                      ),
                                      SizedBox(
                                          height: media.width * 0.05,
                                          width: media.width * 0.05,
                                          child:
                                              const CircularProgressIndicator())
                                    ],
                                  ),
                                )
                              : Button(
                                  onTap: () async {
                                    print(driverReq['requestBill']['data']['total_amount']);
                                    print(driverReq['requestBill']['data']['base_price']);
                                    print(driverReq['requestBill']['data']['distance_price']);


                                    await takeCommissionFromDriver(
                                        driverReq['requestBill']['data']
                                            ['total_amount'].toString(),
                                        driverReq['requestBill']['data']
                                            ['admin_commision'].toString(),
                                        driverReq['payment_opt'] == '1'?'cash':'wallet'
                                    );

                                    if (driverReq['payment_opt'] == '1') {
                                      if (userPayAmount == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text('Enter user payment amount'),
                                          backgroundColor: Colors.red,
                                        ));
                                      } else {
                                        await userTotalPayCash(
                                            driverReq['requestBill']['data']
                                                    ['total_amount']
                                                .toString(),
                                            driverReq['request_number'].toString(),
                                            userPayAmount);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Review()));
                                      }
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Review()));
                                    }

                                    // }else{
                                    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter the total client payment to you'),backgroundColor: Colors.red,));
                                    //   }
                                  },
                                  text: languages[choosenLanguage]
                                      ['text_confirm'])
                        ],
                      )
                    : Container(),
              );
            }),
      ),
    );
  }
}
