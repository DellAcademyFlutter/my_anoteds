import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_anoteds/app/controller/postit_controller.dart';
import 'package:my_anoteds/app/model/postit_color.dart';
import 'package:my_anoteds/app/model/user.dart';
import 'package:my_anoteds/app/modules/home/view/crud_postit_page.dart';
import 'package:my_anoteds/app/modules/home/view/reminder_page.dart';
import 'package:my_anoteds/app/repositories/shared/Utils/image_picker_utils.dart';

class PostitWidget extends StatelessWidget {
  PostitWidget({this.index});

  final int index;
  final user = Modular.get<User>();
  final controller = Modular.get<PostitController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.link.pushNamed(CrudPostitPage.routeName,
            arguments: CrudPostitPageArguments(postit: user.postits[index]));
      },
      onLongPress: () {
        Modular.link.pushNamed(ReminderPage.routeName,
            arguments: ReminderPageArguments(postit: user.postits[index]));
      },
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          controller.removePostit(index: index);
        },
        child: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Color(
                    PostitColor.colors[user.postits[index].color]['hex'])),
            child: Column(
              children: [
                Container(
                  child: Text(
                    user.postits[index].title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: (user.postits[index].color == "verde" ||
                                user.postits[index].color == "azul")
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                Container(
                  child: user.postits[index].image != null
                      ? Image.memory(
                          ImagePickerUtils.getBytesImage(
                              base64Image: user.postits[index].image),
                        )
                      : null,
                ),
                Container(
                  child: Text(
                    user.postits[index].description,
                    style: TextStyle(
                        color: (user.postits[index].color == "verde" ||
                                user.postits[index].color == "azul")
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
