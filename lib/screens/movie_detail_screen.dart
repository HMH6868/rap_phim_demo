import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'seat_selection_screen.dart';
import 'trailer_player_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(movie.posterUrl, fit: BoxFit.cover),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => TrailerPlayerScreen(
                                  movieTitle: movie.title,
                                ),
                          ),
                        );
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      iconSize: 48,
                    ),
                  ),
                ),
              ],
            ),
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite_border, color: Colors.red),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đã thêm vào danh sách yêu thích'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${movie.rating}/10',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        movie.duration,
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children:
                        movie.genres.map((genre) {
                          return Chip(
                            label: Text(
                              genre,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Nội dung',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla facilisi. Sed euismod, nisl nec aliquam tincidunt, nisl nisl aliquet nisl, eget aliquam nisl nisl sit amet nisl. Nulla facilisi. Sed euismod, nisl nec aliquam tincidunt, nisl nisl aliquet nisl, eget aliquam nisl nisl sit amet nisl.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Diễn viên',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 110,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildActorCard(
                          'Robert Downey Jr.',
                          'https://image.tmdb.org/t/p/w200/5qHNjhtjMD4YWH3UP0rm4tKwxCL.jpg',
                        ),
                        _buildActorCard(
                          'Chris Evans',
                          'https://image.tmdb.org/t/p/w200/3bOGNsHlrswhyW79uvIHH1V43JI.jpg',
                        ),
                        _buildActorCard(
                          'Chris Hemsworth',
                          'https://image.tmdb.org/t/p/w200/xkHHiKV9mCwZTSJWWsZW55Z6zyW.jpg',
                        ),
                        _buildActorCard(
                          'Scarlett Johansson',
                          'https://image.tmdb.org/t/p/w200/6NsMbJXRlDZuDzatN2akFdGuTvx.jpg',
                        ),
                        _buildActorCard(
                          'Mark Ruffalo',
                          'https://image.tmdb.org/t/p/w200/z3dvKqMNDQWk3QLxzumloQVR0pv.jpg',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Đánh giá',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildReviewCard(
                    'Nguyễn Văn A',
                    'https://randomuser.me/api/portraits/men/32.jpg',
                    'Phim rất hay và hấp dẫn. Tôi rất thích các nhân vật và cách họ phát triển trong phim.',
                    4.5,
                  ),
                  const SizedBox(height: 12),
                  _buildReviewCard(
                    'Trần Thị B',
                    'https://randomuser.me/api/portraits/women/44.jpg',
                    'Phim có nhiều cảnh hành động hoành tráng và hiệu ứng đẹp mắt. Tuy nhiên, cốt truyện hơi phức tạp.',
                    4.0,
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Hiển thị tất cả đánh giá
                      },
                      child: const Text(
                        'Xem tất cả đánh giá',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Lịch chiếu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildDateCard('T2', '15', true),
                        _buildDateCard('T3', '16', false),
                        _buildDateCard('T4', '17', false),
                        _buildDateCard('T5', '18', false),
                        _buildDateCard('T6', '19', false),
                        _buildDateCard('T7', '20', false),
                        _buildDateCard('CN', '21', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildTimeChip('10:00'),
                      _buildTimeChip('12:30'),
                      _buildTimeChip('15:00'),
                      _buildTimeChip('17:30'),
                      _buildTimeChip('20:00'),
                      _buildTimeChip('22:30'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => SeatSelectionScreen(movie: movie),
                          ),
                        );
                      },
                      child: const Text(
                        'Đặt vé ngay',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateCard(String day, String date, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey[300]!,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeChip(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildActorCard(String name, String imageUrl) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(radius: 35, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(
    String name,
    String imageUrl,
    String review,
    double rating,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 20),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          index < rating.floor()
                              ? Icons.star
                              : (index < rating
                                  ? Icons.star_half
                                  : Icons.star_border),
                          color: Colors.amber,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        rating.toString(),
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(review),
        ],
      ),
    );
  }
}
