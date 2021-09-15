// ignore_for_file: unnecessary_string_interpolations, prefer_final_fields, prefer_const_constructors

import 'dart:io';

import 'package:cat_and_dog_breed_identifier/app_const/app_colors.dart';
import 'package:cat_and_dog_breed_identifier/app_const/icons.dart';
import 'package:cat_and_dog_breed_identifier/app_const/strings.dart';
import 'package:cat_and_dog_breed_identifier/services/tensor_flow_lite_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CatLocal extends StatefulWidget {
  const CatLocal({Key? key}) : super(key: key);

  @override
  _CatLocalState createState() => _CatLocalState();
}

class _CatLocalState extends State<CatLocal> {
  final TensorFlowServices _tensorFlowServices = TensorFlowServices();
  File? _image;
  bool _loading = false;
  List? _recognitions;
  ImagePicker _picker = ImagePicker();
  String text = "";
  PickedFile? _imageFile;
  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    _tensorFlowServices.loadModelForCats();
  }

  selectImage() async {
    _imageFile = await _picker.getImage(source: ImageSource.gallery);
    if (_imageFile == null) return;
    setState(() {
      _loading = true;
      _image = File(_imageFile!.path);
    });
    predictImage(_image!);
  }

  predictImage(File image) async {
    var recognitions = await _tensorFlowServices.predictImage(image);
    setState(() {
      _loading = false;
      _recognitions = recognitions;

      //  if (_recognitions!.isEmpty) {
      //   text = 'Invalid';
      // } else {
      //   text = _recognitions![0][labelString];
      // }

      text = _recognitions![0][labelString];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          imageIcon,
          color: Colors.green,
        ),
        tooltip: pickIFG,
        backgroundColor: Colors.white,
        onPressed: selectImage,
      ),
      body: _loading
          ? Container(
              color: Colors.greenAccent,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : Container(
              color: Colors.green.withOpacity(0.4),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _image == null
                      // ignore: avoid_unnecessary_containers
                      ? Container(
                          child: const Text(
                            selectImageP,
                            style: TextStyle(
                              fontSize: 20,
                              color: green,
                              fontFamily: "gilroy",
                            ),
                          ),
                        )
                      : Image.file(
                          _image!,
                          height: MediaQuery.of(context).size.height / 2 + 60,
                          width: MediaQuery.of(context).size.width - 80,
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  _recognitions != null
                      ? Text(
                          "$text",
                          style: TextStyle(
                              color: green,
                              fontSize: 20.0,
                              fontFamily: "gilroy"),
                        )
                      : Container()
                ],
              ),
            ),
    );
  }
}
