import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'payment_screen.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Movie movie;

  const SeatSelectionScreen({super.key, required this.movie});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final List<String> _selectedSeats = [];
  final double _ticketPrice = 90000; // 90,000 VND per ticket

  final List<List<int>> _seatLayout = [
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
  ];

  final List<String> _bookedSeats = ['A2', 'A3', 'C4', 'E5', 'F6', 'G7'];

  String _getSeatLabel(int row, int col) {
    final rowLabel = String.fromCharCode(65 + row); // 'A', 'B', 'C', ...
    final colLabel = col + 1; // 1, 2, 3, ...
    return '$rowLabel$colLabel';
  }

  bool _isSeatBooked(int row, int col) {
    final seatLabel = _getSeatLabel(row, col);
    return _bookedSeats.contains(seatLabel);
  }

  bool _isSeatSelected(int row, int col) {
    final seatLabel = _getSeatLabel(row, col);
    return _selectedSeats.contains(seatLabel);
  }

  void _toggleSeatSelection(int row, int col) {
    final seatLabel = _getSeatLabel(row, col);
    setState(() {
      if (_selectedSeats.contains(seatLabel)) {
        _selectedSeats.remove(seatLabel);
      } else {
        _selectedSeats.add(seatLabel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn ghế'),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  widget.movie.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Thứ 2, 15 tháng 5 • 20:00 • CGV Aeon Mall',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegend('Trống', Colors.white),
                _buildLegend('Đã chọn', Colors.red),
                _buildLegend('Đã đặt', Colors.grey),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'MÀN HÌNH',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: List.generate(_seatLayout.length, (row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                          child: Text(
                            String.fromCharCode(65 + row),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ...List.generate(_seatLayout[row].length, (col) {
                          return GestureDetector(
                            onTap:
                                _isSeatBooked(row, col)
                                    ? null
                                    : () => _toggleSeatSelection(row, col),
                            child: Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color:
                                    _isSeatBooked(row, col)
                                        ? Colors.grey
                                        : _isSeatSelected(row, col)
                                        ? Colors.red
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  (col + 1).toString(),
                                  style: TextStyle(
                                    color:
                                        _isSeatBooked(row, col) ||
                                                _isSeatSelected(row, col)
                                            ? Colors.white
                                            : Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_selectedSeats.length} ghế: ${_selectedSeats.join(', ')}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tổng: ${(_selectedSeats.length * _ticketPrice).toStringAsFixed(0)} VND',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed:
                        _selectedSeats.isEmpty
                            ? null
                            : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => PaymentScreen(
                                        movie: widget.movie,
                                        selectedSeats: _selectedSeats,
                                        totalAmount:
                                            _selectedSeats.length *
                                            _ticketPrice,
                                      ),
                                ),
                              );
                            },
                    child: const Text(
                      'Tiếp tục',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
