// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:toleka/presentation/widgets/imageview.dart';

class CardHistoriqueTransanctionPlaceholder extends StatefulWidget {
  const CardHistoriqueTransanctionPlaceholder({super.key});

  @override
  State<CardHistoriqueTransanctionPlaceholder> createState() =>
      _CardHistoriqueTransanctionPlaceholderState();
}

class _CardHistoriqueTransanctionPlaceholderState
    extends State<CardHistoriqueTransanctionPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return Container(
     margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
      padding: const EdgeInsets.all(20.0),
      height: 220,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 220, 230, 247),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black,
        //     spreadRadius: 1,
        //     blurRadius: 1,
        //     offset: const Offset(0, 1),
        //   ),
        // ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           const ImageViewerWidget(width: 150,  height: 20, url: "", borderRadius: BorderRadius.all(Radius.circular(10)), ),
        //  const  Center(child:  Text("Transaction effectué par Airtel", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),)),
        const  Divider(thickness: 1,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text("icon"),
               Row(
                children: const [
                       ImageViewerWidget(width: 100,  height: 20, url: "", borderRadius: BorderRadius.all(Radius.circular(10))),
                  // Text(
                  //   "Date",
                  //   style: TextStyle(fontWeight: FontWeight.w500),
                  // )
                ],
              ),
              const ImageViewerWidget(width: 100,  height: 20, url: "", borderRadius: BorderRadius.all(Radius.circular(10))),
              // Text(
              //   "${widget.data!["last_update"]}",
              //   style: const TextStyle(fontWeight: FontWeight.w500),
              // ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const  [
                 ImageViewerWidget(width: 100,  height: 20, url: "",borderRadius: BorderRadius.all(Radius.circular(10))),
              //  const Text(
              //   "Nom",
              //   style: TextStyle(
              //       // color: Colors.blueGrey,
              //       ),
              // ),
              // Text(
               
              //   "${widget.data!["parent_firstname"]} ${widget.data!["parent_lastname"]}",
              //   style:  const TextStyle(fontWeight: FontWeight.w500),
              // ),
                 ImageViewerWidget(width: 100,  height: 20, url: "", borderRadius: BorderRadius.all(Radius.circular(10))),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const  [
                 ImageViewerWidget(width: 100,  height: 20, url: "", borderRadius: BorderRadius.all(Radius.circular(10))),
                    ImageViewerWidget(width: 100,  height: 20, url: "", borderRadius: BorderRadius.all(Radius.circular(10))),
              // const Text(
              //   "Montant",
              //   style: TextStyle(),
              // ),
              // Text(
              //   "${widget.data!["amount"]} Fc",
              //   // style: TextStyle(color: Colors.blueGrey),
              // ),
            ],
          ),
           const  Divider(thickness: 1,),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
                 ImageViewerWidget(width: 100,  height: 20, url: "", borderRadius: BorderRadius.all(Radius.circular(10))),
              // const Text(
              //   "Statut",
              //   style: TextStyle(
              //       // color: Colors.blueGrey,
              //       ),
              // ),
              Center(
                child:    ImageViewerWidget(width: 100,  height: 20, url: "",borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
