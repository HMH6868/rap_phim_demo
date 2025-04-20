class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final double rating;
  final List<String> genres;
  final String duration;

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.rating,
    required this.genres,
    required this.duration,
  });
}
