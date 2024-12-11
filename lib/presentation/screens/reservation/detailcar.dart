import 'package:flutter/material.dart';
import 'package:toleka/presentation/screens/reservation/catalogue.dart';



class CarDetailScreen extends StatelessWidget {
  final Car car;

  CarDetailScreen({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Détail de la Voiture')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(car.image, width: double.infinity, height: 200, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text('Type: ${car.type}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Prix: ${car.price}€/jour', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Description: ${car.description}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text(
              'Disponibilité: ${car.isAvailable ? "Disponible" : "Déjà réservé"}',
              style: TextStyle(fontSize: 18, color: car.isAvailable ? Colors.green : Colors.red),
            ),
            SizedBox(height: 16),
            car.isAvailable
                ? ElevatedButton(
                    onPressed: () {
                      // Logique de réservation
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Réservation confirmée')));
                    },
                    child: Text('Réserver maintenant'),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
