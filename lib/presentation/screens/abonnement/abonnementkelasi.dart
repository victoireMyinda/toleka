// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:toleka/presentation/screens/abonnement/historiquetransanction/historiquepaiement.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownenfant.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownoperateur.dart';
import 'package:toast/toast.dart';
import 'package:toleka/business_logic/cubit/abonnement/cubit/abonnement_cubit.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:toleka/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:toleka/presentation/widgets/dialog/loading.dialog.dart';
import 'package:toleka/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:toleka/theme.dart';

class AbonnementKelasi extends StatefulWidget {
  List? data = [];
  final bool backNavigation;

  AbonnementKelasi({Key? key, this.data, required this.backNavigation})
      : super(key: key);

  @override
  State<AbonnementKelasi> createState() => _AbonnementKelasiState();
}

class _AbonnementKelasiState extends State<AbonnementKelasi> {
  final TextEditingController phoneController = TextEditingController();
  bool selectBank = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //state for input select
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();
  int paymentMethod = 1;
  Timer? _timer;

  List<String> selectedServices = [];
  List<MultiSelectItem<String>> _items = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SignupCubit>(context).loadEnfant();
    BlocProvider.of<SignupCubit>(context).loadOperateurKelasi();
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "currency", data: "");

    getDataServices();
    // getProfilAgent();
  }

  void getDataServices() {
    // Récupère l'état actuel du SignupCubit
    final currentState = context.read<SignupCubit>().state;

    // Vérifie si l'état contient les données nécessaires
    if (currentState.field != null) {
      var servicesDataKelasi = currentState.field!["serviceDataKelasi"];

      // Vérifie si servicesDataKelasi est une liste
      if (servicesDataKelasi is List) {
        _items = servicesDataKelasi
          .where((service) => service["type_service"].toLowerCase() != "prélèvement")
            .map((service) {
          double prix = double.parse(service["prix"].toString());

          String displayText = "${service["type_service"]} : ${prix} FC";

          return MultiSelectItem<String>(
            service["id"].toString(),
            displayText,
          );
        }).toList();
      } else {
        // Gérer le cas où servicesDataKelasi n'est pas une liste
        print("Les données de serviceDataKelasi ne sont pas une liste.");
      }
    } else {
      // Gérer le cas où les données ne sont pas disponibles
      print("Les données de serviceDataKelasi ne sont pas disponibles.");
    }
  }


  double calculateTotalPrice() {
    double total = 0.0;

    for (var serviceId in selectedServices) {
      var service = widget.data!.firstWhere(
          (element) => element["id"] == serviceId,
          orElse: () => null);

      if (service != null) {
        double prix = service["prix"] != null
            ? double.parse(service["prix"].toString())
            : 0.0;

        total += prix;
      }
    }

    return total;
  }

  // getProfilAgent() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   BlocProvider.of<SignupCubit>(context)
  //       .updateField(context, field: "currency", data: "");
  //   BlocProvider.of<SignupCubit>(context).updateField(context,
  //       field: "idAgent", data: prefs.getString('idAgent'));
  //   BlocProvider.of<SignupCubit>(context)
  //       .updateField(context, field: "idUser", data: prefs.getString('id'));
  // }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    // totalAmount = 0.0;
    ToastContext().init(context);
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: Colors.white,
      color: Colors.blueAccent,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));
        BlocProvider.of<AbonnementCubit>(context).initFormPayment();
        BlocProvider.of<AbonnementCubit>(context).initForm();
      },
      child: Scaffold(
          // backgroundColor: Colors.grey.withOpacity(0.1),
          body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            // color: Colors.grey.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            // padding: const EdgeInsets.all(20.0),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const SizedBox(height: 50,),
                  const Text(
                    "Merci de renseigner tous les champs",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          MultiSelectDialogField(
                            items: _items,
                            //  initialValue: [],

                            title: const Text('Tous les services'),
                            selectedColor: kelasiColor,
                            buttonText: const Text('Selectionner les Services'),
                            onConfirm: (results) {
                              setState(() {
                                selectedServices = List<String>.from(results);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(15),
                  //   child: Column(
                  //     children: [
                  //       const Divider(
                  //         thickness: 1,
                  //       ),
                  //       const SizedBox(
                  //         height: 10,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           const Text("Prix total : "),
                  //           Text("${calculateTotalPrice()} FC"),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const kelasiDropdownEnfant(
                    items: "enfantData",
                    value: "enfant",
                    label: "Selectionner l'enfant",
                    hintText: "Selectionner l'enfant",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const KelasiDropdownOperateur(
                    items: "operateurData",
                    value: "operateur",
                    label: "Choisir l'operateur",
                    hintText: "Choisir l'operateur",
                  ),
                  Column(
                    children: [
                      BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                        return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 15, top: 20),
                            child: SizedBox(
                              height: 50.0,
                              child: TransAcademiaPhoneNumber(
                                number: 20,
                                controller: phoneController,
                                hintText: "Numéro de téléphone",
                                field: "phonePayement",
                                fieldValue: state.field!["phonePayement"],
                              ),
                            ));
                      }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  RoundCheckBox(
                                    onTap: (selected) {
                                      BlocProvider.of<SignupCubit>(context)
                                          .updateField(context,
                                              field: "currency", data: "1");
                                    },
                                    size: 25,
                                    checkedColor: primaryColor,
                                    isChecked: state.field!["currency"] == "1"
                                        ? true
                                        : false,
                                    animationDuration: const Duration(
                                      milliseconds: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  const Text("USD")
                                ],
                              ),
                              Row(
                                children: [
                                  RoundCheckBox(
                                    onTap: (selected) {
                                      BlocProvider.of<SignupCubit>(context)
                                          .updateField(context,
                                              field: "currency", data: "2");
                                    },
                                    size: 25,
                                    checkedColor: primaryColor,
                                    isChecked: state.field!["currency"] == "2"
                                        ? true
                                        : false,
                                    animationDuration: const Duration(
                                      milliseconds: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  const Text("CDF")
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),

                      //button action

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<AbonnementCubit, AbonnementState>(
                            builder: (context, stateAbonnement) {
                              return BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                                  return GestureDetector(
                                    onTap: () async {
                                      if (selectedServices.isEmpty) {
                                        ValidationDialog.show(
                                          context,
                                          "Veuillez sélectionner au moins un service",
                                          () {
                                            print("modal");
                                          },
                                        );
                                        return;
                                      }
                                      if (state.field!["phonePayement"] == "") {
                                        ValidationDialog.show(context,
                                            "Veuillez saisir le numéro de téléphone",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }

                                      if (state.field!["currency"] == "") {
                                        ValidationDialog.show(context,
                                            "Veuillez choisir la devise", () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }

                                      if (state.field!["phonePayement"]
                                                  .substring(0, 2) ==
                                              "99" ||
                                          state.field!["phonePayement"]
                                                  .substring(0, 2) ==
                                              "98" ||
                                          state.field!["phonePayement"]
                                                  .substring(0, 2) ==
                                              "97" ||
                                          state.field!["phonePayement"]
                                                  .substring(0, 2) ==
                                              "80" ||
                                          state.field!["phonePayement"]
                                                  .substring(0, 2) ==
                                              "81" ||
                                          state.field!["phonePayement"]
                                                  .substring(0, 2) ==
                                              "82" ||
                                          state.field!["phonePayement"]
                                                  .substring(0, 2) ==
                                              "84" ||
                                          state.field!["phonePayement"]
                                                  .substring(0, 2) ==
                                              "85" ||
                                          state.field!["phonePayement"]
                                                  .substring(0, 2) ==
                                              "89" ||
                                          state.field!["phonePayement"]
                                                  .substring(0, 2) ==
                                              "90") {
                                        TransAcademiaLoadingDialog.show(
                                            context);

                                        Map<String, dynamic> data = {
                                          "currency": {
                                            "id": state.field!["currency"]
                                                .toString(),
                                            "acronym":
                                                state.field!["currency"] == "1"
                                                    ? "USD"
                                                    : "CDF"
                                          },
                                          "Id_op": state.field!["operateur"]
                                              .toString(),
                                          "Id_abonnement": 1,
                                          "walletID": state.field!["operateur"] == "1"
                                                ? "243${state.field!["phonePayement"]}"
                                                : state.field!["phonePayement"],
                                          "statusCode": "pending",
                                          "transactionDescription": "total",
                                          "source": "agent",
                                          "source_activation": "mobile",
                                          "Id_user_buy_at":
                                              state.field!["parentuuid"],
                                          "Id_user_created_at":
                                              state.field!["parentuuid"],
                                          "Id_student": state.field!["enfant"],
                                          "type_transaction": "mensuel | total",
                                          "services": selectedServices
                                              .map((serviceId) =>
                                                  int.parse(serviceId))
                                              .toList(),
                                        };

                                        print(data);

                                        Map? response = await SignUpRepository
                                            .payementKelasi(data, context);

                                        String? message = response["message"];

                                        if (response["status"] == 200) {
                                          TransAcademiaDialogSuccess.show(
                                              context, message, "Abonnement");

                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 4000),
                                              () async {
                                            TransAcademiaDialogSuccess.stop(
                                                context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HistoriqueTransanction(
                                                        backNavigation: true,
                                                        fromSingup: false,
                                                      )),
                                            );
                                          });
                                        } else if (response["status"] == 400) {
                                          TransAcademiaLoadingDialog.stop(
                                              context);
                                          TransAcademiaDialogError.show(
                                            context,
                                            message,
                                            "abonnement",
                                          );
                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 4000), () {
                                            TransAcademiaDialogError.stop(
                                                context);
                                          });
                                        } else {
                                          TransAcademiaLoadingDialog.stop(
                                              context);
                                          TransAcademiaDialogError.show(
                                              context, message, "login");
                                        }
                                      } else {
                                        ValidationDialog.show(context,
                                            "Veuillez saisir un numéro Airtel avec le format valide, par exemple: (996644420).",
                                            () {
                                          print("modal");
                                        });
                                        return;
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 320,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff204F97),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: const Text(
                                        "Payer",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        child: Container(
          child: Row(
            children: [
              logoContainer("assets/images/vodacom.webp"),
              logoContainer("assets/images/orange.webp"),
              logoContainer("assets/images/airtel.webp"),
              logoContainer("assets/images/afrimoney.webp"),
            ],
          ),
        ),
        value: "1"),
    DropdownMenuItem(
        child: Container(
          child: Row(
            children: [
              logoContainer("assets/images/logo-illico.webp"),
              const SizedBox(
                width: 20.0,
              ),
              const Text("Illicocash")
            ],
          ),
        ),
        value: "2"),
    DropdownMenuItem(
        child: Container(
          child: Row(
            children: [
              logoContainer("assets/images/visa.webp"),
              logoContainer("assets/images/mastercard.webp"),
              const SizedBox(
                width: 20.0,
              ),
              const Text("Visa ou Mastercard")
            ],
          ),
        ),
        value: "3"),
  ];
  return menuItems;
}

Container logoContainer(logo) {
  return Container(
    height: 50,
    width: 50,
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
      border: Border.all(color: Colors.blueAccent, width: 1),
      image: DecorationImage(
          fit: BoxFit.cover, image: AssetImage(logo.toString())),
    ),
  );
}
