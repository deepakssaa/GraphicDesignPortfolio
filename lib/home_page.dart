import 'package:flutter/material.dart';
import 'package:designsmith/about.dart';
import 'package:designsmith/product_lst.dart';
import 'package:designsmith/app_theme.dart';
import 'package:designsmith/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      preloadImages(context);
    });
  }

  void preloadImages(BuildContext context) async {
    final imagePaths = [
      'assets/images/Vellosa-Bites.png',
      'assets/images/gdr.png',
      'assets/images/mobile.png',
      'assets/images/ai.png',
      'assets/images/BANNER.png',
      'assets/images/profile.jpg',
      'assets/images/cgpage1.png',
      'assets/images/designsmithh.png',
      'assets/images/mustang.png',
      'assets/images/firstspider.png',
    ];

    await Future.wait(
      imagePaths.map((path) => precacheImage(AssetImage(path), context)),
    );
  }

  int currentPage = 0;

  List<Widget> pages = [const ProductLst(), const About()];

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    if (isDesktop) {
      // Desktop: Use NavigationRail on the left
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              backgroundColor: AppTheme.primary,
              selectedIndex: currentPage,
              onDestinationSelected: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              labelType: NavigationRailLabelType.all,
              selectedIconTheme: const IconThemeData(
                color: AppTheme.accent,
                size: 28,
              ),
              unselectedIconTheme: IconThemeData(
                color: AppTheme.white.withValues(alpha: 0.6),
                size: 24,
              ),
              selectedLabelTextStyle: const TextStyle(
                color: AppTheme.accent,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              unselectedLabelTextStyle: TextStyle(
                color: AppTheme.white.withValues(alpha: 0.6),
                fontSize: 11,
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.draw_outlined),
                  selectedIcon: Icon(Icons.draw),
                  label: Text('Designs'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.account_circle_outlined),
                  selectedIcon: Icon(Icons.account_circle),
                  label: Text('About'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: IndexedStack(index: currentPage, children: pages),
            ),
          ],
        ),
      );
    }

    // Mobile & Tablet: Use BottomNavigationBar
    return Scaffold(
      body: IndexedStack(index: currentPage, children: pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          iconSize: 26,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          currentIndex: currentPage,
          selectedItemColor: AppTheme.primary,
          unselectedItemColor: AppTheme.textSecondary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.draw_outlined),
              activeIcon: Icon(Icons.draw),
              label: 'Designs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle),
              label: 'About',
            ),
          ],
        ),
      ),
    );
  }
}
