// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:toleka/presentation/screens/home/homescreendart';
import 'package:toleka/presentation/screens/reservation/catalogue.dart';
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
    VehicleCatalogScreen(), 
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
      backgroundColor: Colors.white,
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
        child: Opacity(
          opacity: 0.9, // Applique une légère opacité
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            selectedItemColor: Color(0XFF0c3849),
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: "Accueil",
                icon: Icon(
                  Icons.home,
                  color: _selectedIndex == 0 ? kelasiColorIcon : Colors.grey,
                ),
              ),
              BottomNavigationBarItem(
                label: "Réserver",
                icon: Icon(
                  Icons.directions_car,
                  color: _selectedIndex == 1 ? kelasiColorIcon : Colors.grey,
                ),
              ),
              BottomNavigationBarItem(
                label: "Historiques",
                icon: Icon(
                  Icons.history,
                  color: _selectedIndex == 2 ? kelasiColorIcon : Colors.grey,
                ),
              ),
              BottomNavigationBarItem(
                label: "Paramètres",
                icon: Icon(
                  Icons.settings,
                  color: _selectedIndex == 3 ? kelasiColorIcon : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
