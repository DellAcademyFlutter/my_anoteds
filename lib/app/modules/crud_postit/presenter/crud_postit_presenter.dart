import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/data/marking_dao.dart';
import 'package:my_anoteds/app/repositories/shared/Utils/image_picker_utils.dart';

/// Classe Presenter para gerenciar o estado dos atributos apresentaveis.
class CrudPostitPresenter {
  final ICrudPostitPresenter iCrudPostitPresenter;
  CrudPostitPresenter(this.iCrudPostitPresenter);

  File image;
  String base64Image;
  List<int> postitMarkers = [];

  /// Inicializa a lista de markers do postit
  initializePostitMarkers({int loggedUserId, int postitId}) async {
    final markingDao = Modular.get<MarkingDao>();

    await markingDao
        .getPostitMarkersIds(userId: loggedUserId, postitId: postitId)
        .then((value) {
      for (var i = 0; i < value.length; i++) {
        if (!postitMarkers.contains(value[i])) {
          postitMarkers.add(value[i]);
        }
      }

      iCrudPostitPresenter.refresh();
    });
  }

  ///Atualizacao de estado de imagem inserida
  void setImageValue({@required File imageFile}) {
    image = imageFile;
    base64Image =
        ImagePickerUtils.getBase64ImageFromFileImage(pickedFile: imageFile);

    iCrudPostitPresenter.refresh();
  }

  /// Adiciona um marcador da lista de postit
  void addMarker({@required int markerId}) {
    if (!postitMarkers.contains(markerId)) {
      postitMarkers.add(markerId);
    }
    iCrudPostitPresenter.refresh();
  }

  /// Remove um marcador da lista de postit
  void removeMarker({@required int markerId}) {
    if (postitMarkers.contains(markerId)) {
      postitMarkers.remove(markerId);
    }
    iCrudPostitPresenter.refresh();
  }
}

/// Interface para Presenter
abstract class ICrudPostitPresenter {
  void refresh();
}
