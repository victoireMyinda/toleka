import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CardNotification extends StatefulWidget {
  Map? data;

 CardNotification({super.key, this.data});

  @override
  State<CardNotification> createState() => _CardNotificationState();
}

class _CardNotificationState extends State<CardNotification> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(15),
        decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/notificationkelasi.svg",
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 10),
                     const Text(
                      "Infos bus",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                 Text(widget.data!["last_update"],
                    style: const TextStyle(fontWeight: FontWeight.w300)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children:  [
                Expanded(
                  child: Text(
                    widget.data!["content"],
                    style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
