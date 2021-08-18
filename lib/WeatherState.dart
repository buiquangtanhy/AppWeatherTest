import 'package:equatable/equatable.dart';
import 'package:weather_app/models.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WeatherStateInitial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateLoaded extends WeatherState {
  final WeatherResponse weatherResponse;
  final WeatherResponseDays weatherResponseDays;
  WeatherStateLoaded({required this.weatherResponse, required this.weatherResponseDays});
}
class WeatherStateError extends WeatherState{
  final error;
  WeatherStateError({this.error});
}