import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Bloc.dart';
import 'package:weather_app/WeatherEvent.dart';
import 'package:weather_app/WeatherState.dart';
import 'package:weather_app/data_service.dart';
import 'package:weather_app/models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  DataService dataService = DataService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        dataService: dataService,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.dataService})
      : super(key: key);
  final String title;
  final DataService dataService;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _tfCity = TextEditingController();
  late DataService dataService;
  final List<Weather> w1d = [
    Weather(id: 1, description: "description", main: "main", icon: "01d"),
    Weather(id: 1, description: "description", main: "main", icon: "01d"),
    Weather(id: 1, description: "description", main: "main", icon: "01d"),
    Weather(id: 1, description: "description", main: "main", icon: "01d"),
    Weather(id: 1, description: "description", main: "main", icon: "01d")
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataService = widget.dataService;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Counter')),
      body: BlocProvider(
        create: (context) => WeatherBloc(dataService: dataService)
          ..add(SearchEventRequested(city: 'Vietnam')),
        // _tfCity.text.trim()
        child: _ScreenWeather(context),
      ),
    );
  }

// =============================================

  _ScreenWeather(BuildContext context) {
    return Container(
      color: Colors.grey[350],
      child: Column(
        children: [
          BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
            if (state is WeatherStateInitial) {}
            if (state is WeatherStateLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherStateLoaded) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _SearchCity(context),
                    _buildWeatherNow(state.weatherResponse),
                    _buildWeatherDays(state.weatherResponseDays),
                  ],
                ),
              );
            }
            if (state is WeatherStateError) {
              return Text("Error 0");
            }
            return Text('Error 1');
          })
        ],
      ),
    );
  }

  _SearchCity(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        controller: _tfCity,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: 'Search City',
            icon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            hintStyle: TextStyle(color: Colors.grey)),
        onEditingComplete: () async {
          BlocProvider.of<WeatherBloc>(context)
              .add(SearchEventRequested(city: _tfCity.text.trim()));
        },
      ),
    );
  }

  _buildWeatherNow(WeatherResponse weatherResponse) {
    return Container(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(weatherResponse.iconUrl),
          Text(
            '${weatherResponse.tempInfo.temperature}°C  ',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          Text(
            'Humidity: ${weatherResponse.tempInfo.humidity}%',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          Text(weatherResponse.weatherInfo.description.toUpperCase()),
          Padding(padding: EdgeInsets.only(top: 5)),
          Text(weatherResponse.cityName.toUpperCase(), style: TextStyle(color: Colors.deepOrange, fontSize: 20),),
        ],
      ),
    );
  }

  _buildWeatherDays(WeatherResponseDays weatherResponseDays) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(top: 10),
      height: 210.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: weatherResponseDays.weather1Day.length,
          itemBuilder: (context, index) {
            return _buildWeatherDay(weatherResponseDays.weather1Day[index]);
          }),
    );
  }

  _buildWeatherDay(Weather1Day weather1day) {
    DateTime a = DateTime.fromMicrosecondsSinceEpoch(weather1day.day * 1000);
    int day = a.day;
    int month = a.month;
    int year = a.year;
    int b = a.weekday;

    return Container(
      width: 130,
      height: 210,
      padding: EdgeInsets.all(3),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.white, width: 3),
        ),
        color: Colors.lightGreenAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              '$day/$month/$year',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w900),
            ),
            Container(
              height: 80,
              width: 80,
              alignment: Alignment.center,
              child: Image.network(
                weather1day.iconUrl,
                fit: BoxFit.cover,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${weather1day.teamInfo.day}°C',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '${weather1day.humidity}%',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            Text(
              '${weather1day.weathers.description.toUpperCase()}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
