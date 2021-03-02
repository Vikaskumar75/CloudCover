class WeatherModel {
  final double longitude;
  final double latitude;
  final String description;
  final double temperature;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final String timeZone;

  WeatherModel({
    this.longitude,
    this.latitude,
    this.description,
    this.temperature,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.timeZone,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      longitude: json['lon'],
      latitude: json['lat'],
      description: json['current']['weather'][0]['description'],
      temperature: json['current']['temp'],
      pressure: json['current']['pressure'],
      humidity: json['current']['humidity'],
      windSpeed: json['current']['wind_speed'],
      timeZone: json['timezone'],
    );
  }
}
