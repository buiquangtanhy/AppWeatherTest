import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/WeatherEvent.dart';
import 'package:weather_app/WeatherState.dart';
import 'package:weather_app/data_service.dart';
import 'package:weather_app/models.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  // final WeatherResponse weatherResponse;
  DataService dataService;

  WeatherBloc({required this.dataService}) : super(WeatherStateInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is SearchEventRequested) {
      yield WeatherStateLoading();
      try {
        final WeatherResponse weatherResponse =
            await dataService.getWeather(event.city);
        final WeatherResponseDays weatherResponseDays =
            await dataService.getWeatherDays(
                weatherResponse.coordInfo.lat.toString(),
                weatherResponse.coordInfo.lon.toString());
        yield WeatherStateLoaded(
            weatherResponse: weatherResponse,
            weatherResponseDays: weatherResponseDays);
      } catch (exception) {
        yield WeatherStateError();
      }
    } else if (event is SearchEventRefresh) {
      try {
        final WeatherResponse weatherResponse =
            await dataService.getWeather(event.city);
        final WeatherResponseDays weatherResponseDays =
            await dataService.getWeatherDays(
                weatherResponse.coordInfo.lat.toString(),
                weatherResponse.coordInfo.lon.toString());

        yield WeatherStateLoaded(
            weatherResponse: weatherResponse,
            weatherResponseDays: weatherResponseDays);
      } catch (exception) {
        yield WeatherStateError();
      }
    }
  }
}
