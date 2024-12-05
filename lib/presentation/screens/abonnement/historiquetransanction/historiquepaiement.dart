import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/screens/abonnement/historiquetransanction/widget/cardhistorique.dart';
import 'package:toleka/presentation/screens/abonnement/historiquetransanction/widget/cardhistoriquePlaceholder.dart';
import 'package:toleka/presentation/widgets/appbarkelasi.dart';

class HistoriqueTransanction extends StatefulWidget {
  bool? isHome;
  final bool backNavigation;
  bool fromSingup = false;

  HistoriqueTransanction(
      {Key? key,
      this.isHome,
      required this.backNavigation,
      required this.fromSingup})
      : super(key: key);

  @override
  State<HistoriqueTransanction> createState() => _HistoriqueTransanctionState();
}

class _HistoriqueTransanctionState extends State<HistoriqueTransanction> {
  List? dataTransaction = [];
  bool isLoading = false;
  int dataStudentLength = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString("parentuuid");
    Map? response = await SignUpRepository.getTransactonById(idUser.toString());
    List? result = response["data"];

    setState(() {
      dataTransaction = result;
      isLoading = false;
      dataStudentLength = result!.length;
      dataTransaction = result.reversed.take(10).toList();
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
        await fetchData();
        //  print("Request");
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarKelasi(
            title: "Historique transanctions",
            icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            // color: Colors.white,
            visibleAvatar: false,
            onTapFunction: () => Navigator.of(context).pushNamedAndRemoveUntil(
                '/routestackkelasi', (Route<dynamic> route) => false),
          ),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Actualiser par glissement vers le bas",
                    style: TextStyle(fontSize: 14),
                  ),
                  const Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 50,
                    color: Colors.grey,
                  ),
                  // const SizedBox(height: 50,),
                  isLoading
                      ? Flexible(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return const CardHistoriqueTransanctionPlaceholder();
                            },
                          ),
                        )
                      : Flexible(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: dataTransaction!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CardHistoriqueTransanction(
                                data: dataTransaction![index],
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
