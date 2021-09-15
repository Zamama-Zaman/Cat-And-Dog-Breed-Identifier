// ignore_for_file: prefer_const_constructors

import 'package:cat_and_dog_breed_identifier/pages/dog_breed/dog_live_stream.dart';
import 'package:cat_and_dog_breed_identifier/pages/dog_breed/dog_local.dart';
import 'package:cat_and_dog_breed_identifier/pages/dog_breed/dog_static_pic.dart';
import 'package:flutter/material.dart';

class DogBreed extends StatelessWidget {
  const DogBreed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.green.withOpacity(0.6),
        title: Text(
          'Dog Breed',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Image.asset(
                'assets/images/logo_dog.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DogLiveStream(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Live Stream',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "gilroy",
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DogLocal(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'From Gallery',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "gilroy",
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DogStatic(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Take Image',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "gilroy",
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
