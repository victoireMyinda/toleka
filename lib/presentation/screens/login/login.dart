import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Premier bloc avec une hauteur fixe de 400
          Container(
            height: 400,
            color: Colors.blue, // Couleur pour identifier le bloc
            child: const Center(
              child: Text(
                'Bloc 1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Deuxième bloc qui occupe le reste de l'espace
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Couleur pour identifier le bloc
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                ),
              ),
              child: const Center(
                child: Text(
                  'Bloc 2',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
