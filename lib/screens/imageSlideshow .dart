import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:slide_show/screens/endScreen.dart';

import '../widgets/imageCard .dart';

class ImageSlideshow extends StatefulWidget {
  const ImageSlideshow({super.key});

  @override
  _ImageSlideshowState createState() => _ImageSlideshowState();
}

class _ImageSlideshowState extends State<ImageSlideshow>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late Timer _timer;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _showCard = false;
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticInOut,
      ),
    );
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _showCard = true;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _delayedStartSlideShow();
    });
  }

  @override
  void didUpdateWidget(covariant ImageSlideshow oldWidget) {
    super.didUpdateWidget(oldWidget);
    _delayedStartSlideShow();
  }

  void _startSlideShow() {
    _speak(imageNames[_currentIndex]);
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentIndex < imagePaths.length - 1) {
        setState(() {
          _currentIndex++;
          _speak(imageNames[_currentIndex]);
        });
      } else {
        _timer.cancel();

      
        setState(() {
            _animationController.stop();
             Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EndScreen()),
          );
        });
       
        
      }
    });
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    _timer.cancel();
    flutterTts.stop();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _delayedStartSlideShow() async {
    await Future.delayed(Duration(seconds: 2));
    _startSlideShow();
  }

  List<String> imagePaths = [
    "assets/images/apples.png",
    "assets/images/bear.png",
    "assets/images/key.png",
    "assets/images/dog.png",
    "assets/images/pen.png",
  ];

  List<String> imageNames = [
    "Apples",
    "Bear",
    "Key",
    "Dog",
    "Pen",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Image Slideshow'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            SizedBox(
              height: 300, // تعيين حجم محدد للحاوية
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    top: _showCard ? 15 : -400,
                    left: 20,
                    right: 20,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child: ImageCard(
                        key: ValueKey<String>(imagePaths[_currentIndex]),
                        imagePath: imagePaths[_currentIndex],
                        animation: _animation,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              imageNames[_currentIndex],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
