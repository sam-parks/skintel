import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:skintel/config.dart';
import 'package:skintel/src/data/city_model.dart';
import 'package:skintel/src/data/uv_model.dart';
import 'package:skintel/src/locator.dart';
import 'package:skintel/src/services/uv_service.dart';
import 'package:skintel/src/ui/widgets/uv_chart.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                'assets/images/sun.png',
                height: 100,
              ),
            )),
            GestureDetector(
              onTap: () async {
                _selectCity(_cityModel, _uvModel);
              },
              child: Column(
                children: [
                  Text(
                    'Location',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text(_cityModel.city),
                ],
              ),
            ),
          ],
        ),
        Container(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _uvModel.maxUV == null || _uvModel.currentUV == null
                ? Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          _selectCity(_cityModel, _uvModel);
                        },
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(hintText: "Enter a City"),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 12,
                        child: Icon(
                          Icons.map,
                          color: Colors.amber,
                        ),
                      )
                    ],
                  )
                : Container(
                    height: 130,
                    child: UVChart(
                        sunrise: UVData(0, 0),
                        sunset: UVData(0, 0),
                        maxUV: _uvModel.maxUV),
                  ),
          ),
        )),
        Spacer(),
        SvgPicture.asset(
          'assets/images/park.svg',
          alignment: Alignment.bottomCenter,
        )
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

      dynamic result =
          await _uvService.getUVFromLocation(cityModel.lat, cityModel.lng);
      uvModel.updateUVData(result['uv'], result['uv_max']);
    }
  }
}
