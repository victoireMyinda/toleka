import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:toleka/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:toleka/presentation/widgets/dialog/loading.dialog.dart';
import 'package:toleka/presentation/widgets/inputs/dateField.dart';
import 'package:toleka/presentation/widgets/inputs/nameField.dart';

class CarDetailScreen extends StatelessWidget {
  final Map? data;

  CarDetailScreen({required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "${data!["marque"]}  ${data!["modele"]}",
          style: const TextStyle(color: Colors.white),
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
              Text(
                "${data!["marque"]}  ${data!["modele"]}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                data!["nom_categorie"],
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Prix par heure ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    "${data!["tarif_heure_jour"] ?? "non renseigné"} \$",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                data!["description"],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Tarifications :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Padding(
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
                      "Tarification heure : ${data!["tarif_heure_jour"] ?? "non renseigné"}  \$",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ],
                ),
              ),
              Padding(
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
                      "Tarification nuit : ${data!["tarif_heure_nuit"]}  \$",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ],
                ),
              ),
              Padding(
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
                      "Tarification journaliere: ${data!["tarif_journalier"]}  \$",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ],
                ),
              ),
              Padding(
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
                      "Tarification aeroport : ${data!["tarif_trajet_aeroport"]}  \$",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ],
                ),
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
    int idVehicule = int.parse(data!["vehicule_id"]);
    String total = data!["tarif_heure_jour"];

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
                'Passer votre commande',
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
                        field: "arrivee",
                        label: "Lieu d'arrivée",
                        fieldValue: state.field!["arrivee"],
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
                child: BlocBuilder<SignupCubit, SignupState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () async {
                        try {
                          final response =
                              await InternetAddress.lookup('www.google.com');
                          if (response.isEmpty) {
                            throw SocketException("Pas de connexion");
                          }
                        } on SocketException {
                          ValidationDialog.show(
                            context,
                            "Pas de connexion internet !",
                            () {},
                          );
                          return;
                        }
                        if (state.field?["depart"]?.isEmpty ?? true) {
                          ValidationDialog.show(
                            context,
                            "Lieu de depart obligatoire",
                            () {},
                          );
                          return;
                        }

                        if (state.field?["arrivee"]?.isEmpty ?? true) {
                          ValidationDialog.show(
                            context,
                            "Lieu d'arrivée obligatoire",
                            () {},
                          );
                          return;
                        }

                        // if (state.field?["dateReservation"]?.isEmpty ?? true) {
                        //   ValidationDialog.show(
                        //     context,
                        //     "Date de reservation obligatoire",
                        //     () {},
                        //   );
                        //   return;
                        // }

                        // if (state.field?["dateFinReservation"]?.isEmpty ??
                        //     true) {
                        //   ValidationDialog.show(
                        //     context,
                        //     "Date de fin reservation obligatoire",
                        //     () {},
                        //   );
                        //   return;
                        // }

                        TransAcademiaLoadingDialog.show(context);

                        Map dataReservation = {
                          "client_id":
                              int.parse(state.field!["dataUser"]["user_id"]),
                          "vehicule_id": idVehicule,
                          "total": total,
                          "lieu_depart": state.field!["depart"],
                          "lieu_arrivee": state.field!["arrivee"],
                          "date_debut": state.field!["dateReservation"],
                          "date_fin": state.field!["dateFinReservation"],
                        };

                        print(dataReservation);

                        var response = await SignUpRepository.reservation(
                            dataReservation, context);

                        int status = response["status"];
                        String? message = response["message"];
                        Map? data = response["data"];

                        if (status == 200 && data != null) {
                          TransAcademiaDialogSuccess.show(
                              context, message, "Auth");

                          Future.delayed(const Duration(milliseconds: 4000),
                              () async {
                            TransAcademiaDialogSuccess.stop(context);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (Route<dynamic> route) => false);
                          });
                        } else {
                          TransAcademiaLoadingDialog.stop(context);
                          TransAcademiaDialogError.show(
                            context,
                            response["message"] ?? "Erreur inconnue",
                            "reservation",
                          );
                          Future.delayed(const Duration(seconds: 3), () {
                            TransAcademiaDialogError.stop(context);
                          });
                        }
                      },
                      child:
                          const ButtonTransAcademia(title: "Valider commande"),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
