import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/screens/gestionenfant/widgets/cardlistPlaceholder.dart';
import 'package:toleka/presentation/screens/personneref/signupstep1.dart';
import 'package:toleka/presentation/screens/personneref/widget/cardPersonRef.dart';
import 'package:toleka/presentation/widgets/appbarkelasi.dart';
import 'package:toleka/theme.dart';

class PersonneDeReference extends StatefulWidget {
  // final bool backNavigation;
  // bool fromSingup = false;
  PersonneDeReference({
    super.key,
  });

  @override
  State<PersonneDeReference> createState() => _PersonneDeReferenceState();
}

class _PersonneDeReferenceState extends State<PersonneDeReference> {
  List? dataPersonRef = [];
  bool isLoading = true;
  int dataPersonRefLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idParent = prefs.getString("parentId");

    Map? response =
        await SignUpRepository.getPersonneRefByParent(idParent);
    List? student = response["data"];

    // print(response["data"]);
    setState(() {
      dataPersonRef = student;
      isLoading = false;
      dataPersonRefLength = student!.length;
      dataPersonRef = student.toList();
    });
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
            title: "Personnes des references",
            icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            onTapFunction: () {
              Navigator.of(context).pop();
              // if (widget.fromSingup == true) {
              //   Navigator.of(context).pushNamedAndRemoveUntil(
              //       '/routestackkelasi', (Route<dynamic> route) => false);
              // } else {
              //   Navigator.of(context).pop();
              // }
            },
          ),
          floatingActionButton: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PersonneRefSignup1()),
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
                borderRadius: const BorderRadius.all(Radius.circular(50)),
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
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff129BFF),
                      kelasiColor,
                    ],
                  ),
                  // border: Border.all(width: 1, color: kelasiColor),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(
                      "assets/icons/avatarkelasi.svg",
                      width: 70,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Text(
                          "${state.field!["nomparentcomplet"]}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dataPersonRef!.length.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 25),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Personnes de references.",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                  : dataPersonRefLength == 0
                      ? Column(
                          children: [
                            Lottie.asset("assets/images/last-transaction.json",
                                height: 200),
                            const Text(
                                "Aucune personne de reference enregistrée."),
                          ],
                        )
                      : Flexible(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: dataPersonRef!.length,
                            itemBuilder: (BuildContext context, index) {
                              return CardPersonneRef(
                                  data: dataPersonRef![index]);
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
