// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:toleka/presentation/widgets/dialog/loading.dialog.dart';
import 'package:toleka/theme.dart';

class CardHistoriqueTransanction extends StatefulWidget {
  final Map? data;
  const CardHistoriqueTransanction({super.key, this.data});

  @override
  State<CardHistoriqueTransanction> createState() =>
      _CardHistoriqueTransanctionState();
}

class _CardHistoriqueTransanctionState
    extends State<CardHistoriqueTransanction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      padding: const EdgeInsets.all(12.0),
      height: 220,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 220, 230, 247),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "${widget.data!["operateur_id"]["libele"]}",
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          )),
          const Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text("icon"),
              Row(
                children: const [
                  Text(
                    "Date",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  )
                ],
              ),
              Text(
                "${widget.data!["last_update"]}",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Parent",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                "${widget.data!["parent"]["prenom"]} ${widget.data!["parent"]["nom"]}",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Enfant",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                "${widget.data!["student_rf"]["prenom"]} ${widget.data!["student_rf"]["nom"]}",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total payé",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                "${widget.data!["amount"]} Fc",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Statut",
                style: TextStyle(
                    // color: Colors.blueGrey,
                    fontSize: 12),
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 100,
                  decoration: BoxDecoration(
                    // color: Colors.black26,
                    border: Border.all(
                      color: widget.data!["status"] == "pending"
                          ? Colors.blue
                          : widget.data!["status"] == "success"
                              ? Colors.green
                              : const Color.fromARGB(255, 228, 30, 30),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        //   if (widget.data!["status"] == "pending") {
                        //     TransAcademiaLoadingDialog.show(context);

                        //     Map data = {
                        //       "status": widget.data!["status"],
                        //       "id": widget.data!["transaction_rf"]
                        //     };

                        //     // print(data);

                        //     Map? response =
                        //         await SignUpRepository.activePayment(data);

                        //     // print(response);
                        //     String? messageSucces = response['message'];

                        //     if (response['status'] == 200) {
                        //       TransAcademiaLoadingDialog.stop(context);
                        //       TransAcademiaDialogSuccess.show(
                        //           context, messageSucces, "Auth");
                        //       Future.delayed(const Duration(milliseconds: 4000),
                        //           () {
                        //         TransAcademiaDialogSuccess.stop(context);
                        //       });
                        //     } else {
                        //       TransAcademiaLoadingDialog.stop(context);
                        //       TransAcademiaDialogError.show(
                        //           context, messageSucces, "activation payement");
                        //     }
                        //   }
                      },
                      child: Text(
                        widget.data!["status"] == "pending"
                            ? 'En attente'
                            : widget.data!["status"] == "success"
                                ? "Success"
                                : "Echoué",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
