import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/constants.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/view/widgets/container_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Services? obj = Services();

  @override
  void initState() {
    weatherData = Services().fetchWeatherData(city: 'malappuram');
    super.initState();
  }

  DateTime currentTime = DateTime.now();
  Future<WeatherData?>? weatherData;
  final DateFormat standardDate = DateFormat('EEEE,d MMMM');
  @override
  Widget build(BuildContext context) {
    TextEditingController cityController = TextEditingController();

    String formattedTime = standardDate.format(currentTime);

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: SystemUiOverlay.values);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.blue.shade200,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  CupertinoTextField(
                    suffix: IconButton(
                        onPressed: () async {
                          final city = cityController;
                          setState(() {
                            weatherData =
                                Services().fetchWeatherData(city: city.text);
                          });
                        },
                        icon: const Icon(Icons.done)),
                    placeholder: 'Location',
                    controller: cityController,
                  ),
                  FutureBuilder<WeatherData?>(
                      future: weatherData,
                      builder: (context, snapShot) {
                        if (snapShot.hasData) {
                          final result = snapShot.data!;
                          final withSpaces = result.condition!;
                          log(withSpaces);
                          final imageUrl =
                              withSpaces.replaceAll(' ', '').toLowerCase();

                          return Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${result.name}',
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(formattedTime,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, bottom: 10),
                                width: size.width * .9,
                                height: size.height * .25,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade200,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 25),
                                        blurRadius: 8,
                                        spreadRadius: -10,
                                        color: Colors.blue.shade100,
                                      ),
                                    ]),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                        top: -40,
                                        left: 20,
                                        child: Image.asset(
                                          'assets/images/$imageUrl.png',
                                          width: 150,
                                        )),
                                    Positioned(
                                        bottom: 10,
                                        left: 30,
                                        child: Text(
                                          result.condition!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white54,
                                              fontSize: 26),
                                        )),
                                    Positioned(
                                        right: 30,
                                        bottom: 40,
                                        child: Text(
                                          '${result.tempC!.split('.')[0]}°',
                                          style: const TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 80),
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ContainerWidget(
                                      text: 'Wind Speed',
                                      value: '${result.windSpeed}',
                                      unit: 'km/hr',
                                      imageUrl: 'windspeed.png'),
                                  ContainerWidget(
                                      text: 'Humidity',
                                      value: '${result.humidity}',
                                      unit: '',
                                      imageUrl: 'humidity.png'),
                                  ContainerWidget(
                                      text: 'Temperature',
                                      value: '${result.tempF!.split('.')[0]}',
                                      unit: 'F',
                                      imageUrl: 'temperature.png'),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: const [
                              //     Text(
                              //       'Today',
                              //       style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 20),
                              //     ),
                              //     Text(
                              //       'Next 7 Days',
                              //       style: TextStyle(
                              //           color: Colors.blueGrey,
                              //           fontWeight: FontWeight.w600),
                              //     )
                              //   ],
                              // ),
                              // kHeight,
                              // SizedBox(
                              //   height: size.height * .2,
                              //   child: ListView.separated(
                              //     scrollDirection: Axis.horizontal,
                              //     separatorBuilder: (context, index) => kWidth,
                              //     itemBuilder: (context, index) {
                              //       return Container(
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 20),
                              //         margin: const EdgeInsets.only(
                              //             right: 20, top: 10, bottom: 10),
                              //         width: 80,
                              //         decoration: const BoxDecoration(
                              //             color: Colors.white,
                              //             borderRadius: BorderRadius.all(
                              //               Radius.circular(10),
                              //             ),
                              //             boxShadow: [
                              //               BoxShadow(
                              //                 offset: Offset(0, 1),
                              //                 blurRadius: 5,
                              //                 color: Colors.grey,
                              //               ),
                              //             ]),
                              //       );
                              //     },
                              //     itemCount: 7,
                              //   ),
                              // ),
                            ],
                          );
                        } else if (snapShot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const Center(
                            child: Text(
                                'Error with the place  Retry with new place'),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
