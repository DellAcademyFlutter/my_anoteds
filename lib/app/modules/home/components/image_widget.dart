import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_anoteds/app/data/local/shared_prefs.dart';
import 'package:my_anoteds/app/modules/home/components/image_view.dart';

class ImageWidget extends StatefulWidget {
  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  File _image;
  final picker = ImagePicker();
  String base64Image;

  Future getImageCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 100);

    final bytes = File(pickedFile.path).readAsBytesSync();
    base64Image = base64Encode(bytes);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        SharedPrefs.save("image", base64Image);
        debugPrint("testes ${base64Image}");
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          _image == null
              ? Text('No image selected.')
              : Image.file(
                  _image,
                  width: 300,
                  height: 300,
                ),
          RaisedButton(
              child: Icon(Icons.camera_alt_outlined),
              onPressed: () => getImageCamera()),

          ImageView(imageName: "image",)
        ],
      ),
    );
  }
}
