import 'package:flutter/material.dart';
import '../models/movie.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample ticket data
    final List<Map<String, dynamic>> tickets = [
      {
        'movie': Movie(
          id: '1',
          title: 'Avengers: Endgame',
          posterUrl:
              'https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
          rating: 8.4,
          genres: ['Action', 'Adventure', 'Fantasy'],
          duration: '3h 1m',
        ),
        'date': 'Thứ 2, 15 tháng 5',
        'time': '20:00',
        'cinema': 'CGV Aeon Mall',
        'seats': ['A4', 'A5'],
        'screen': 'Cinema 3',
        'bookingId': 'TCKT39481',
        'active': true,
      },
      {
        'movie': Movie(
          id: '3',
          title: 'Spider-Man: No Way Home',
          posterUrl:
              'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
          rating: 8.2,
          genres: ['Action', 'Adventure', 'Fantasy'],
          duration: '2h 28m',
        ),
        'date': 'Thứ 7, 20 tháng 5',
        'time': '18:30',
        'cinema': 'CGV Vincom Center',
        'seats': ['C7', 'C8', 'C9'],
        'screen': 'Cinema 5',
        'bookingId': 'TCKT38291',
        'active': true,
      },
      {
        'movie': Movie(
          id: '2',
          title: 'Joker',
          posterUrl:
              'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
          rating: 8.5,
          genres: ['Crime', 'Drama', 'Thriller'],
          duration: '2h 2m',
        ),
        'date': 'Thứ 3, 10 tháng 4',
        'time': '19:00',
        'cinema': 'Lotte Cinema',
        'seats': ['B10', 'B11'],
        'screen': 'Cinema 2',
        'bookingId': 'TCKT27194',
        'active': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vé của tôi'),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body:
          tickets.isEmpty
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.confirmation_number_outlined,
                      size: 80,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Bạn chưa có vé nào',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Vé đã đặt sẽ hiển thị ở đây',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
              : DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: Colors.red,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.red,
                      tabs: [Tab(text: 'Sắp tới'), Tab(text: 'Đã xem')],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Active tickets
                          _buildTicketList(
                            context,
                            tickets
                                .where((ticket) => ticket['active'] == true)
                                .toList(),
                          ),
                          // Past tickets
                          _buildTicketList(
                            context,
                            tickets
                                .where((ticket) => ticket['active'] == false)
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildTicketList(
    BuildContext context,
    List<Map<String, dynamic>> tickets,
  ) {
    return tickets.isEmpty
        ? const Center(
          child: Text('Không có vé nào', style: TextStyle(color: Colors.grey)),
        )
        : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            final ticket = tickets[index];
            final movie = ticket['movie'] as Movie;

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            movie.posterUrl,
                            width: 60,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${ticket['date']} • ${ticket['time']}',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                ticket['cinema'],
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mã vé:',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              ticket['bookingId'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ghế:',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              (ticket['seats'] as List<String>).join(', '),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phòng chiếu:',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              ticket['screen'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(color: Colors.grey, thickness: 1, height: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code_2,
                          size: 24,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Hiển thị mã QR tại rạp',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
  }
}
