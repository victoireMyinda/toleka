// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardDetailEnfant extends StatefulWidget {
  final String? title, content;
  final double? width;
  final String? icon;

  const CardDetailEnfant(
      {super.key, this.width, this.title, this.content, this.icon});

  @override
  State<CardDetailEnfant> createState() => _CardDetailEnfantState();
}

class _CardDetailEnfantState extends State<CardDetailEnfant> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 239, 239, 239),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            widget.icon.toString(),
            width: 20,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.width == MediaQuery.of(context).size.width
                  ? Text(
                      widget.title.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : SizedBox(
                      width: 100,
                      child: Text(
                        maxLines: 2,
                        widget.title.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              SizedBox(
                height: 5,
              ),
              widget.width == MediaQuery.of(context).size.width
                  ? Text(
                      widget.content.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  : SizedBox(
                      width: 100,
                      child: Text(
                        maxLines: 2,
                        widget.content.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
