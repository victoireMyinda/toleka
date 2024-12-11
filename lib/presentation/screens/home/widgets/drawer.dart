import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0XFF0c3849),   Color(0Xff6bb6e2),],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
                  final user = state.field?['dataUser']?['user'] ?? {};
                  final prenom = user['prenom'] ?? '';
                  final nom = user['nom'] ?? '';

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: const AssetImage(
                          "assets/images/profile.jpg",
                        ),
                        radius: 40,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "$prenom $nom",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.directions_car,
                  text: 'Réserver véhicule',
                  onTap: () {
                    // Action pour réserver un véhicule
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.phone,
                  text: 'Nous contacter',
                  onTap: () {
                    // Action pour nous contacter
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person,
                  text: 'Mettre à jour profil',
                  onTap: () {
                    // Action pour mettre à jour le profil
                  },
                ),
                const Divider(),
                _buildDrawerItem(
                  context,
                  icon: Icons.logout,
                  text: 'Déconnexion',
                  textColor: Colors.red,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Version 1.0.0',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, {
    required IconData icon,
    required String text,
    Color textColor = Colors.black87,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }
}
