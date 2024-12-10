import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Assurez-vous que cette dépendance est ajoutée
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/screens/login/login.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:toleka/presentation/widgets/dialog/loading.dialog.dart';
import 'package:toleka/presentation/widgets/inputs/nameField.dart';
import 'package:toleka/presentation/widgets/inputs/passwordTextField.dart';
import 'package:toleka/presentation/widgets/inputs/simplePhoneNumberField.dart';
import '../../widgets/dialog/ValidationDialog.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
            height: 100,
            color: const Color(0XFF0c3849),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Text(
                      "Inscription",
                      style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const Text("")
                  ],
                ),
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
                    
                    BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                      return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            height: 45.0,
                            child: TransAcademiaNameInput(
                              isError: state.field!["nomError"],
                              hintText: "Nom",
                              field: "nom",
                              label: "Nom",
                              fieldValue: state.field!["nom"],
                            ),
                          ));
                    }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                      return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            height: 45.0,
                            child: TransAcademiaNameInput(
                              isError: state.field!["prenomError"],
                              hintText: "Prenom",
                              field: "prenom",
                              label: "Prenom",
                              fieldValue: state.field!["prenom"],
                            ),
                          ));
                    }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                      return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            height: 45.0,
                            child: TransAcademiaNameInput(
                              hintText: "Votre adresse Email",
                              field: "email",
                              label: "Votre adresse Email",
                              fieldValue: state.field!["email"],
                            ),
                          ));
                    }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                      return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            height: 45.0,
                            child: TransAcademiaNameInput(
                              isError: state.field!["adresseError"],
                              hintText: "Adresse",
                              field: "adresse",
                              label: "Adresse",
                              fieldValue: state.field!["adresse"],
                            ),
                          ));
                    }),
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          margin: const EdgeInsets.only(bottom: 15, top: 10),
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

                            if (state.field?["nom"]?.isEmpty ?? true) {
                              ValidationDialog.show(
                                context,
                                "Nom obligatoire.",
                                () {},
                              );
                              return;
                            }

                            if (state.field?["prenom"]?.isEmpty ?? true) {
                              ValidationDialog.show(
                                context,
                                "Prenom obligatoire.",
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

                            String phone = state.field!["phone"];
                            if (phone.startsWith("0") ||
                                phone.startsWith("+")) {
                              ValidationDialog.show(
                                context,
                                "Veuillez saisir le numéro avec un format valide, par exemple: (826016607).",
                                () {},
                              );
                              return;
                            }
                            if (phone.length < 9) {
                              ValidationDialog.show(
                                context,
                                "Le numéro doit contenir au moins 9 caractères.",
                                () {},
                              );
                              return;
                            }
                           

                            // Vérification de la connexion Internet
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

                            TransAcademiaLoadingDialog.show(context);

                            Map dataSignup = {
                              "nom": state.field!["nom"],
                              "prenom": state.field!["prenom"],
                              "telephone": state.field!["phone"],
                              "adresse": state.field!["adresse"],
                              "email": state.field!["email"],

                             // "pwd": state.field!["password"],
                            };

                            print(dataSignup);

                            var response = await SignUpRepository.signup(
                                dataSignup, context);

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
                                    '/login', (Route<dynamic> route) => false);
                              });
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
                            child: ButtonTransAcademia(title: "S'inscrire"),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Vous avez un compte ? ",
                            style: GoogleFonts.montserrat(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Connectez-vous",
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
