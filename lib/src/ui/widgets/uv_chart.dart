/// Dart imports
import 'dart:async';

/// Package import
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

class UVChart extends StatefulWidget {
  const UVChart({Key key, this.sunrise, this.sunset, this.maxUV})
      : super(key: key);
  final UVData sunrise;
  final UVData sunset;
  final double maxUV;

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
          majorGridLines: MajorGridLines(width: 0),
          maximum: 24,
        ),
        primaryYAxis: NumericAxis(
            majorTickLines: MajorTickLines(color: Colors.amber),
            axisLine: AxisLine(width: 0),
            minimum: 0,
            maximum: 15),
        series: getDefaultSplineSeries());
  }

  List<SplineSeries<UVData, int>> getDefaultSplineSeries() {
    List<UVData> _chartData = [
      widget.sunrise,
      UVData(12, widget.maxUV),
      widget.sunset
    ];
    return <SplineSeries<UVData, int>>[
      SplineSeries<UVData, int>(
          dataSource: _chartData,
          xValueMapper: (UVData uvData, _) => uvData.hour,
          yValueMapper: (UVData uvData, _) => uvData.uv,
          markerSettings: MarkerSettings(isVisible: true))
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
