import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';

class CarDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Toyota Corolla',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0XFF0c3849),
        elevation: 0.0, // Remove shadow for a cleaner look
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  'https://i.pinimg.com/736x/70/ef/85/70ef853426a2a83a269e5405d8f91a50.jpg',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Toyota Corolla',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Berline',
                style: TextStyle(fontSize: 16, color: Colors.grey[800]), // Use a darker grey
              ),
              SizedBox(height: 16),
              Row( // Use Row for price and separate label
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Prix:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    '25000.00 €',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red, // Highlight price
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Caractéristiques:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              ListView.builder(
                // Use ListView.builder for dynamic list
                shrinkWrap: true, // Prevent excessive padding
                itemCount: features.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle, // Add checkmark icon for features
                          color: Colors.green,
                          size: 16.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          features[index],
                          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 32),
              GestureDetector(
              
                child: const ButtonTransAcademia(title: "Passer commande"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<String> features = [
    'Climatisation',
    'Régulateur de vitesse',
    'Bluetooth',
  ];
}