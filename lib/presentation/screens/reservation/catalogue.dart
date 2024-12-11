import 'package:flutter/material.dart';
import 'package:toleka/presentation/screens/reservation/detailcar.dart';

class Car {
  final String image;
  final String type;
  final double price;
  final String description;
  final bool isAvailable;

  Car({
    required this.image,
    required this.type,
    required this.price,
    required this.description,
    required this.isAvailable,
  });
}

class CatalogueScreen extends StatelessWidget {
  final List<Car> cars = [
    Car(
      image: 'assets/car1.jpg',
      type: 'Basic',
      price: 100.0,
      description: 'Un modèle économique pour les trajets simples.',
      isAvailable: true,
    ),
    Car(
      image: 'assets/car2.jpg',
      type: 'Confort',
      price: 150.0,
      description: 'Pour ceux qui cherchent un confort supplémentaire.',
      isAvailable: false,
    ),
    Car(
      image: 'assets/car3.jpg',
      type: 'Premium',
      price: 200.0,
      description: 'Pour une expérience de conduite de luxe.',
      isAvailable: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catalogue de Voitures')),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(car.image, width: 100),
              title: Text(car.type),
              subtitle: Text('${car.price}€/jour\n${car.description}'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CarDetailScreen(car: car),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
