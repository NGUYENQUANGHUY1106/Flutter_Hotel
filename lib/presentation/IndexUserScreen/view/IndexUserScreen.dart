import 'package:book_hotel/presentation/UserBookedScreen/view/UserBookedScreen.dart';
import 'package:book_hotel/presentation/UserHomeScreen/view/UserHomeScreen.dart';
import 'package:book_hotel/presentation/UserProfileScreen/view/UserProfileScreen..dart';
import 'package:flutter/material.dart';
class Indexuserscreen extends StatefulWidget {
  const Indexuserscreen({super.key});

  @override
  State<Indexuserscreen> createState() => _IndexuserscreenState();
}

class _IndexuserscreenState extends State<Indexuserscreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const UserHomeScreen(),
    const Userbookedscreen(),
    const UserProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel),
            label: 'Đặt phòng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}
