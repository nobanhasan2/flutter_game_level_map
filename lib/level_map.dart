

import 'package:flutter/cupertino.dart';
import 'package:game_level_map/custompaint/mapline_painter1.dart';
import 'package:game_level_map/utilty/util.dart';
import 'custompaint/mapline_painter2.dart';

const  divisor = 6;
class GameLevelMap extends StatefulWidget{
  Color color;
  double stroke;
  double spaceCurve;
  List<Widget> levelWidgets;
  GameLevelMap(
      { required this.color,
        required   this.stroke,
        required   this.spaceCurve,
        required   this.levelWidgets,
        super.key});
  @override
  State<StatefulWidget> createState() => _GameLevelMapState();

}

class _GameLevelMapState extends State<GameLevelMap>{

  List<List<Widget>> paired =[];
  late Color color;
  late double stroke;
  late double spaceCurve;
  late List<Widget> levelWidgets;
  late MapLinePainter1 mapLinePainter1;
  late MapLinePainter2 mapLinePainter2;

  @override
  void initState() {

    super.initState();

    color = widget.color;
    stroke = widget.stroke;
    spaceCurve = widget.spaceCurve;
    levelWidgets = widget.levelWidgets;

    levelWidgets = levelWidgets.reversed.toList();
    mapLinePainter1 = MapLinePainter1(color,stroke);
    mapLinePainter2 = MapLinePainter2(color,stroke);

     paired = pairLevel(levelWidgets);
    _goToCurrentLevel();

  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: (levelWidgets.length/2 ).ceil(),
      itemBuilder: (context, index) {
        return SizedBox(
          key: GlobalObjectKey(index),
          height: spaceCurve,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width,spaceCurve),
                painter: index %2 == 0 ? mapLinePainter1 : mapLinePainter2,
              ),
              Positioned(
                  left: index % 2 ==0 ? 100 : null ,
                  right: index % 2 !=0 ? 100 : null,
                  top: spaceCurve/divisor,
                  bottom: spaceCurve/divisor,
                  child:  Center(
                    child: paired[index][0],
                  ),
                  ),
              Positioned(
                  left: index % 2 !=0 ? 100 : null ,
                  right: index % 2 ==0 ? 100 : null  ,
                  top: spaceCurve/divisor,
                  bottom: spaceCurve/divisor,
                  child: Center(
                    child: paired[index].length > 1 ? paired[index][1] : Container(),
                  ),
                  )

            ],
          ),
        );
      },
    );
  }

  void _goToCurrentLevel() async{
    await Future.delayed(const Duration(milliseconds: 500));
    Scrollable.ensureVisible(
        const GlobalObjectKey(3).currentContext!,
        duration: const Duration(seconds: 3),// duration for scrolling time
        alignment: .5, // 0 mean, scroll to the top, 0.5 mean, half
        curve: Curves.easeInOutQuart);
  }




}