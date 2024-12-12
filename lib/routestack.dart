// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toleka/presentation/screens/home/homescreenkelasi.dart';
import 'package:toleka/sizeconfig.dart';
import 'package:toleka/theme.dart';

class RouteStack extends StatefulWidget {
  const RouteStack({Key? key}) : super(key: key);

  @override
  _RouteStackState createState() => _RouteStackState();
}

class _RouteStackState extends State<RouteStack>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _screens = [
    Homescreen(),
    Placeholder(), // Replace with the screen for "Réserver véhicule"
    Placeholder(), // Replace with the screen for "Historiques réservations"
    Placeholder(), // Replace with the screen for "Paramètres"
  ];

  void _onItemTapped(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    super.build(context);
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          selectedItemColor: kelasiColorIcon,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: "Accueil",
              icon: SvgPicture.asset(
                "assets/icons/homekelasi.svg",
                width: 24,
                color: _selectedIndex == 0 ? kelasiColorIcon : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: "Réserver",
              icon: SvgPicture.asset(
                "assets/icons/vehiclekelasi.svg",
                width: 24,
                color: _selectedIndex == 1 ? kelasiColorIcon : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: "Historiques",
              icon: SvgPicture.asset(
                "assets/icons/historykelasi.svg",
                width: 24,
                color: _selectedIndex == 2 ? kelasiColorIcon : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: "Paramètres",
              icon: SvgPicture.asset(
                "assets/icons/settingskelasi.svg",
                width: 24,
                color: _selectedIndex == 3 ? kelasiColorIcon : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
