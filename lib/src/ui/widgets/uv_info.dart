import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skintel/src/data/city_model.dart';
import 'package:skintel/src/data/uv_model.dart';
import 'package:skintel/src/ui/widgets/uv_chart.dart';

class UVInfo extends StatelessWidget {
  UVInfo({Key key}) : super(key: key);

  final newFormat = DateFormat("jm");

  @override
  Widget build(BuildContext context) {
    UVModel uvModel = Provider.of<UVModel>(context);
    CityModel cityModel = Provider.of<CityModel>(context);
    UVData sunrise = UVData(0, 0);
    UVData sunset =
        UVData(uvModel.sunset.difference(uvModel.sunrise).inHours, 0);
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          height: MediaQuery.of(context).size.height * .6,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cityModel.city,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Text(uvModel.currentUV.toStringAsFixed(0),
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
              Text("Current UV Index"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                        height: 150,
                        child: UVChart(
                          sunrise: uvModel.sunrise,
                          sunset: uvModel.sunset,
                          sunriseData: sunrise,
                          sunsetData: sunset,
                          maxUV: uvModel.maxUV,
                          uvMaxHour: uvModel.maxUVHour,
                        )),
                    Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                              "Max UV: " + uvModel.maxUV.toStringAsFixed(2)),
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
                        Text("Sunrise: " + newFormat.format(uvModel.sunrise)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text("Sunset: " + newFormat.format(uvModel.sunset)),
                  )
                ],
              )
            ],
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
}
