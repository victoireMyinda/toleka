import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/screens/gestionenfant/signupenfant/signupenfant-identite.dart';
import 'package:toleka/presentation/screens/gestionenfant/widgets/cardlistPlaceholder.dart';
import 'package:toleka/presentation/screens/gestionenfant/widgets/cardlistenfantnonatif.dart';
import 'package:toleka/presentation/screens/personneref/signupstep1.dart';
import 'package:toleka/presentation/widgets/appbarkelasi.dart';
import 'package:toleka/theme.dart';

class EnfantsInactifs extends StatefulWidget {
  final bool backNavigation;
  bool fromSingup = false;
  EnfantsInactifs(
      {super.key, required this.backNavigation, required this.fromSingup});

  @override
  State<EnfantsInactifs> createState() => _EnfantsInactifsState();
}

class _EnfantsInactifsState extends State<EnfantsInactifs> {
  List? dataPersonRef = [];
  List? dataStudent = [];
  bool isLoading = true;
  int dataStudentLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    loadPersonneRef();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idParent = prefs.getString("parentId");

    Map? response =
        await SignUpRepository.getEnfantsDuParent(idParent.toString());
    List? student = response["data"]["recorded"];

    // print(response["data"]);
    setState(() {
      dataStudent = student;
      isLoading = false;
      dataStudentLength = student!.length;
      // dataStudent = student.reversed.toList(); // Inversion de l'ordre
    });
  }

  void loadPersonneRef() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idParent = prefs.getString("parentId");

    if (idParent != null && idParent.isNotEmpty) {
      Map? response = await SignUpRepository.getPersonneRefByParent(idParent.toString());
      List? personneRef = response["data"];

      setState(() {
        dataPersonRef = personneRef;
      });
    } else {
      print("idParent is null or empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: Colors.white,
      color: Colors.blueAccent,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));
        loadData();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarKelasi(
            backgroundColor: Colors.white,
            title: "Enfants enregistrés et non actifs",
            icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            onTapFunction: () {
              if (widget.fromSingup == true) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/routestackkelasi', (Route<dynamic> route) => false);
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
          floatingActionButton: InkWell(
            onTap: () {
              dataPersonRef?.length == 0
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PersonneRefSignup1()),
                    )
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupEnfantStep1()),
                    );
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff129BFF),
                    kelasiColor,
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 245, 244, 244),
          body: Column(
            children: [
              // Container(
              //   height: 180,
              //   width: 500,
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       colors: [
              //         const Color(0xff129BFF),
              //         kelasiColor,
              //       ],
              //     ),
              //     // border: Border.all(width: 1, color: kelasiColor),
              //     borderRadius: const BorderRadius.only(
              //       bottomLeft: Radius.circular(20),
              //       bottomRight: Radius.circular(20),
              //     ),
              //   ),
              //   child: Column(
              //     children: [
              //       const SizedBox(
              //         height: 20,
              //       ),
              //       SvgPicture.asset(
              //         "assets/icons/avatarkelasi.svg",
              //         width: 70,
              //         color: Colors.white,
              //       ),
              //       const SizedBox(height: 20),
              //       BlocBuilder<SignupCubit, SignupState>(
              //         builder: (context, state) {
              //           return Text(
              //             "${state.field!["nomparentcomplet"]}",
              //             style: const TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 20,
              //             ),
              //           );
              //         },
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               dataStudent!.length.toString(),
              //               style: const TextStyle(
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.white,
              //                   fontSize: 25),
              //             ),
              //             const SizedBox(
              //               width: 10,
              //             ),
              //             const Text(
              //               "Enfants enregistrés.",
              //               style: TextStyle(
              //                 fontWeight: FontWeight.w500,
              //                 color: Colors.white,
              //               ),
              //             ),
              //             const SizedBox(
              //               height: 20,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              isLoading == true
                  ? Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return const CardListEnfantPlaceholder();
                        },
                      ),
                    )
                  : dataStudentLength == 0
                      ? Center(
                          child: Column(
                            children: [
                              Lottie.asset(
                                  "assets/images/last-transaction.json",
                                  height: 200),
                              const Text("Aucun enfant n'a été enregistré."),
                            ],
                          ),
                        )
                      : Flexible(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: dataStudent!.length,
                            itemBuilder: (BuildContext context, index) {
                              return CardListEnfantNonActif(
                                  data: dataStudent![index]);
                            },
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
