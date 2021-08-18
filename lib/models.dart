class WeatherInfo {
  late final String description;
  late final String icon;

  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}
class CoordInfo{
  final double lat;
  final double lon;
  CoordInfo({required this.lat,required this.lon});
  factory CoordInfo.fromJson(Map<String, dynamic> json){
    final lat = json['lat'];
    final lon = json['lon'];
    return CoordInfo(lat: lat, lon: lon);
  }
}
class TemperatureInfo {
  final double temperature;
  final double humidity;

  TemperatureInfo({required this.temperature, required this.humidity});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    final humidity = json['humidity'];
    return TemperatureInfo(temperature: temperature, humidity: humidity);
  }
}

class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  final CoordInfo coordInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse(
      {required this.cityName,
        required this.tempInfo,
        required this.weatherInfo,required this.coordInfo});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);
    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);
    final coordJson = json['coord'];
    final coordInfo = CoordInfo.fromJson(coordJson);

    return WeatherResponse(
        cityName: cityName, tempInfo: tempInfo, weatherInfo: weatherInfo,coordInfo: coordInfo);
  }
}

// Weather for 7 day
class City {
  final String cityName;

  City({required this.cityName});

  factory City.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    return City(cityName: cityName);
  }
}

class TempInfo {
  final double day;
  final double night;
  final double evening;
  final double morning;

  TempInfo(
      {required this.day,
        required this.morning,
        required this.evening,
        required this.night});

  factory TempInfo.fromJson(Map<String, dynamic> json) {
    final day = json['day'];
    final morning = json['morn'];
    final evening = json['eve'];
    final night = json['night'];
    return TempInfo(day: day, morning: morning, evening: evening, night: night);
  }
}

class Weather {
  final int id;
  final String description;
  final String main;
  final String icon;
  String get iconUrl {
    return 'https://openweathermap.org/img/wn/$icon@2x.png';
  }
  Weather(
      {required this.id,
        required this.description,
        required this.main,
        required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final description = json['description'];
    final main = json['main'];
    final icon = json['icon'];
    return Weather(id: id, description: description, main: main, icon: icon);
  }
}

class Weather1Day {
  final int day; // thoi gian cua du lieu duoc du bao
  final double humidity; // do am %
  final TempInfo teamInfo;
  final Weather weathers;
  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weathers.icon}@2x.png';
  }
  Weather1Day(
      {required this.day,
        required this.humidity,
        required this.teamInfo,
        required this.weathers});

  factory Weather1Day.fromJson(Map<String, dynamic> json) {
    final day = json['dt'];
    final humidity = json['humidity'];
    final teamInfoJson = json['temp'];
    final teamInfo = TempInfo.fromJson(teamInfoJson);
    final weathers = json['weather'][0];
    final _weather = Weather.fromJson(weathers);
    return Weather1Day(
        day: day, humidity: humidity, teamInfo: teamInfo, weathers: _weather);
  }
}

class WeatherResponseDays {
  final String timezone;
  final List<Weather1Day> weather1Day;

  WeatherResponseDays({required this.weather1Day,required this.timezone});

  factory WeatherResponseDays.fromJson(Map<String, dynamic> json) {
    final timezone = json['timezone'];
    final weather1Day = json['daily'] as List;
    final List<Weather1Day> _weatherDays =
    weather1Day.map((x) => Weather1Day.fromJson(x)).toList();
    return WeatherResponseDays(weather1Day: _weatherDays,timezone: timezone);
  }
}
