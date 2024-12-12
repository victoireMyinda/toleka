import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/inputs/dateField.dart';
import 'package:toleka/presentation/widgets/inputs/nameField.dart';

class CarDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Toyota Corolla',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0XFF0c3849),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
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
              const SizedBox(height: 20),
              const Text(
                'Toyota Corolla',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Berline',
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
              const SizedBox(height: 16),
              Row(
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
                  const Text(
                    '25000.00 €',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Caractéristiques:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: features.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 16.0,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          features[index],
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => _showOrderBottomSheet(context),
                child: const ButtonTransAcademia(title: "Passer commande"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOrderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Passer une commande',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
                return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 45.0,
                      child: TransAcademiaNameInput(
                        hintText: "Lieu de départ",
                        field: "depart",
                        label: "Lieu de départ",
                        fieldValue: state.field!["depart"],
                      ),
                    ));
              }),
              const SizedBox(height: 16),
              BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
                return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 45.0,
                      child: TransAcademiaNameInput(
                        hintText: "Lieu d'arrivée",
                        field: "arrive",
                        label: "Lieu d'arrivée",
                        fieldValue: state.field!["arrive"],
                      ),
                    ));
              }),
              const SizedBox(height: 16),
              BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
                return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 45.0,
                      child: TransAcademiaDatePicker(
                        hintText: "Date de résérvation",
                        field: "dateReservation",
                        label: "Date de résérvation",
                        fieldValue: state.field!["dateReservation"],
                      ),
                    ));
              }),
              const SizedBox(height: 16),
              BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
                return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 45.0,
                      child: TransAcademiaDatePicker(
                        hintText: "Date De fin résérvation",
                        field: "dateFinReservation",
                        label: "Date De fin résérvation",
                        fieldValue: state.field!["dateFinReservation"],
                      ),
                    ));
              }),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF0c3849),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text(
                    'Valider',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final List<String> features = [
    'Climatisation',
    'Régulateur de vitesse',
    'Bluetooth',
  ];
}
