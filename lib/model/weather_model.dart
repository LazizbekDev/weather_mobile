class CityInfo {
  final String name;
  final String url;
  final String? temperature;

  CityInfo({required this.name, required this.url, required this.temperature});

  @override
  String toString() {
    return 'CityInfo{name: $name, url: $url: Temperature: $temperature}';
  }
}

class CountryInfo {
  final String name;
  final String url;

  CountryInfo({required this.name, required this.url});

  @override
  String toString() {
    return 'CountryInfo{name: $name, url: $url}';
  }
}

class Weather {
  final String url;
  final String cityName;
  final String? temperature;
  final String? countriesList;
  final String? countryTemperature;

  Weather({
    required this.url,
    required this.cityName,
    required this.temperature,
    required this.countriesList,
    required this.countryTemperature,
  });
}
