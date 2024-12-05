import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toleka/theme.dart';


class RecipeDetailAppBarLogin extends StatefulWidget {
  final String? image, date;
  final double? height;
  const RecipeDetailAppBarLogin({Key? key, this.image, this.date, this.height}) : super(key: key);

  @override
  State<RecipeDetailAppBarLogin> createState() => _RecipeDetailAppBarLoginState();
}

class _RecipeDetailAppBarLoginState extends State<RecipeDetailAppBarLogin> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      expandedHeight: widget.height??200.0,
      backgroundColor: Colors.white,
      elevation: 0.0,
      // title: Text("data"),
      pinned: true,
      stretch: true,
      // flexibleSpace: const  ImageViewerWidget(
      //   height: 500.0,
      //   width: 600.0,
      //   url: "https://res.cloudinary.com/deb9kfhnx/image/upload/v1715355976/lei14bohqmkzdkmrsiw8.webp",
      //   // borderRadius: BorderRadius.circular(20.0),
      //   // border: Border.all(width: 5, color: Color(0xFFffa020)),
      // ),

      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
         "assets/images/cover.webp",
          fit: BoxFit.cover,
        ),
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground,
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: Container(
          height: 32.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0),
            ),
          ),
          child: Container(
            width: 40.0,
            height: 5.0,
            decoration: BoxDecoration(
              color: kelasiColor,
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
        ),
      ),
     
    
    );
  }
}



