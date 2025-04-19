import 'package:flutter/material.dart';

class SimpleImageSlider extends StatefulWidget {
  const SimpleImageSlider({super.key});

  @override
  State<SimpleImageSlider> createState() => _SimpleImageSliderState();
}

class _SimpleImageSliderState extends State<SimpleImageSlider> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<String> images = [
    'assets/img/img_hoian.jpg',
    'assets/img/img_hue.jpg',
    'assets/img/img_halong.jpeg',
    'assets/img/img_caubantay.jpg',
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), _autoSlide);
  }

  void _autoSlide() {
    if (!mounted) return;
    setState(() {
      _currentPage = (_currentPage + 1) % images.length;
    });
    _controller.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    Future.delayed(const Duration(seconds: 3), _autoSlide);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((entry) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == entry.key ? Colors.blue : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
