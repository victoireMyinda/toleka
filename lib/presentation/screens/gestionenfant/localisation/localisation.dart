import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalisationScreen extends StatefulWidget {
  LocalisationScreen({Key? key}) : super(key: key);

  @override
  State<LocalisationScreen> createState() => _LocalisationScreenState();
}

class _LocalisationScreenState extends State<LocalisationScreen> {
  late GoogleMapController mapController;
  final Map<String, Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Position de l'agent Teddy"),
          backgroundColor: const Color(0XFF055905),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 245, 244, 244),
        body: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(4.0383, 21.7587), 
            zoom: 12,
          ),
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          // Ajoutez votre clé d'API ici
          // Le paramètre 'mapType' spécifie le type de carte (par défaut, normal)
          // Le paramètre 'myLocationEnabled' active le bouton pour afficher la position actuelle de l'utilisateur sur la carte
          // Le paramètre 'compassEnabled' active le bouton de la boussole pour l'orientation de la carte
          // Le paramètre 'zoomControlsEnabled' active les boutons de zoom sur la carte
          // Vous pouvez également définir d'autres options selon vos besoins
          markers: Set<Marker>.of(markers.values),
          onCameraMove: _onCameraMove,
        ),
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    // Mettre à jour la position de la caméra
  }
}
