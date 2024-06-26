import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/weather_app_palette.dart';
import 'package:weather_app/core/widgets/app_bar_widget.dart';

class WeatherAppLayout extends StatelessWidget {
  WeatherAppLayout({
    required this.appBarTitle,
    required this.child,
    super.key,
  });

  final String appBarTitle;
  final Widget child;

  final double _gradientHeight = 160;
  final double _gradientHeightRatio = 0.4;
  final double _bottomHeight = 50;

  final Color _startGradientColor = Colors.transparent;
  final Color _endGradientColor = Colors.black.withOpacity(0.6);

  final LinearGradient _linearGradientLayout = const LinearGradient(
    colors: <Color>[
      Colors.black,
      WeatherAppPalette.mine,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: WeatherAppPalette.mine,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: _gradientHeight,
            decoration: BoxDecoration(
              gradient: _linearGradientLayout,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: <Widget>[
              Container(
                height:
                    MediaQuery.sizeOf(context).height * _gradientHeightRatio,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      _endGradientColor,
                      _startGradientColor,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                height: _bottomHeight,
                width: double.infinity,
                color: _endGradientColor,
              ),
            ],
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBarWidget(
            appBarTitle: appBarTitle.toUpperCase(),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: child,
          ),
        ),
      ],
    );
  }
}
