import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/screens/gestionenfant/widgets/cardlistPlaceholder.dart';
import 'package:toleka/presentation/screens/notification/cardnotification.dart';
import 'package:toleka/presentation/widgets/appbarkelasi.dart';

class Notifications extends StatefulWidget {
  final bool backNavigation;
  const Notifications({
    super.key, required this.backNavigation
  });

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List? dataNotification = [];
  bool isLoading = true;
  int dataNotificationLength = 0;

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
        await SignUpRepository.getNotification(idParent);
    List? notification = response["data"];

    // print(response["data"]);
    setState(() {
      dataNotification = notification;
      isLoading = false;
      dataNotificationLength = notification!.length;
      dataNotification = notification.toList();
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
            title: "Notifications",
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
         
          backgroundColor: const Color.fromARGB(255, 245, 244, 244),
          body: Column(
            children: [
             
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
                  : dataNotificationLength == 0
                      ? Center(
                        child: Column(
                            children: [
                              Lottie.asset("assets/images/last-transaction.json",
                                  height: 200),
                              const Text(
                                  "Aucune notification disponible."),
                            ],
                          ),
                      )
                      : Flexible(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: dataNotification!.length,
                            itemBuilder: (BuildContext context, index) {
                              return CardNotification(
                                  data: dataNotification![index]);
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
