import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_anoteds/app/data/local/shared_prefs.dart';

class ImageView extends StatelessWidget {
  final String imageName;

  const ImageView({Key key, this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Imagem Carregada"),
          FutureBuilder(
            future: SharedPrefs.read(imageName),
            builder: (context, snapshot) {
              final bytes = base64Decode(snapshot.data);

              if (snapshot.hasData) {
                return Image.memory(
                  bytes,
                  width: 200,
                  height: 200,
                );
              }
              if (snapshot.hasError) {
                return Text("ERROR ${snapshot.error}");
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
