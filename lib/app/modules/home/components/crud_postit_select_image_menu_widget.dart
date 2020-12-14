import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_anoteds/app/repositories/shared/Utils/image_picker_utils.dart';

/// Widget com o [PopupMenuButton] do crud de [Postit]
class CrudPostitSelectImageMenuWidget extends StatelessWidget {
  CrudPostitSelectImageMenuWidget(this.callback);

  final Function callback;
  final options = ['camera', 'arquivo'];

  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        icon: Icon(Icons.attach_file),
        onSelected: (String result) {
          ImagePickerUtils.getImageFile(
                  imageSource: result == options[0]
                      ? ImageSource.camera
                      : ImageSource.gallery)
              .then((value) {
            callback(imageFile: value);
          });
        },
        itemBuilder: (context) {
          return options.map<PopupMenuItem<String>>((String option) {
            return PopupMenuItem(
              value: option,
              child: ListTile(
                title: Text(
                    (option == options[0]) ? 'Tirar foto' : 'Escolher imagem'),
                leading: Icon(option == options[0]
                    ? Icons.camera_alt_outlined
                    : Icons.filter_outlined),
              ),
            ); //Card(child: Text(listItemValue.title),);
          }).toList();
        });
  }
}
