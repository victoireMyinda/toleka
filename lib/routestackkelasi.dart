// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toleka/presentation/screens/abonnement/abonnementkelasi.dart';
import 'package:toleka/presentation/screens/home/homescreenkelasi.dart';
import 'package:toleka/sizeconfig.dart';
import 'package:toleka/theme.dart';

class RouteStackKelasi extends StatefulWidget {
  const RouteStackKelasi({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RouteStackKelasiState createState() => _RouteStackKelasiState();
}

class _RouteStackKelasiState extends State<RouteStackKelasi>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ignore: prefer_final_fields
  List<Widget> _screens = [
    Homescreen(),
    AbonnementKelasi(backNavigation: false),
    AbonnementKelasi(backNavigation: false),
    AbonnementKelasi(backNavigation: false),
  
  ];

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    super.build(context);
    return Scaffold(
        // backgroundColor: const Color(0xFFFFFFFF),
        body: PageView(
          controller: pageController,
          onPageChanged: _onPageChanged,
          children: _screens,
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar:
            bottomNavigationBar(_selectedIndex, _onItemTapped, context));
  }

  @override
  bool get wantKeepAlive => true;
}

Widget bottomNavigationBar(_selectedIndex, _onItemTapped, context) {
  return Container(
    // color: Colors.grey.withOpacity(0.1),
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // backgroundColor: const Color(0xFFffffff),
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
                icon: SvgPicture.asset("assets/icons/homekelasi.svg",
                    width: 20,
                    color:
                        _selectedIndex == 0 ? kelasiColorIcon : Colors.grey)),
            BottomNavigationBarItem(
                label: "Enfants liés",
                icon: SvgPicture.asset("assets/icons/enfantkelasi.svg",
                    width: 20,
                    color:
                        _selectedIndex == 1 ? kelasiColorIcon : Colors.grey)),
            BottomNavigationBarItem(
              label: "",
              icon: CircleAvatar(
                radius: 24,
                backgroundColor: _selectedIndex == 2 ? kelasiColorIcon : Colors.grey,
                child: SvgPicture.asset("assets/icons/Paymentkelasi.svg",
                    width: 30,
                    color:  Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              label: "Notifications",
              icon: SvgPicture.asset("assets/icons/notificationkelasi.svg",
                  width: 20,
                  color: _selectedIndex == 3 ? kelasiColorIcon : Colors.grey),
            ),
            BottomNavigationBarItem(
                label: "Reglage",
                // icon: Icon(Icons.add_circle_outline, size: 40,color: Colors.grey.withOpacity(0.5),)
                icon: SvgPicture.asset("assets/icons/reglagekelasi.svg",
                    width: 20,
                    color:
                        _selectedIndex == 4 ? kelasiColorIcon : Colors.grey)),
          ]),
    ),
  );
}
