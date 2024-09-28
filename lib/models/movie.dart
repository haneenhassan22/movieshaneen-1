class Movie {
  String? title;
  String? backDropPath;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  double voteAverage;
  bool? isAdedd;
  List<dynamic>? genreIds;
  int id;

  Movie({
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.id,
    required this.genreIds,
    this.isAdedd,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json["title"] ?? 'mazen',
      backDropPath: json["backdrop_path"] ?? 'shabaan',
      originalTitle: json["original_title"] ?? 'ali',
      overview: json["overview"] ?? 'talaat',
      posterPath: json["poster_path"] ?? 'hello',
      releaseDate: json["release_date"] ?? 'ff',
      voteAverage: json["vote_average"].toDouble(),
      id: json["id"],
      genreIds: json["genre_ids"] ?? [18],
      isAdedd: false,
    );
  }
}
