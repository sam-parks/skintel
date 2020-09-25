import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skintel/config.dart';
import 'package:skintel/src/data/city_model.dart';
import 'package:skintel/src/data/uv_model.dart';
import 'package:skintel/src/locator.dart';
import 'package:skintel/src/services/uv_service.dart';
import 'package:skintel/src/ui/style.dart';
import 'package:skintel/src/ui/widgets/uv_info.dart';

class UVPage extends StatefulWidget {
  UVPage({Key key}) : super(key: key);

  @override
  _UVPageState createState() => _UVPageState();
}

class _UVPageState extends State<UVPage> {
  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: locator.get<Config>().placesAPIKey);
  UVService _uvService = locator.get();
  @override
  Widget build(BuildContext context) {
    CityModel _cityModel = Provider.of<CityModel>(context);
    UVModel _uvModel = Provider.of<UVModel>(context);
    return Stack(
      children: [
        Container(
          color: (_uvModel.currentUV == null)
              ? AppColors.sky_blue
              : generateBackgroundColor(_uvModel.currentUV),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 30, top: 20, bottom: 20),
                  child: _uvModel.currentUV == 0.0
                      ? SvgPicture.asset('assets/images/moon.svg', height: 100)
                      : Image.asset(
                          'assets/images/sun.png',
                          height: 100,
                        ),
                ),
              ),
              Column(
                children: [
                  Text(
                    'Location',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: kFontFamilyBold,
                        fontSize: 40,
                        color: _uvModel.currentUV == 0.0
                            ? Colors.white
                            : Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 120),
                    child: Text(
                      "Plase type in your current city.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: kFontFamilyNormal,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Stack(
                children: [
                  (_uvModel.currentUV == null)
                      ? SvgPicture.asset(
                          'assets/images/park.svg',
                          alignment: Alignment.bottomCenter,
                        )
                      : generateBackgroundPicture(_uvModel.currentUV),
                  Positioned(
                    top: -15,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 32,
                            right: 32,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              _selectCity(_cityModel, _uvModel);
                            },
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: _uvModel.currentUV == 0.0
                                            ? Colors.white
                                            : Colors.black,
                                        width: 1.2)),
                                hintStyle: _uvModel.currentUV == 0.0
                                    ? TextStyle(
                                        color: Colors.white,
                                        fontFamily: kFontFamilyNormal,
                                      )
                                    : TextStyle(
                                        color: Colors.grey,
                                        fontFamily: kFontFamilyNormal,
                                      ),
                                hintText: "Enter a City...",
                                contentPadding: const EdgeInsets.only(left: 10),
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
        if (_cityModel.city != null && _uvModel.currentUV != null)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * .1),
              child: UVInfo(),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20),
          child: Image.asset(
            'assets/images/skintel_white.png',
            height: 60,
          ),
        ),
      ],
    );
  }

  _selectCity(CityModel cityModel, UVModel uvModel) async {
    Prediction prediction = await PlacesAutocomplete.show(
        context: context,
        apiKey: locator.get<Config>().placesAPIKey,
        onError: (PlacesAutocompleteResponse response) =>
            print(response.errorMessage),
        types: ['(cities)'],
        mode: Mode.overlay,
        radius: 10000000);
    if (prediction != null) {
      PlacesDetailsResponse placesDetails =
          await _places.getDetailsByPlaceId(prediction.placeId);

      Location location = placesDetails.result.geometry.location;
      cityModel.updateCity(placesDetails.result.name, location.lat.toString(),
          location.lng.toString());

      dynamic result = await _uvService.getUVFromLocation(
          cityModel.latCity, cityModel.lngCity);

      if (result['uv'] == 0) {
        result['uv'] = 0.0;
      }
      if (result['uv_max'] == 0) {
        result['uv_max'] = 0.0;
      }
      uvModel.updateUVData(
        result['uv'],
        result['uv_max'],
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
            .parse(result['sun_info']['sun_times']['sunrise'], true)
            .toLocal(),
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
            .parse(result['sun_info']['sun_times']['sunset'], true)
            .toLocal(),
        DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
            .parse(result['uv_max_time'], true)
            .toLocal()
            .hour,
      );
    }
  }

  generateBackgroundColor(double currentUV) {
    if (currentUV == 0.0) {
      return AppColors.night;
    } else if (currentUV > 6.0) {
      return AppColors.desert;
    }
    return AppColors.sky_blue;
  }

  generateBackgroundPicture(double currentUV) {
    if (currentUV == 0.0) {
      return SvgPicture.asset(
        'assets/images/night_scene.svg',
        alignment: Alignment.bottomCenter,
      );
    } else if (currentUV > 6.0) {
      return SvgPicture.asset(
        'assets/images/desert_scene.svg',
        alignment: Alignment.bottomCenter,
      );
    }
    return SvgPicture.asset(
      'assets/images/park.svg',
      alignment: Alignment.bottomCenter,
    );
  }
}
