import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daleel/providers/places.dart';

class ImageCard extends StatefulWidget {
  ImageCard({this.image, this.onTap, this.category, this.title});

  final String? image;
  final String? title;
  final String? category;
  final Function()? onTap;

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [
              Container(
                child: Image.network((widget.image!), fit: BoxFit.cover),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black26,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 5,
                left: 5,
                // right: 10,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.category!,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow[200]),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                        thickness: 0.7,
                        width: 20,
                      ),
                      Flexible(
                        child: Text(
                          widget.title!,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //     bottom: 7,
              //     right: 15,
              //     child: Row(
              //       children: [
              //         Stack(children: [
              //           Positioned(
              //             left: 2.0,
              //             top: 1.0,
              //             child: Icon(
              //               Icons.star,
              //               color: Colors.black,
              //             ),
              //           ),
              //           Icon(
              //             Icons.star,
              //             color: Colors.yellow,
              //           ),
              //         ]),
              //         Text(
              //           '3.5',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontWeight: FontWeight.bold,
              //             shadows: [
              //               Shadow(blurRadius: 7, color: Colors.black),
              //             ],
              //           ),
              //         )
              //       ],
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
