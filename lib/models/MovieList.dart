class MovieList {
  double popularity;
  double voteCount;
  bool video;
  String posterPath;
  double id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  MovieList(
      {this.popularity,
      this.voteCount,
      this.video,
      this.posterPath,
      this.id,
      this.adult,
      this.backdropPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.title,
      this.voteAverage,
      this.overview,
      this.releaseDate});

  MovieList.fromJson(Map<String, dynamic> json) {
    popularity =
        json['popularity'] == null ? 0.0 : json['popularity'].toDouble();
    voteCount =
        json['vote_count'] == null ? 0.0 : json['vote_count'].toDouble();
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'] == null ? 0.0 : json['id'].toDouble();
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage =
        json['vote_average'] == null ? 0.0 : json['vote_average'].toDouble();
    overview = json['overview'];
    releaseDate = json['release_date'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['vote_count'] = this.voteCount;
    data['video'] = this.video;
    data['poster_path'] = this.posterPath;
    data['id'] = this.id;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }
}
