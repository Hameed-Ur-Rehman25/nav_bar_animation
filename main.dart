import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hameed_portfolio/nav_bart_text.dart';

void main() {
  runApp(const ScrollAnimationApp());
}

class ScrollAnimationApp extends StatelessWidget {
  const ScrollAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScrollAnimationScreen(),
    );
  }
}

class ScrollAnimationScreen extends StatefulWidget {
  const ScrollAnimationScreen({super.key});

  @override
  ScrollAnimationScreenState createState() => ScrollAnimationScreenState();
}

class ScrollAnimationScreenState extends State<ScrollAnimationScreen> {
  final ScrollController _scrollController = ScrollController();
  double _containerWidth = 0;
  double _borderRadius = 0;
  double _blurIntensity = 0;
  Color _backgroundColor = Colors.white.withOpacity(0.1); // Initial color
  final double _maxBorderRadius = 50;

  @override
  void initState() {
    super.initState();

    // Listen to the scroll events
    _scrollController.addListener(() {
      setState(() {
        double offset = _scrollController.offset;

        // Adjust the container width and border radius
        _containerWidth = MediaQuery.of(context).size.width -
            (offset * 0.8).clamp(0, MediaQuery.of(context).size.width - 450);

        // Adjust the border radius with a threshold for when it should stop increasing
        _borderRadius = (offset * 0.2).clamp(0, _maxBorderRadius);

        // Adjust the blur intensity and background color opacity
        _blurIntensity = (offset * 0.5)
            .clamp(0, 10); // Adjust the max blur intensity as needed
        _backgroundColor =
            Colors.white.withOpacity((1 - offset * 0.005).clamp(0.4, 0.9));
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Navigation Bar Scroll Animation'),
      ),
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 80), // Space for the navigation bar
                ...List.generate(20, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ),
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(83, 32, 44, 220),
                    ),
                    child: Center(
                      child: Text('Item $index'),
                    ),
                  );
                }),
              ],
            ),
          ),

          // Centered animated container (navbar) at the top
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_borderRadius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _blurIntensity,
                    sigmaY: _blurIntensity,
                  ),
                  child: AnimatedContainer(
                    width: _containerWidth > 0
                        ? _containerWidth
                        : MediaQuery.of(context).size.width, // Start full width
                    height: 60, // Fixed navbar height
                    duration: const Duration(milliseconds: 50),
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      borderRadius: BorderRadius.circular(_borderRadius),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'HR',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              NavBartText(title: 'Home'),
                              SizedBox(width: 20),
                              NavBartText(title: 'About'),
                              SizedBox(width: 20),
                              NavBartText(title: 'Skills'),
                              SizedBox(width: 20),
                              NavBartText(title: 'Contact'),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
