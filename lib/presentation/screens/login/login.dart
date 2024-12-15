import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Assurez-vous que cette dépendance est ajoutée
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:toleka/presentation/widgets/dialog/loading.dialog.dart';
import 'package:toleka/presentation/widgets/inputs/passwordTextField.dart';
import 'package:toleka/presentation/widgets/inputs/simplePhoneNumberField.dart';
import '../../widgets/dialog/ValidationDialog.dart';
import '../singupkelasi/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? nameError;
  String? passwordError;
  String? submitError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0c3849),
      body: Column(
        children: [
          // Premier bloc avec une hauteur fixe
          Container(
            height: 230,
            color: const Color(0XFF0c3849),
            child: const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.png'),
                radius: 50,
              ),
            ),
          ),
          // Deuxième bloc qui occupe le reste de l'espace
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                ),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Se connecter",
                      style: GoogleFonts.montserrat(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          margin: const EdgeInsets.only(bottom: 15, top: 20),
                          child: SizedBox(
                            height: 50.0,
                            child: TransAcademiaPhoneNumber(
                              number: 20,
                              controller: phoneController,
                              hintText: "Numéro de téléphone",
                              field: "phone",
                              fieldValue: state.field!["phone"],
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            try {
                              final response = await InternetAddress.lookup(
                                  'www.google.com');
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

                            if (state.field?["phone"]?.isEmpty ?? true) {
                              ValidationDialog.show(
                                context,
                                "Veuillez saisir le numéro de téléphone",
                                () {},
                              );
                              return;
                            }

                            String login = state.field!["phone"];
                            String password = state.field!["password"];
                            if (login.startsWith("0") ||
                                login.startsWith("+")) {
                              ValidationDialog.show(
                                context,
                                "Veuillez saisir le numéro avec un format valide, par exemple: (826016607).",
                                () {},
                              );
                              return;
                            }
                            if (login.length < 9) {
                              ValidationDialog.show(
                                context,
                                "Le numéro doit contenir au moins 9 caractères.",
                                () {},
                              );
                              return;
                            }

                            TransAcademiaLoadingDialog.show(context);

                            // Récupérer les coordonnées géographiques
                            Position? position;
                            try {
                              bool serviceEnabled =
                                  await Geolocator.isLocationServiceEnabled();
                              if (!serviceEnabled) {
                                ValidationDialog.show(
                                  context,
                                  "Les services de localisation ne sont pas activés.",
                                  () {},
                                );
                                return;
                              }

                              LocationPermission permission =
                                  await Geolocator.checkPermission();
                              if (permission == LocationPermission.denied) {
                                permission =
                                    await Geolocator.requestPermission();
                                if (permission == LocationPermission.denied) {
                                  ValidationDialog.show(
                                    context,
                                    "Permission de localisation refusée.",
                                    () {},
                                  );
                                  return;
                                }
                              }

                              if (permission ==
                                  LocationPermission.deniedForever) {
                                ValidationDialog.show(
                                  context,
                                  "Permission de localisation refusée de façon permanente.",
                                  () {},
                                );
                                return;
                              }

                              position = await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high);
                            } catch (e) {
                              TransAcademiaLoadingDialog.stop(context);
                              ValidationDialog.show(
                                context,
                                "Erreur lors de la récupération des coordonnées : $e",
                                () {},
                              );
                              return;
                            }

                            var response =
                                await SignUpRepository.login(login, password);
                            int status = response["status"];
                            Map? data = response["data"];

                            if (status == 200 && data != null) {
                              // Stocker les coordonnées
                              // await prefs.setDouble(
                              //     "latitude", position.latitude);
                              // await prefs.setDouble(
                              //     "longitude", position.longitude);

                              BlocProvider.of<SignupCubit>(context).updateField(
                                context,
                                field: "latitude",
                                data: position.latitude,
                              );

                              BlocProvider.of<SignupCubit>(context).updateField(
                                context,
                                field: "longitude",
                                data: position.longitude,
                              );

                              BlocProvider.of<SignupCubit>(context).updateField(
                                context,
                                field: "dataUser",
                                data: data,
                              );

                              BlocProvider.of<SignupCubit>(context).updateField(
                                context,
                                field: "idClient",
                                data: data["user"]["user_id"].toString(),
                              );

                              TransAcademiaLoadingDialog.stop(context);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/routestack',
                                (Route<dynamic> route) => false,
                              );
                            } else {
                              TransAcademiaLoadingDialog.stop(context);
                              TransAcademiaDialogError.show(
                                context,
                                response["message"] ?? "Erreur inconnue",
                                "login",
                              );
                              Future.delayed(const Duration(seconds: 3), () {
                                TransAcademiaDialogError.stop(context);
                              });
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: ButtonTransAcademia(title: "Se connecter"),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signup()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Vous n'avez pas de compte ? ",
                            style: GoogleFonts.montserrat(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Inscrivez-vous",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0Xff6bb6e2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
