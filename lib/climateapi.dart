import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Coord {
  final double longitude;
  final double latitude;

  Coord({this.latitude, this.longitude});
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({this.id, this.description, this.icon, this.main});
}

class Main {
  
  final double temp;
  final int pressure;
  final int humidity;
  final double tempmin;
  final double tempmax;

  Main({this.humidity, this.pressure, this.temp, this.tempmax, this.tempmin});
}

class Wind {
  final double speed;
  final int degree;

  Wind({this.speed, this.degree});
}

class Cloud {
  final int all;

  Cloud({this.all});
}

class Sys {
  final int type;
  final int id;
  final double message;
  final String country;
  final int sunrise;
  final int sunset;

  Sys(
      {this.id,
      this.message,
      this.country,
      this.sunrise,
      this.sunset,
      this.type});
}

class Weatherclass {
  final Sys sys;
  final Weather weather;
  final Main main;
  final Cloud cloud;
  final Wind wind;
  final Coord coord;
  final int id;
  final int timezone;
  final String name;
  final int cod;
  final int visibility;
  final String base;

  Weatherclass(
      {this.id,
      this.name,
      this.base,
      this.cloud,
      this.cod,
      this.coord,
      this.main,
      this.sys,
      this.timezone,
      this.visibility,
      this.weather,
      this.wind});

  factory Weatherclass.fromJson(Map<String, dynamic> json) {
    Coord coord = Coord(
        longitude: json['coord']['lat'],
        latitude: json['coord']['lon']);
    Main main = Main(
        humidity: json['main']['humidity'],
        pressure: json['main']['pressure'],
        temp: json['main']['temp'],
        tempmax: json['main']['temp_max'],
        tempmin: json['main']['temp_min']);
    Wind wind = Wind(
        degree: json['wind']['deg'],
        speed: json['wind']['speed']);
    Weather weather = Weather(
        main: json['weather'][0]['main'],
        id: json['weather'][0]['id'],
        icon: json['weather'][0]['icon'],
        description: json['weather'][0]['description']);
    return Weatherclass(coord: coord, main: main, wind: wind, weather: weather);
  }
}
//<String, dynamic>