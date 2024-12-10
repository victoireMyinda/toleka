import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/presentation/screens/home/widgets/cardhome.dart';
import 'package:toleka/presentation/screens/home/widgets/carslider.dart';
import 'package:toleka/presentation/screens/home/widgets/drawer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final List<String> vehicleImages = [
    'assets/images/v1.jpg',
    'assets/images/v2.jpg',
    'assets/images/v3.jpg',
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int unreadNotifications = 5; // Nombre de notifications non lues

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey, // Ajout du GlobalKey
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 230,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0c3a4b), Color(0xFF1976D2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(
                          icon: const Icon(Icons.list, size: 30, color: Colors.white),
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer(); // Ouvrir le Drawer
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Stack(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                // Action pour ouvrir les notifications
                              },
                            ),
                            if (unreadNotifications > 0)
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  child: Text(
                                    '$unreadNotifications',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                    return Text(
                      "Salut, ${state.field?["dataUser"]?["user"]?["prenom"] ?? ""} ${state.field?["dataUser"]?["user"]?["nom"] ?? ""} !!",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  Text(
                    'Toleka, Kinshasa',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        hintText: 'What service are you looking for?',
                        hintStyle: GoogleFonts.poppins(fontSize: 14),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Cartes
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: const [
                  HomeCard(
                    text: 'Commander véhicule',
                    icon: Icons.directions_car,
                  ),
                  HomeCard(
                    text: 'Nous contacter',
                    icon: Icons.phone,
                  ),
                  HomeCard(
                    text: 'Catalogue',
                    icon: Icons.book,
                  ),
                  HomeCard(
                    text: 'Partager',
                    icon: Icons.share,
                  ),
                  HomeCard(
                    text: 'Chat avec nous',
                    icon: Icons.chat,
                  ),
                  HomeCard(
                    text: 'Localisation',
                    icon: Icons.map,
                  ),
                ],
              ),
            ),

            // Slider
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ImageSlider(images: vehicleImages),
            ),
          ],
        ),
      ),
      drawer: const CustomDrawer(), // Drawer ici
    );
  }
}
