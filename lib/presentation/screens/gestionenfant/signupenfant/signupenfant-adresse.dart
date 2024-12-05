import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/presentation/screens/gestionenfant/signupenfant/signupenfant-ecole.dart';
import 'package:toleka/presentation/widgets/appbarkelasi.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownKelasi.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownSexe.dart';
import 'package:toleka/presentation/widgets/inputs/nameField.dart';
import 'package:toleka/presentation/widgets/stepIndicator.dart';
import 'package:toleka/sizeconfig.dart';
import 'package:toleka/theme.dart';

class SignupEnfantStep2 extends StatefulWidget {
  const SignupEnfantStep2({super.key});

  @override
  State<SignupEnfantStep2> createState() => _SignupEnfantStep2State();
}

class _SignupEnfantStep2State extends State<SignupEnfantStep2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SignupCubit>(context).loadCommunesKelasi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          title: "Enregistrement enfant",
          backgroundColor: Colors.white,
          icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          onTapFunction: () => Navigator.of(context).pop(),
        ),
        body: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height,
            // padding: const EdgeInsets.all(5),
            color: const Color(0xffF2F2F2),
            child: Column(
              children: [
                const SizedBox(height: 30,),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                   
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AdaptiveTheme.of(context).mode.name != "dark"
                              ? Colors.white
                              : Colors.black,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        // height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Vueillez renseigner l'adresse de l'enfant",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const TransAcademiaDropdownSexe(
                              value: "sexe",
                              label: "Choisir le sexe",
                              hintText: "choisir le sexe",
                            ),
                            const SizedBox(height: 20),
                            const TransAcademiaDropdownKelasi(
                              items: "communeDataKelasi",
                              value: "commune",
                              label: "Choisir la commune",
                              hintText: "Choisir la commune",
                            ),
                            const SizedBox(height: 20),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaNameInput(
                                      // controller: phoneController,
                                      hintText: "Avenue",
                                      field: "avenue",
                                      label: "Avenue",
                                      fieldValue: state.field!["avenue"],
                                    ),
                                  ));
                            }),
                            const SizedBox(height: 10),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaNameInput(
                                      // controller: phoneController,
                                      hintText: "numero",
                                      field: "numero",
                                      label: "Numero",
                                      fieldValue: state.field!["numero"],
                                    ),
                                  ));
                            }),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const StepIndicatorWidget(
                                  color: Colors.black26,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                StepIndicatorWidget(
                                  color: kelasiColor,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                const StepIndicatorWidget(
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BlocBuilder<SignupCubit, SignupState>(
                                      builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignupEnfantStep3()),
                                        );
                                      },
                                      child: const ButtonTransAcademia(
                                          width: 300, title: "Suivant"),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(30),
                            ),
                          ],
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
    );
  }
}
