class Config {
  static String apiKey = '52c752b31bfe181e2fa03ee3fb20eecd';
  static String baseUrl = 'https://api.themoviedb.org/3/movie';
  static String popularUrl = '$baseUrl/popular?api_key=$apiKey&page=1';
  static String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
}