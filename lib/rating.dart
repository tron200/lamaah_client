import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rating extends StatelessWidget{
  double value;
  Rating ({required this.value});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(value >= 1? Icons.star: value >= 0.5?Icons.star_half: Icons.star_border, color: Colors.yellowAccent,),
        Icon(value >= 2? Icons.star: value >= 1.5?Icons.star_half: Icons.star_border, color: Colors.yellowAccent,),
        Icon(value >= 3? Icons.star: value >= 2.5?Icons.star_half: Icons.star_border, color: Colors.yellowAccent,),
        Icon(value >= 4? Icons.star: value >= 3.5?Icons.star_half: Icons.star_border, color: Colors.yellowAccent,),
        Icon(value >= 5? Icons.star: value >= 4.5?Icons.star_half: Icons.star_border, color: Colors.yellowAccent,),

      ],
    );
  }
}