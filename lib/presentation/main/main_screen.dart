import 'package:flutter/material.dart';
import 'package:flutter_movies_app/presentation/main/explore/screens/explore_screen.dart';
import 'package:flutter_movies_app/presentation/main/favorite/screens/favorite_screen.dart';
import 'package:flutter_movies_app/presentation/main/home/screens/home_screen.dart';
import 'package:flutter_movies_app/utils/constant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController();
  int pageIndex = 0;

  List<BottomNavigationBarItem> navItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.bookmark), label: 'Favorite'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: PageView(
        controller: pageController,
        children: [
          HomeScreen(),
          ExploreScreen(),
          FavoriteScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: BACKGROUND_COLOR,
        currentIndex: pageIndex,
        items: navItems,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 150),
            curve: Curves.bounceIn,
          );
        },
      ),
    );
  }
}
