import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResults = [];
  bool _isSearching = false;

  // Sample data for search results - in a real app would come from API
  final List<Movie> _allMovies = [
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
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
    } else {
      setState(() {
        _isSearching = true;
        _searchResults =
            _allMovies
                .where(
                  (movie) => movie.title.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ),
                )
                .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Tìm kiếm phim...',
            border: InputBorder.none,
          ),
          autofocus: true,
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.black),
              onPressed: () {
                _searchController.clear();
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Genre filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Wrap(
              spacing: 8,
              children: [
                _buildFilterChip('Action'),
                _buildFilterChip('Adventure'),
                _buildFilterChip('Drama'),
                _buildFilterChip('Comedy'),
                _buildFilterChip('Thriller'),
                _buildFilterChip('Fantasy'),
                _buildFilterChip('Science Fiction'),
              ],
            ),
          ),

          // Search results
          Expanded(
            child:
                _isSearching && _searchController.text.isNotEmpty
                    ? _searchResults.isEmpty
                        ? const Center(
                          child: Text(
                            'Không tìm thấy kết quả',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                        : GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final movie = _searchResults[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            MovieDetailScreen(movie: movie),
                                  ),
                                );
                              },
                              child: MovieCard(movie: movie),
                            );
                          },
                        )
                    : _buildRecentSearches(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String genre) {
    return FilterChip(
      label: Text(genre),
      backgroundColor: Colors.grey[200],
      onSelected: (selected) {
        // Implementation for filter functionality would go here
      },
    );
  }

  Widget _buildRecentSearches() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tìm kiếm gần đây',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // Clear recent searches functionality
                },
                child: const Text('Xóa', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildRecentSearchItem('Avengers'),
          _buildRecentSearchItem('Spider-Man'),
          _buildRecentSearchItem('Black Widow'),
        ],
      ),
    );
  }

  Widget _buildRecentSearchItem(String query) {
    return InkWell(
      onTap: () {
        _searchController.text = query;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            const Icon(Icons.history, color: Colors.grey),
            const SizedBox(width: 12),
            Text(query, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            const Icon(Icons.north_west, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}
