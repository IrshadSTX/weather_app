class WeatherData {
  final String? name;
  final String? condition;
  final String? country;
  final String? tempC;
  final String? tempF;
  final String? humidity;
  final String? windSpeed;
  final String? imageUrl;

  WeatherData(
      {this.name,
      this.condition,
      this.country,
      this.tempC,
      this.tempF,
      this.humidity,
      this.imageUrl,
      this.windSpeed});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      name: json['location']['name'].toString(),
      condition: json['current']['condition']['text'].toString(),
      country: json['location']['country'].toString(),
      tempC: json['current']['temp_c'].toString(),
      tempF: json['current']['temp_f'].toString(),
      humidity: json['current']['humidity'].toString(),
      imageUrl: json['current']['condition']['icon'].toString(),
      windSpeed: json['current']['wind_kph'].toString(),
    );
  }
}
