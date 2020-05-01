import 'package:flutter/material.dart';
import 'util.dart' as util;
import 'climateapi.dart';
import 'package:intl/intl.dart';
import 'changecity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'my_flutter_app_icons.dart';

class Climate extends StatefulWidget {
  @override
  _ClimateState createState() => _ClimateState();
}

class _ClimateState extends State<Climate> {
  String _enteredcity;
  int num = 1;

  Future<Weatherclass> getWeather(String city, String appID) async {
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=${util.appid}';
    final response = await http.get(apiUrl);
    if (response.statusCode == 200) {

      return Weatherclass.fromJson(json.decode(response.body));
      //debugPrint(response.body);

    } else {
      throw Exception('failed to load json');
    }
  }
  void share(String Cityname, String temp, String humid, String pressure, String winspeed, BuildContext context){

    Share.share('$Cityname with as Temperature of $temp, Humidity of $humid, Pressure of $pressure and a Wind Speed of $winspeed');
  }


  Future _gotonextscreen(BuildContext context) async {
    Map result = await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new changecity();
    }));
    if (result != null && result.containsKey('enter')) {
      _enteredcity = result['enter'];
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('dare', _enteredcity);
  }

  DateTime now = DateTime.now();
  String formattedDate =
      DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());

  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    weatherclass = getWeather();
//  }

  void show() async {
    var data = await getWeather(util.appid, util.defaultcity);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
//        appBar: AppBar(
//          title: Text('Climatic'),
//          centerTitle: true,
//          backgroundColor: Colors.blue,
//        ),
            body: Stack(
              children: <Widget>[
                updateTempWidget(_enteredcity),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(icon: Icon(Icons.search, size: 35,color: Colors.grey,), onPressed: () => _gotonextscreen(context))
                )
              ],
            )
    ));
  }

//  Widget weatherimage(String city){
//    return new FutureBuilder<Weatherclass>(
//        future: getWeather(city == null ? util.defaultcity : city, util.appid),
//        builder: (context, AsyncSnapshot snapshot)
//    {
//
//    });
//  }

  Widget updateTempWidget(String city) {
    return new FutureBuilder<Weatherclass>(
      future: getWeather(city == null ? 'akure' : city, util.appid),
      builder: (context, AsyncSnapshot snapshot) {
        //util.defaultcity
        var back = new Map();
        back['Clouds'] = 'asset/cloudy.jpg';
        back['Clear'] = 'asset/cloud.jpg';
        back['Snow'] = 'asset/lit.jpg';
        back['Rain'] = 'asset/rain.jpg';
        back['Drizzle'] = 'asset/drizzle.jpg';
        back['Thunderstorm'] = 'asset/thunder.jpg';
        back[''] = '';
        back[''] = '';
        if (snapshot.hasData) {
          String bgimage;
          int i = 0;
          var temp = snapshot.data.main.temp;
          var humidity = snapshot.data.main.humidity;
          var press = snapshot.data.main.pressure;
          var windspeed = snapshot.data.wind.speed;
          String cloudtype = snapshot.data.weather.main;
          if(back.containsKey(cloudtype)){
            bgimage = back['$cloudtype'];
            return _weathermode(temp, humidity, press, windspeed, cloudtype, city, bgimage, context);
        }
        else{
          bgimage = null;
          return _weathermode(temp, humidity, press, windspeed, cloudtype, city, bgimage, context);
        }
        }
        else if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator()
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
            ),
          );
        }
      },
    );
  }
}

Widget _weathermode(var temp, var humi, var pressure, var windspeed,
    String cloudtype, String cityname, String bgimage, BuildContext context) {
  return ListView(
    scrollDirection: Axis.vertical,
    children: <Widget>[
      Stack(
        children: <Widget>[
          Image.asset('$bgimage', fit: BoxFit.fill, width: 600.0, height: MediaQuery.of(context).size.height,),
          Opacity(
            opacity: 0.4,
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.cloud_circle, size: 50, color: Colors.white,),
                        SizedBox(width: 10,),
                        Text('$cloudtype', style: TextStyle(fontSize: 30.0, color: Colors.white, fontFamily: 'Pipes'),),
                      ],
                    )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 10,),
                      Text('$temp °', style: TextStyle(fontSize: 70.0, color: Colors.white, fontFamily: 'Pipes'))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 10,),
                      Text('$cityname'.toUpperCase(), style: TextStyle(fontSize: 40.0, color: Colors.white, fontFamily: 'Pipes'))
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height -580,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        Row(

                          children: <Widget>[
                            SizedBox(width: 50.0,),
                            Column(
                              children: <Widget>[
                                Text('Humidity', style: TextStyle(color: Colors.white, fontFamily: 'Pipes')),
                                Icon(MyFlutterApp.water, color: Colors.white),
                                Text('$humi %', style: TextStyle(color: Colors.white, fontFamily: 'Pipes'))
                              ],
                            ),
                            SizedBox(width: 40.0,),
                            Column(
                                children: <Widget>[
                                  Text('Pressure', style: TextStyle(color: Colors.white, fontFamily: 'Pipes')),
                                  Icon(MyFlutterApp.cloud_wind, color: Colors.white,),
                                  Text('$pressure Pa',style: TextStyle(color: Colors.white, fontFamily: 'Pipes')),
                                ]
                            ),
                            SizedBox(width: 40.0,),
                            Column(
                              children: <Widget>[
                                Text('Wind Speed', style: TextStyle(color: Colors.white, fontFamily: 'Pipes')),
                                Icon(MyFlutterApp.wind_1, color: Colors.white),
                                Text('$windspeed Km/h', style: TextStyle(color: Colors.white, fontFamily: 'Pipes'),)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

TextStyle citystyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );
}

TextStyle tempstyle() {
  return TextStyle(
    color: Colors.orangeAccent,
    fontWeight: FontWeight.bold,
    fontSize: 40,
  );
}
