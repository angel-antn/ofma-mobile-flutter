import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ofma_app/screens/main/pages/account_page.dart';
import 'package:ofma_app/screens/main/pages/home_page.dart';
import 'package:ofma_app/screens/main/pages/musicians_page.dart';
import 'package:ofma_app/screens/main/pages/ticket_page.dart';
import 'package:ofma_app/theme/app_colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        } else {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: const [
            HomePage(),
            MusicianPage(),
            TicketPage(),
            AccountPage(),
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) {
            _pageController.animateToPage(
              i,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            );
          },
          items: [
            SalomonBottomBarItem(
                icon: const Icon(FeatherIcons.home),
                title: const Text('Inicio'),
                selectedColor: AppColors.secondaryColor),
            SalomonBottomBarItem(
                icon: const Icon(FeatherIcons.music),
                title: const Text('Musícos'),
                selectedColor: AppColors.secondaryColor),
            SalomonBottomBarItem(
                icon: const Icon(FeatherIcons.grid),
                title: const Text('Boletos'),
                selectedColor: AppColors.secondaryColor),
            SalomonBottomBarItem(
                icon: const Icon(FeatherIcons.user),
                title: const Text('Cuenta'),
                selectedColor: AppColors.secondaryColor),
          ],
        ),
      ),
    );
  }
}
