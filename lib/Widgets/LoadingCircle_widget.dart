import 'package:flutter/cupertino.dart';
import 'package:loading_animations/loading_animations.dart';

Widget estadoDeCargaDePantalla(bool isLoading) {
  if (isLoading == true) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 350,
          ),
          LoadingFlipping.circle(
              borderSize: 40,
              size: 400,
              duration: Duration(milliseconds: 1000)),
        ],
      ),
    );
  } else {
    return Text("");
  }
}
