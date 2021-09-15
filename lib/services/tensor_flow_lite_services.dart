import 'dart:io';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

class TensorFlowServices {
  loadModelForCats() async {
    await Tflite.loadModel(
      model: "assets/models/cats.tflite",
      labels: "assets/text_files/cat_labels.txt",
    );
  }

  loadModelForDogs() async {
    await Tflite.loadModel(
      model: "assets/models/dogs.tflite",
      labels: "assets/text_files/dog_labels.txt",
    );
  }

  predictImage(File image) async {
    var recog = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    return recog;
  }

  runModelOnFrame(CameraImage imgCamera) {
    var recognitions = Tflite.runModelOnFrame(
      bytesList: imgCamera.planes.map((plane) {
        return plane.bytes;
      }).toList(), // required
      imageHeight: imgCamera.height,
      imageWidth: imgCamera.width,
      numResults: 2, // defaults to 5
      threshold: 0.1, // defaults to 0.1
    );
    return recognitions;
  }
}
