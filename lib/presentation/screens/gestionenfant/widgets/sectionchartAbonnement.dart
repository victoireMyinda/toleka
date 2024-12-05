import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/theme.dart';

class SectionChartAbonnement extends StatefulWidget {
  const SectionChartAbonnement({super.key});

  @override
  State<SectionChartAbonnement> createState() => _SectionChartAbonnementState();
}

class _SectionChartAbonnementState extends State<SectionChartAbonnement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                width: 100,
                child: Text(
                  "Abonnements en cours",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              BlocBuilder<SignupCubit, SignupState>(
                builder: (context, state) {
                  return Text(
                    "0/${state.field!["nombreEnfant"]}",
                    style: TextStyle(
                        color: kelasiColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  );
                },
              ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                width: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        SizedBox(
                            width: 120,
                            child: Text(
                              "Enfants abonnés: 0",
                              style: TextStyle(fontSize: 11),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: 120,
                            child: BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return Text(
                                  "Enfants non abonnés: ${state.field!["nombreEnfant"]}",
                                  style: const TextStyle(fontSize: 11),
                                );
                              },
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
