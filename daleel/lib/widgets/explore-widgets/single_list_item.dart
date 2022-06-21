import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';

class SingleListItem extends StatelessWidget {
  String? title;
  String? category;
  String? image;

  SingleListItem({this.category,this.image,this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left:10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 170,
            width: 150,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      (image!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Container(
                      color: Colors.black38,
                      height: 70,
                      width: 190,
                      alignment: Alignment.center,
                      child: ListTile(
                        title: Text(
                          title!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        subtitle: Text(
                          category!,
                          style: const TextStyle(color: Colors.yellow, fontSize: 17),
                        ),
                      )),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
