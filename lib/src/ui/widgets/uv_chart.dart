/// Dart imports
import 'dart:async';

/// Package import
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

class UVChart extends StatefulWidget {
  const UVChart(
      {Key key,
      this.sunrise,
      this.sunset,
      this.maxUV,
      this.uvMaxHour,
      this.sunriseData,
      this.sunsetData})
      : super(key: key);

  final DateTime sunrise;
  final DateTime sunset;
  final UVData sunriseData;
  final UVData sunsetData;
  final double maxUV;
  final int uvMaxHour;

  @override
  _UVChartState createState() => _UVChartState();
}

class _UVChartState extends State<UVChart> {
  _UVChartState();

  Timer timer;
  @override
  Widget build(BuildContext context) {
    timer = Timer(const Duration(seconds: 2), () {});
    setState(() {});
    return getAnimationSplineChart();
  }

  SfCartesianChart getAnimationSplineChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: NumericAxis(
          isVisible: false,
          minimum: widget.sunriseData.hour.toDouble(),
          maximum: widget.sunsetData.hour.toDouble(),
        ),
        primaryYAxis: NumericAxis(
          maximumLabels: 2,
          axisLine: AxisLine(color: Colors.transparent),
          majorTickLines: MajorTickLines(color: Colors.amber),
          isVisible: true,
          minimum: 0,
          maximum: 15,
        ),
        series: getDefaultSplineSeries());
  }

  List<SplineAreaSeries<UVData, int>> getDefaultSplineSeries() {
    List<UVData> _chartData = [
      widget.sunriseData,
      UVData(widget.uvMaxHour, widget.maxUV),
      widget.sunsetData
    ];
    return <SplineAreaSeries<UVData, int>>[
      SplineAreaSeries<UVData, int>(
        borderWidth: 3,
        borderColor: Colors.amber,
        borderDrawMode: BorderDrawMode.all,
        markerSettings: MarkerSettings(isVisible: true, color: Colors.amber),
        color: Color.fromRGBO(253, 216, 65, 1),
        dataSource: _chartData,
        xValueMapper: (UVData uvData, _) => uvData.hour,
        yValueMapper: (UVData uvData, _) => uvData.uv,
      )
    ];
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}

class UVData {
  UVData(this.hour, this.uv);
  final int hour;
  final double uv;
}
