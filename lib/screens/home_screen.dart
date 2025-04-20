import 'package:flutter/material.dart';
import '../widgets/movie_card.dart';
import '../models/movie.dart';
import './movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Movie> _nowPlayingMovies = [
    Movie(
      id: '1',
      title: 'Avengers: Endgame',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
      rating: 8.4,
      genres: ['Action', 'Adventure', 'Fantasy'],
      duration: '3h 1m',
    ),
    Movie(
      id: '2',
      title: 'Joker',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
      rating: 8.5,
      genres: ['Crime', 'Drama', 'Thriller'],
      duration: '2h 2m',
    ),
    Movie(
      id: '3',
      title: 'Spider-Man: No Way Home',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      rating: 8.2,
      genres: ['Action', 'Adventure', 'Fantasy'],
      duration: '2h 28m',
    ),
  ];

  final List<Movie> _upcomingMovies = [
    Movie(
      id: '4',
      title: 'Black Widow',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg',
      rating: 7.8,
      genres: ['Action', 'Adventure', 'Thriller'],
      duration: '2h 14m',
    ),
    Movie(
      id: '5',
      title: 'Dune',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
      rating: 8.0,
      genres: ['Science Fiction', 'Adventure'],
      duration: '2h 35m',
    ),
    Movie(
      id: '6',
      title: 'Shang-Chi',
      posterUrl:
          'https://image.tmdb.org/t/p/w500/1BIoJGKbXjdFDAqUEiA2VHqkK1Z.jpg',
      rating: 7.9,
      genres: ['Action', 'Adventure', 'Fantasy'],
      duration: '2h 12m',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Xin chào,',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Hôm nay xem gì?',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.notifications, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm phim...',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      enabled: false,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thể loại',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/search');
                      },
                      child: const Text(
                        'Xem tất cả',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildGenreButton('Hành động'),
                      _buildGenreButton('Hài'),
                      _buildGenreButton('Tình cảm'),
                      _buildGenreButton('Kinh dị'),
                      _buildGenreButton('Khoa học viễn tưởng'),
                      _buildGenreButton('Phiêu lưu'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Đang chiếu',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _nowPlayingMovies.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(
                                movie: _nowPlayingMovies[index],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: MovieCard(movie: _nowPlayingMovies[index]),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Sắp chiếu',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _upcomingMovies.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(
                                movie: _upcomingMovies[index],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: MovieCard(movie: _upcomingMovies[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenreButton(String genre) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        onPressed: () {
          // Filter functionality would go here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.grey),
          ),
        ),
        child: Text(genre),
      ),
    );
  }
}
