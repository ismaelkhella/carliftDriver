import 'package:flutter/material.dart';
import 'package:tagxisuperdriver/functions/functions.dart';
import 'package:tagxisuperdriver/pages/loadingPage/loading.dart';
import 'package:tagxisuperdriver/pages/noInternet/nointernet.dart';
import 'package:tagxisuperdriver/pages/vehicleInformations/vehicle_make.dart';
import 'package:tagxisuperdriver/styles/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tagxisuperdriver/translation/translation.dart';
import 'package:tagxisuperdriver/widgets/widgets.dart';

class VehicleType extends StatefulWidget {
  const VehicleType({Key? key}) : super(key: key);

  @override
  State<VehicleType> createState() => _VehicleTypeState();
}

dynamic myVehicalType;
dynamic myVehicleId;
dynamic myVehicleIconFor;
List<String> vehicletypelist = [];
List<String> vehicletypelisticon = [];

class _VehicleTypeState extends State<VehicleType> {
  bool _loaded = false;

  @override
  void initState() {
    getvehicle();
    super.initState();
  }

//get vehicle type
  getvehicle() async {
    myVehicalType = '';
    myVehicleId = '';
    myVehicleIconFor = '';
    vehicletypelist = [];
    vehicletypelisticon = [];
    await getvehicleType();
    print('vehicleType: $vehicleType');
    if (mounted) {
      setState(() {
        _loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: media.width * 0.08,
                  right: media.width * 0.08,
                  top: media.width * 0.05 + MediaQuery.of(context).padding.top),
              height: media.height * 1,
              width: media.width * 1,
              color: page,
              child: Column(
                children: [
                  Container(
                      width: media.width * 1,
                      color: page,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back, color: textColor)),
                        ],
                      )),
                  SizedBox(
                    height: media.height * 0.04,
                  ),
                  SizedBox(
                      width: media.width * 1,
                      child: Text(
                        languages[choosenLanguage]['text_vehicle_type'],
                        style: GoogleFonts.roboto(
                            fontSize: media.width * twenty,
                            color: textColor,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(height: 10),
                  (_loaded != false && vehicleType.isNotEmpty)
                      ? Expanded(
                          child: SingleChildScrollView(
                          child: Column(
                            children: vehicleType
                                .asMap()
                                .map((i, value) => MapEntry(
                                    i,
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      width: media.width * 1,
                                      alignment: Alignment.centerLeft,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (vehicletypelist.contains(
                                                vehicleType[i]['id']
                                                    .toString())) {
                                              vehicletypelist.remove(
                                                  vehicleType[i]['id']
                                                      .toString());
                                            } else if (userDetails['role'] !=
                                                'owner') {
                                              vehicletypelist.add(vehicleType[i]
                                                      ['id']
                                                  .toString());
                                            } else {
                                              vehicletypelist = [
                                                vehicleType[i]['id'].toString()
                                              ];
                                            }
                                          });
                                          // setState(() {
                                          //   myVehicleId = vehicleType[i]['id'];
                                          //   myVehicleIconFor = vehicleType[i]
                                          //       ['icon_types_for'];
                                          // });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                (vehicleType[i]['icon'] != null)
                                                    ? SizedBox(
                                                        width:
                                                            media.width * 0.133,
                                                        height:
                                                            media.width * 0.133,
                                                        child: Image.network(
                                                          vehicleType[i]
                                                              ['icon'],
                                                          fit: BoxFit.contain,
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        height:
                                                            media.width * 0.133,
                                                        width:
                                                            media.width * 0.133,
                                                      ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  vehicleType[i]['name'],
                                                  style: GoogleFonts.roboto(
                                                      fontSize:
                                                          media.width * twenty,
                                                      color: textColor),
                                                ),
                                              ],
                                            ),
                                            (vehicletypelist.contains(
                                                    vehicleType[i]['id']))
                                                ? Icon(
                                                    Icons.done,
                                                    color: buttonColor,
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                    )))
                                .values
                                .toList(),
                          ),
                        ))
                      : Container(child: Text(vehicleType.isEmpty.toString()),),
                  (vehicletypelist.isNotEmpty)
                      ? Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Button(
                              onTap: () {
                                myVehicleIconFor = vehicleType.firstWhere(
                                    (element) =>
                                        element['id'] ==
                                        vehicletypelist[0])['icon_types_for'];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const VehicleMake()));
                              },
                              text: languages[choosenLanguage]['text_next']),
                        )
                      : Container()
                ],
              ),
            ),

            //no internet
            (internet == false)
                ? Positioned(
                    top: 0,
                    child: NoInternet(
                      onTap: () {
                        setState(() {
                          internetTrue();
                        });
                      },
                    ))
                : Container(),

            //loader
            (_loaded == false)
                ? const Positioned(top: 0, child: Loading())
                : Container()
          ],
        ),
      ),
    );
  }
}
