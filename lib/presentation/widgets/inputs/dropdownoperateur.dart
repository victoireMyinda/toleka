import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/theme.dart';

class KelasiDropdownOperateur extends StatefulWidget {
  const KelasiDropdownOperateur(
      {super.key,
      this.controller,
      this.value,
      this.color,
      this.label,
      this.hintText,
      this.validator,
      this.items,
      this.number});
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  final int? number;
  final String? label;
  final String? value;
  final String? items;
  @override
  _KelasiDropdownOperateurState createState() =>
      _KelasiDropdownOperateurState();
}

class _KelasiDropdownOperateurState extends State<KelasiDropdownOperateur> {
  String? labelForDropdown;

  @override
  void initState() {
    super.initState();

    if (widget.value == "operateur") {
      labelForDropdown = "libele";
    }
  }

  bool isOperatorAvailable(String operatorId) {
    return operatorId == "1" || operatorId == "3"; // MPSA (1) and AIRTEL (3) are available
  }

  void showUnavailableOperatorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Paiement non disponible"),
          content: const Text("Veuillez sélectionner MPSA ou AIRTEL."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              return DropdownButtonFormField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 20.0),
                  label: Text(widget.label.toString()),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                ),
                dropdownColor: AdaptiveTheme.of(context).mode.name == "dark"
                    ? Colors.black
                    : Colors.white,
                value: state.field![widget.value] == ""
                    ? null
                    : state.field![widget.value],
                onChanged: (newValue) {
                  if (!isOperatorAvailable(newValue.toString())) {
                    showUnavailableOperatorDialog(context);
                  } else {
                    BlocProvider.of<SignupCubit>(context).updateField(context,
                        field: widget.value.toString(),
                        data: newValue.toString());
                  }
                },
                items: state.field![widget.items]
                    .map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem<String>(
                    value: widget.value == "operateur"
                        ? item['id'].toString()
                        : item['libele'],
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: kelasiColor),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/${item["libele"].toLowerCase()}.webp'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          item[labelForDropdown],
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                selectedItemBuilder: (BuildContext context) {
                  return state.field![widget.items]
                      .map<Widget>((item) {
                    return Row(
                      children: [
                        const SizedBox(width: 10),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: kelasiColor),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/${item["libele"].toLowerCase()}.webp'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Text(
                          item[labelForDropdown],
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    );
                  }).toList();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
