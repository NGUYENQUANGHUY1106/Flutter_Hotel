import 'package:flutter/material.dart';

class BoxListCityGRid extends StatelessWidget {
  final List<Map<String, String>> places = [
    {"name": "Phú Quốc", "image": "assets/img/img_phuquoc.jpg"},
    {"name": "Đà Lạt", "image": "assets/img/img_dalat.jpg"},
    {"name": "Quy Nhơn", "image": "assets/img/img_quynhon.jpg"},
    {"name": "Vũng Tàu", "image": "assets/img/img_vungtau.webp"},
    {"name": "Nha Trang", "image": "assets/img/img_nhatrang.webp"},
    {"name": "Đà Nẵng", "image": "assets/img/img_danang.jpg"},
    {"name": "Phan Thiết", "image": "assets/img/img_phanthiet.jpeg"},
    {"name": "Phú Yên", "image": "assets/img/img_phuyen.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 3 / 2,
          children: places.map((place) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    place["image"]!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    place["name"]!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
