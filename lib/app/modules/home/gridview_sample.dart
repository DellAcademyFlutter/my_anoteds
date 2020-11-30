import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_anoteds/app/modules/home/home_controller.dart';

class GridViewSample extends StatefulWidget {
  GridViewSample({this.arg1});
  final int arg1;

  @override
  _GridViewSampleState createState() => _GridViewSampleState();
}

class _GridViewSampleState extends State<GridViewSample> {
  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina 3"),
        centerTitle: true,
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) =>
        new Container(
          height: index.isEven ? 300 : 100,
            color: Colors.green,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('${index+1}'),
              ),
            )),
        staggeredTileBuilder: (int index) =>
        //StaggeredTile.count(2, index.isEven ? 2 : 1),
        //StaggeredTile.extent(4, 100), // linhas aqui sao menores
        StaggeredTile.fit(1), // Cada item ocupa exatamente 2 colunas
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}