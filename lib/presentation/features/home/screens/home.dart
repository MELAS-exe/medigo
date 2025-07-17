import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 100,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/logo-medigo.png", height: 48,),
                        GestureDetector(
                          child: Image.asset("assets/menu.png", height: 24,),
                        )
                      ],
                                ),
                  ),
                ))
          ]
        ),
      ),
    );
  }
}