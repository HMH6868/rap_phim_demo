import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'ticket_success_screen.dart';

class PaymentScreen extends StatefulWidget {
  final Movie movie;
  final List<String> selectedSeats;
  final double totalAmount;

  const PaymentScreen({
    super.key,
    required this.movie,
    required this.selectedSeats,
    required this.totalAmount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0;
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'Thẻ tín dụng / Ghi nợ', 'icon': Icons.credit_card},
    {'name': 'Momo', 'icon': Icons.account_balance_wallet},
    {'name': 'ZaloPay', 'icon': Icons.payment},
    {'name': 'VNPay', 'icon': Icons.monetization_on},
  ];

  void _processPayment() {
    setState(() {
      _isProcessing = true;
    });

    // Simulating payment processing
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => TicketSuccessScreen(
                movie: widget.movie,
                selectedSeats: widget.selectedSeats,
                totalAmount: widget.totalAmount,
              ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body:
          _isProcessing
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.red),
                    SizedBox(height: 16),
                    Text(
                      'Đang xử lý thanh toán...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.movie.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Thứ 2, 15 tháng 5 • 20:00 • CGV Aeon Mall',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const Divider(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Ghế'),
                                  Text(
                                    widget.selectedSeats.join(', '),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Số lượng'),
                                  Text(
                                    '${widget.selectedSeats.length} vé',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Giá vé'),
                                  const Text(
                                    '90,000 VND/vé',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Tổng cộng',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${widget.totalAmount.toStringAsFixed(0)} VND',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Phương thức thanh toán',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: List.generate(_paymentMethods.length, (
                            index,
                          ) {
                            return RadioListTile(
                              title: Row(
                                children: [
                                  Icon(_paymentMethods[index]['icon']),
                                  const SizedBox(width: 16),
                                  Text(_paymentMethods[index]['name']),
                                ],
                              ),
                              value: index,
                              groupValue: _selectedPaymentMethod,
                              activeColor: Colors.red,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPaymentMethod = value as int;
                                });
                              },
                            );
                          }),
                        ),
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
                          onPressed: _processPayment,
                          child: const Text(
                            'Thanh toán ngay',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
