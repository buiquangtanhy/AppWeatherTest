import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class SearchEventRequested extends WeatherEvent {
  final String city;

  const SearchEventRequested({required this.city});

  @override
  // TODO: implement props
  List<Object?> get props => [city];
}
class SearchEventRefresh extends WeatherEvent {
  final String city;

  const SearchEventRefresh({required this.city});

  @override
  // TODO: implement props
  List<Object?> get props => [city];
}