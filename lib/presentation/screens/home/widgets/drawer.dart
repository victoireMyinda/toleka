import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0c3a4b), Color(0xFF1976D2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: BlocBuilder<SignupCubit, SignupState>(
              builder: (context, state) {
                final user = state.field?['dataUser']?['user'] ?? {};
                final prenom = user['prenom'] ?? '';
                final nom = user['nom'] ?? '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Salut, $prenom $nom !!",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Toleka, Kinshasa",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.directions_car),
            title: const Text('Reserver véhicule'),
            onTap: () {
              // Action pour réserver un véhicule
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Nous contacter'),
            onTap: () {
              // Action pour nous contacter
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mettre à jour profil'),
            onTap: () {
              // Action pour mettre à jour le profil
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Déconnexion'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
