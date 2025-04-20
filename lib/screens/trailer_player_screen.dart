import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrailerPlayerScreen extends StatefulWidget {
  final String movieTitle;

  const TrailerPlayerScreen({super.key, required this.movieTitle});

  @override
  State<TrailerPlayerScreen> createState() => _TrailerPlayerScreenState();
}

class _TrailerPlayerScreenState extends State<TrailerPlayerScreen> {
  bool _isPlaying = true;
  double _currentPosition = 0.0;
  final double _totalDuration = 180.0; // giả lập 3 phút video

  @override
  void initState() {
    super.initState();
    // Thiết lập orientation sang landscape khi xem trailer
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // Giả lập tiến trình của video
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _startVideoProgress();
      }
    });
  }

  @override
  void dispose() {
    // Thiết lập lại orientation sang portrait khi thoát màn hình
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  void _startVideoProgress() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted && _isPlaying && _currentPosition < _totalDuration) {
        setState(() {
          _currentPosition += 1.0;
        });
        return true;
      }
      return false;
    });
  }

  String _formatDuration(double seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = (seconds % 60).floor();
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isPlaying = !_isPlaying;
            if (_isPlaying) {
              _startVideoProgress();
            }
          });
        },
        child: Stack(
          children: [
            // Video content (giả lập bằng ảnh poster)
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: const Icon(
                    Icons.movie,
                    size: 100,
                    color: Colors.white24,
                  ),
                ),
              ),
            ),

            // Player controls
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Progress bar
                    Row(
                      children: [
                        Text(
                          _formatDuration(_currentPosition),
                          style: const TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: Slider(
                            value: _currentPosition,
                            min: 0.0,
                            max: _totalDuration,
                            activeColor: Colors.red,
                            inactiveColor: Colors.grey,
                            onChanged: (value) {
                              setState(() {
                                _currentPosition = value;
                              });
                            },
                          ),
                        ),
                        Text(
                          _formatDuration(_totalDuration),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    // Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.replay_10,
                            color: Colors.white,
                            size: 36,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentPosition = (_currentPosition - 10).clamp(
                                0,
                                _totalDuration,
                              );
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 48,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPlaying = !_isPlaying;
                              if (_isPlaying) {
                                _startVideoProgress();
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.forward_10,
                            color: Colors.white,
                            size: 36,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentPosition = (_currentPosition + 10).clamp(
                                0,
                                _totalDuration,
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Back button
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // Title
            Positioned(
              top: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Trailer: ${widget.movieTitle}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
