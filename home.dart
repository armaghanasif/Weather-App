import 'package:firstapp/util/txt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

import 'model/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;

  final cityName = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getWeather("Faisalabad");
  }

  getWeather(String city) {
    _wf.currentWeatherByCityName(city).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(color: Colors.blueGrey[900]),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),

              // Text(
              //   "Hello ${sharedpref.userName}",
              //   style: const TextStyle(
              //     color: Colors.white,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                width: MediaQuery.sizeOf(context).width,
                child: Form(
                  key: formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: TxtField(
                          label: "City Name",
                          controller: cityName,
                          forPass: false,
                          keyboard: TextInputType.name,
                          iconImg: Icons.location_city,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            getWeather(cityName.text);
                          }
                        },
                        child: const Text("Search"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _weatherIcon(),
              _locationHeader(),
              _currentTemp(),
              _dateTimeInfo(),
              _extraInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white),
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontSize: 35, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
            Text(
              "  ${DateFormat("d.m.y").format(now)}",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w400, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.50,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: GoogleFonts.lato(
        textStyle: const TextStyle(
            color: Colors.white, fontSize: 90, fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
        height: MediaQuery.sizeOf(context).height * 0.15,
        width: MediaQuery.sizeOf(context).width * 0.80,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        padding: const EdgeInsets.all(
          8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
