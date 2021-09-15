// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_function_literals_in_foreach_calls

import 'package:camera/camera.dart';
import 'package:cat_and_dog_breed_identifier/main.dart';
import 'package:cat_and_dog_breed_identifier/services/tensor_flow_lite_services.dart';
import 'package:flutter/material.dart';

class CatLiveStream extends StatefulWidget {
  const CatLiveStream({Key? key}) : super(key: key);

  @override
  _CatLiveStreamState createState() => _CatLiveStreamState();
}

class _CatLiveStreamState extends State<CatLiveStream> {
  TensorFlowServices tensorFlowServices = TensorFlowServices();
  CameraImage? imgCamera;
  CameraController? cameraController;
  bool isWorking = false;
  String result = "";
  List<dynamic> _recognitions = [];

  get controller => null;

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (cameraController != null) {
        initCamera();
      }
    }
  }

  void _updateRecognitions({
    List<dynamic>? recognitions,
  }) {
    setState(() {
      _recognitions = recognitions!;
      result = '';
      setState(() {
        _recognitions.forEach((response) {
          result += response["label"] + "\n";
        });
      });
    });
  }

  initCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);

    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController!.startImageStream((image) {
          if (!isWorking) {
            isWorking = true;
            imgCamera = image;
            if (imgCamera != null) {
              tensorFlowServices
                  .runModelOnFrame(imgCamera!)
                  .then((List<dynamic> recognitions) {
                _updateRecognitions(
                  recognitions: recognitions,
                );
                isWorking = false;
              });
            }
          }
        });
      });
    });
  }

  @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    loadModel();
    initCamera();
    super.initState();
  }

  loadModel() async {
    await tensorFlowServices.loadModelForCats();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (!cameraController!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Center(
            child: Text(
              result,
              style: TextStyle(
                backgroundColor: Colors.black54,
                fontSize: 30,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: size.height - 80,
            child: CameraPreview(cameraController!),
          )
        ],
      ),
    );
  }
}
