// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:toleka/presentation/screens/gestionenfant/detailenfant.dart';
import 'package:toleka/presentation/widgets/imageview.dart';

class CardListEnfantPlaceholder extends StatefulWidget {
  const CardListEnfantPlaceholder({super.key});

  @override
  State<CardListEnfantPlaceholder> createState() => _CardListEnfantPlaceholderState();
}

class _CardListEnfantPlaceholderState extends State<CardListEnfantPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
                  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailEnfant()),
          );
        
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 100,
          // width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                ImageViewerWidget(
                  url:
                      "",
                  width: 55,
                  height: 55,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ]),
              const Spacer(),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 115,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImageViewerWidget(url: "", height: 10, width: 200, borderRadius: BorderRadius.circular(10),),
                        ImageViewerWidget(url: "", height: 20, width: 40, borderRadius: BorderRadius.circular(10),),
                        // Container(
                        //   padding: const EdgeInsets.all(5),
                        //   decoration: const BoxDecoration(
                        //     color: Color.fromARGB(255, 237, 236, 236),
                        //     borderRadius: BorderRadius.all(Radius.circular(25)),
                        //   ),
                        //   child: const Text("Abonné",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           color: Colors.green,
                        //           fontSize: 11)),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width - 115,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImageViewerWidget(url: "", height: 10, width: 100, borderRadius: BorderRadius.circular(10),),
                        ImageViewerWidget(url: "", height: 10, width: 100, borderRadius: BorderRadius.circular(10),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width - 115,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width - 115,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImageViewerWidget(url: "", height: 10, width: 200, borderRadius: BorderRadius.circular(10),),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
