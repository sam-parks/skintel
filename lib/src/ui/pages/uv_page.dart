import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:skintel/config.dart';
import 'package:skintel/src/data/city_model.dart';
import 'package:skintel/src/locator.dart';

class UVPage extends StatefulWidget {
  UVPage({Key key}) : super(key: key);

  @override
  _UVPageState createState() => _UVPageState();
}

class _UVPageState extends State<UVPage> {
  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: locator.get<Config>().placesAPIKey);
  @override
  Widget build(BuildContext context) {
    CityModel _cityModel = Provider.of<CityModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_cityModel.city),
        Container(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Enter a City"),
                  onTap: () async {
                    _selectCity(_cityModel);
                  },
                ),
                Positioned(
                  right: 10,
                  top: 12,
                  child: Icon(Icons.map),
                )
              ],
            ),
          ),
        )),
      ],
    );
  }

  _selectCity(CityModel cityModel) async {
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
    }
  }
}
