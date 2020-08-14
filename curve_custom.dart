
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CuverCrossAngle extends StatefulWidget{
  Color color;
  List<Color> gradient;
  double padding;
  static const Color _defaultcolor = Color(0xff44dee3);
  static const List<Color> _defaultgradient = [
    Color(0xff34aeeb),
    Color(0xff34ebc3),
  ];
  CuverCrossAngle({this.color =_defaultcolor,this.gradient=_defaultgradient,this.padding=8.0});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CuverCrossAngle();
  }
  
}
class _CuverCrossAngle extends State<CuverCrossAngle>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      painter: _MyPaint(color: widget.color,gradient: widget.gradient,padding: widget.padding),
      child: Container(
      ),
    );
  }


}

class _MyPaint  extends CustomPainter{
  Color color;
  List<Color> gradient;
  double padding;
  _MyPaint({@required this.color,@required this.gradient,@required this.padding});
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    //Paint background
    Paint paint1 = new Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.fill;
    Path path1 = new Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height+padding)
      ..cubicTo(size.width/10+padding, size.height+padding, size.width/8+padding, size.height*6/10+padding, size
          .width/8+padding,size.height*6/10+padding)
      ..cubicTo(size.width/5+padding, padding, size.width/2+padding, size.height*8/15+padding, size.width+padding, 0)
    ;
    canvas.drawPath(path1, paint1);


    //Paint foreign
    Path path = new Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height-5)
      ..cubicTo(size.width/10, size.height-6, size.width/8, size.height*6/10, size.width/8,size.height*6/10)
      ..cubicTo(size.width/5, 0, size.width/2, size.height*8/15, size.width, 0)
    ;
    Paint paint = new Paint()
      ..style = PaintingStyle.fill
    ..shader = LinearGradient(
      begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradient
    ).createShader(rect);
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

}