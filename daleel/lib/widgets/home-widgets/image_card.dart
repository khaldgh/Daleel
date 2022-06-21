import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daleel/providers/places.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({this.image, this.onTap, this.category, this.title});

  final String? image;
  final String? title;
  final String? category;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [
              Container(
                child: Image.network((image!), fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 1.0,
                right: 0.0,
                left: 0.0,
                  child: Container(
                color: Colors.white24,
                height: 30,
              )),
              Positioned(
                bottom: 10,
                left: 10,
                child: Text(
                  category!,
                  style: TextStyle(
                    fontSize: 20,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.teal,
                      color: Colors.white),
                ),
              ),
              Positioned(
                  bottom: 7,
                  right: 15,
                  child: Row(
                    children: [
                      Stack(children: [
                        Positioned(
                          left: 2.0,
                          top: 1.0,
                          child: Icon(
                            Icons.star,
                            color: Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ]),
                      Text(
                        '3.5',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(blurRadius: 7, color: Colors.black),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
