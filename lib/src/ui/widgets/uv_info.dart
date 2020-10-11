import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skintel/src/constants.dart';
import 'package:skintel/src/data/city_model.dart';
import 'package:skintel/src/data/skin_model.dart';
import 'package:skintel/src/data/uv_model.dart';
import 'package:skintel/src/ui/style.dart';
import 'package:skintel/src/ui/widgets/uv_chart.dart';

class UVInfo extends StatelessWidget {
  UVInfo({Key key}) : super(key: key);

  final newFormat = DateFormat("jm");

  @override
  Widget build(BuildContext context) {
    UVModel uvModel = Provider.of<UVModel>(context);
    print(uvModel.currentUV);
    CityModel cityModel = Provider.of<CityModel>(context);
    SkinColorModel skinColorModel = Provider.of<SkinColorModel>(context);
    UVData sunrise;
    UVData sunset;
    int maxUVHour;
    if (uvModel.sunrise.hour > uvModel.sunset.hour) {
      sunrise = UVData(0, 0);
      sunset = UVData(uvModel.sunrise.hour - uvModel.sunset.hour, 0);
      maxUVHour = (uvModel.sunrise.hour - uvModel.sunset.hour) ~/ 2;
    } else {
      maxUVHour = null;
      sunrise = UVData(uvModel.sunrise.hour, 0);
      sunset = UVData(uvModel.sunset.hour, 0);
    }

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          height: MediaQuery.of(context).size.height * .7,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.amber, width: 2),
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cityModel.city,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: kFontFamilyNormal),
                  ),
                ),
                Flexible(
                  child: AutoSizeText(uvModel.currentUV.toInt().toString(),
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                ),
                Text("Current UV Index",
                    style: TextStyle(fontFamily: kFontFamilyBold)),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(uvIndexDescription(uvModel),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: kFontFamilyNormal)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                          height: 160,
                          child: UVChart(
                            sunrise: uvModel.sunrise,
                            sunset: uvModel.sunset,
                            sunriseData: sunrise,
                            sunsetData: sunset,
                            maxUV: uvModel.maxUV,
                            uvMaxHour: maxUVHour ?? uvModel.maxUVHour,
                          )),
                      Align(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          "Max UV: " + uvModel.maxUV.toStringAsFixed(2),
                          style: TextStyle(fontFamily: kFontFamilyBold),
                        ),
                      )),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child:
                          Text("Sunrise: " + newFormat.format(uvModel.sunrise),
                              style: TextStyle(
                                fontFamily: kFontFamilyNormal,
                              )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text("Sunset: " + newFormat.format(uvModel.sunset),
                          style: TextStyle(
                            fontFamily: kFontFamilyNormal,
                          )),
                    )
                  ],
                ),
                Container(
                  child: Card(
                    color: Colors.amber[50],
                    elevation: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, right: 8.0, bottom: 4.0),
                          child: Text(
                            "Recommendations",
                            style: TextStyle(
                                fontFamily: kFontFamilyBold, fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Follow these suggestions to keep your skin protected.",
                            style: TextStyle(
                                fontFamily: kFontFamilyNormal, fontSize: 10),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "General",
                            style: TextStyle(
                                color: Colors.amber,
                                fontFamily: kFontFamilyBold,
                                fontSize: 16),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, right: 8.0),
                            child: AutoSizeText(
                                mainRecommendation(skinColorModel, uvModel),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: kFontFamilyBold, fontSize: 14)),
                          ),
                        ),
                        if (uvModel.currentUV >= 1.0)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "SPF",
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontFamily: kFontFamilyBold,
                                  fontSize: 16),
                            ),
                          ),
                        if (uvModel.currentUV >= 1.0)
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, left: 8.0, right: 8.0),
                              child: AutoSizeText(
                                  spfRecommendation(skinColorModel),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: kFontFamilyBold,
                                  )),
                            ),
                          ),
                        if (uvModel.currentUV >= 1.0)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "*More time spent in the sun means that you will need more applications of sunscreen. 1 oz of the applied sunscreen on an adult body is the minimum requirement to attain the SPF outlined on the package.",
                              style: TextStyle(
                                  fontFamily: kFontFamilyNormal, fontSize: 10),
                            ),
                          ),
                        if (skinColorModel.hoursOutdoors != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Sunscreen",
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontFamily: kFontFamilyBold,
                                  fontSize: 16),
                            ),
                          ),
                        if (skinColorModel.hoursOutdoors != null)
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, left: 8.0, right: 8.0),
                              child: AutoSizeText(sunscreenRec(skinColorModel),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: kFontFamilyBold,
                                  )),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "*Thick, pastier sunscreens are more likely to cause acne by clogging pores, so be aware of the sunscreen consistency.",
                            style: TextStyle(
                                fontFamily: kFontFamilyNormal, fontSize: 10),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Clothing",
                            style: TextStyle(
                                color: Colors.amber,
                                fontFamily: kFontFamilyBold,
                                fontSize: 16),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8.0, left: 8.0, right: 8.0),
                            child: AutoSizeText(
                                clothingRec(uvModel.currentUV.toInt()),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: kFontFamilyBold,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "*Skin can still burn through very lightweight clothing materials.",
                            style: TextStyle(
                                fontFamily: kFontFamilyNormal, fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: -10,
            right: 30,
            child: ButtonTheme(
              padding: EdgeInsets.zero,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.cancel),
                  onPressed: () => cityModel.updateCity(null, null, null)),
            ))
      ],
    );
  }

  uvIndexDescription(UVModel uvModel) {
    switch (uvModel.currentUV.toInt()) {
      case 0:
        return UVIndexDescriptions.zero;
        break;
      case 1:
        return UVIndexDescriptions.one;
        break;
      case 2:
        return UVIndexDescriptions.two;
        break;
      case 3:
        return UVIndexDescriptions.three;
        break;
      case 4:
        return UVIndexDescriptions.four;
        break;
      case 5:
        return UVIndexDescriptions.five;
        break;
      case 6:
        return UVIndexDescriptions.six;
        break;
      case 7:
        return UVIndexDescriptions.seven;
        break;
      case 8:
        return UVIndexDescriptions.eight;
        break;
      case 9:
        return UVIndexDescriptions.nine;
        break;
      case 10:
        return UVIndexDescriptions.ten;
        break;
      case 11:
        return UVIndexDescriptions.eleven;
        break;
    }
  }

  sunscreenRec(SkinColorModel skinColorModel) {
    switch (skinColorModel.skinTypeIndex) {
      case 0:
        return "Non-comedogenic lotions or creams";
        break;
      case 1:
        return "Non-comedogenic lotions";
        break;
      case 2:
        return "Creams or lotions, avoid sprays and gels";
        break;
      case 3:
        return "Light-weight, noncomedogenic, lotion formulation";
        break;
      case 4:
        return "Lotions, creams or sprays";
        break;
    }
  }

  mainRecommendation(SkinColorModel skinColorModel, UVModel uvModel) {
    int currentUV = uvModel.currentUV.toInt();

    switch (skinColorModel.skinColorIndex) {
      case 0:
        return paleMainRec(currentUV);
        break;
      case 1:
        return paleMainRec(currentUV);
        break;

      case 2:
        return mediumMainRec(currentUV);
        break;
      case 3:
        return oliveMainRec(currentUV);
        break;
      case 4:
        return darkMainRec(currentUV);
        break;
      default:
    }
  }

  paleMainRec(int currentUV) {
    String rec = '';

    for (int i = 0; i <= currentUV; i++) {
      if (paleRecString(i - 1) != paleRecString(i))
        rec += (" " + paleRecString(i));
    }
    return rec;
  }

  paleRecString(uv) {
    switch (uv) {
      case 0:
        return FairRecommendations.zero;
        break;
      case 1:
        return FairRecommendations.one;
        break;
      case 2:
        return FairRecommendations.two;
        break;
      case 3:
        return FairRecommendations.three;
        break;
      case 4:
        return FairRecommendations.four;
        break;
      case 5:
        return FairRecommendations.five;
        break;
      case 6:
        return FairRecommendations.six;
        break;
      case 7:
        return FairRecommendations.seven;
        break;
      case 8:
        return FairRecommendations.eight;
        break;
      case 9:
        return FairRecommendations.nine;
        break;
      case 10:
        return FairRecommendations.ten;
        break;
      case 11:
        return FairRecommendations.ten;
        break;
    }
  }

  clothingRec(int currentUV) {
    switch (currentUV) {
      case 0:
        return UVClothingRecommendations.zero;
        break;
      case 1:
        return UVClothingRecommendations.one;
        break;

      case 2:
        return UVClothingRecommendations.two;
        break;
      case 3:
        return UVClothingRecommendations.three;
        break;
      case 4:
        return UVClothingRecommendations.four;
        break;
      case 5:
        return UVClothingRecommendations.five;
        break;
      case 6:
        return UVClothingRecommendations.six;
        break;

      case 7:
        return UVClothingRecommendations.seven;
        break;
      case 8:
        return UVClothingRecommendations.eight;
        break;
      case 9:
        return UVClothingRecommendations.nine;
        break;
      case 10:
        return UVClothingRecommendations.ten;
        break;
      case 11:
        return UVClothingRecommendations.eleven;
        break;
      default:
        return UVClothingRecommendations.eleven;
        break;
    }
  }

  darkMainRec(int currentUV) {
    String rec = '';

    for (int i = 0; i <= currentUV; i++) {
      if (darkRecString(i - 1) != darkRecString(i))
        rec += (" " + darkRecString(i));
    }
    return rec;
  }

  darkRecString(int currentUV) {
    switch (currentUV) {
      case 0:
        return DarkRecommendations.zero;
        break;
      case 1:
        return DarkRecommendations.one;
        break;
      case 2:
        return DarkRecommendations.two;
        break;
      case 3:
        return DarkRecommendations.three;
        break;
      case 4:
        return DarkRecommendations.four;
        break;
      case 5:
        return DarkRecommendations.five;
        break;
      case 6:
        return DarkRecommendations.six;
        break;
      case 7:
        return DarkRecommendations.seven;
        break;
      case 8:
        return DarkRecommendations.eight;
        break;
      case 9:
        return DarkRecommendations.nine;
        break;
      case 10:
        return DarkRecommendations.ten;
        break;
      case 11:
        return DarkRecommendations.eleven;
        break;
    }
  }

  mediumMainRec(int currentUV) {
    String rec = '';

    for (int i = 0; i <= currentUV; i++) {
      if (mediumRecString(i - 1) != mediumRecString(i))
        rec += (" " + mediumRecString(i));
    }
    return rec;
  }

  mediumRecString(int currentUV) {
    switch (currentUV) {
      case 0:
        return MediumRecommendations.zero;
        break;
      case 1:
        return MediumRecommendations.one;
        break;

      case 2:
        return MediumRecommendations.two;
        break;
      case 3:
        return MediumRecommendations.three;
        break;
      case 4:
        return MediumRecommendations.four;
        break;
      case 5:
        return MediumRecommendations.five;
        break;
      case 6:
        return MediumRecommendations.six;
        break;
      case 7:
        return MediumRecommendations.seven;
        break;
      case 8:
        return MediumRecommendations.eight;
        break;
      case 9:
        return MediumRecommendations.nine;
        break;
      case 10:
        return MediumRecommendations.ten;
        break;
      case 10:
        return MediumRecommendations.eleven;
        break;
    }
  }

  oliveMainRec(int currentUV) {
    String rec = '';

    for (int i = 0; i <= currentUV; i++) {
      if (oliveRecString(i - 1) != oliveRecString(i))
        rec += (" " + oliveRecString(i));
    }
    return rec;
  }

  oliveRecString(int currentUV) {
    switch (currentUV) {
      case 0:
        return OliveRecommendations.zero;
        break;
      case 1:
        return OliveRecommendations.one;
        break;
      case 2:
        return OliveRecommendations.twoThroughFour;
        break;
      case 3:
        return OliveRecommendations.twoThroughFour;
        break;
      case 4:
        return OliveRecommendations.twoThroughFour;
        break;
      case 5:
        return OliveRecommendations.five;
        break;
      case 6:
        return OliveRecommendations.six;
        break;
      case 7:
        return OliveRecommendations.seven;
        break;
      case 8:
        return OliveRecommendations.eight;
        break;
      case 9:
        return OliveRecommendations.nine;
        break;
      case 10:
        return OliveRecommendations.ten;
        break;
      case 11:
        return OliveRecommendations.eleven;
        break;
    }
  }

  spfRecommendation(SkinColorModel skinColorModel) {
    switch (skinColorModel.skinColorIndex) {
      case 0:
        if (skinColorModel.hoursOutdoors == 2 ||
            skinColorModel.hoursOutdoors == 3) return "50+";
        if (skinColorModel.hoursOutdoors == 4 ||
            skinColorModel.hoursOutdoors == 5) return "50-100";
        return "30";
        break;
      case 1:
        if (skinColorModel.hoursOutdoors == 2 ||
            skinColorModel.hoursOutdoors == 3) return "50+";
        if (skinColorModel.hoursOutdoors == 4 ||
            skinColorModel.hoursOutdoors == 5) return "50-100";
        return "30+";
        break;
      case 2:
        if (skinColorModel.hoursOutdoors == 1 ||
            skinColorModel.hoursOutdoors == 2) return "30";
        if (skinColorModel.hoursOutdoors > 3) return "50+";
        return "30+";
        break;
      case 3:
        if (skinColorModel.hoursOutdoors == 1 ||
            skinColorModel.hoursOutdoors == 2) return "30";
        if (skinColorModel.hoursOutdoors == 3) return "30-50";
        if (skinColorModel.hoursOutdoors == 4) return "50+";
        if (skinColorModel.hoursOutdoors == 5) return "50+";
        break;
      case 4:
        if (skinColorModel.hoursOutdoors == 1 ||
            skinColorModel.hoursOutdoors == 2) return "30";
        if (skinColorModel.hoursOutdoors == 3) return "30-50";
        if (skinColorModel.hoursOutdoors == 4) return "30-50";
        if (skinColorModel.hoursOutdoors == 5) return "50+";

        break;
      default:
    }
  }
}
