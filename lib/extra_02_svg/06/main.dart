import 'dart:ui';

import 'package:flutter/material.dart';

import '../svg_parser/svg_parser.dart';
import '../svg_parser/svg_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _ctrl..forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // _ctrl.reset();
        // _ctrl.forward();
      },
      child: CustomPaint(
        size: Size(137, 28),
        painter: SVGTestPainter(
          progress: _ctrl
        ),
      ),
    );
  }
}

//
// class SVGPathResult{
//   final Color color;
//   final Path path;
//
//   SVGPathResult({required this.color, required this.path});
// }

class SVGTestPainter extends CustomPainter {
  final SVGParser svgParser = SVGParser();

  final Animation progress;

  SVGTestPainter({required this.progress}) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {

    String src = """
<?xml version="1.0" standalone="no"?><!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
    "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg t="1646998306167" class="icon" viewBox="0 0 1024 1024" version="1.1"
    xmlns="http://www.w3.org/2000/svg" p-id="2700" width="128" height="128">
    <defs>
        <style type="text/css"></style>
    </defs>
    <path
        d="M304.064985 471.748923l201.885538-88.186092 203.776 88.182154-17.636431 70.561477v176.368246l-176.376123 47.092184-194.008615-47.092184v-176.368246z"
        fill="#96DD5D" p-id="2701"></path>
    <path
        d="M181.169231 464.738462v358.4l327.061661 78.76923L834.953846 821.937231v-365.075693L787.692308 480.492308V783.753846l-279.461416 70.892308L228.430769 783.753846v-311.138461z"
        fill="#000000" p-id="2702"></path>
    <path
        d="M551.384615 169.353846l417.476923 181.169231c38.959262 24.000985 37.643815 46.316308-3.938461 66.953846l-456.861539 185.107692-445.046153-181.16923c-55.0912-21.137723-56.398769-47.391508-3.938462-78.769231l409.6-173.292308c28.408123-11.945354 55.977354-11.945354 82.707692 0z m-6.293661 47.643569c-22.724923-10.149415-46.158769-10.149415-70.301539 0l-348.16 143.36c-46.993723 10.791385-45.879138 25.237662 3.347693 43.327016l378.28923 146.116923 388.332308-149.468554c39.569723-8.644923 40.684308-19.739569 3.347692-33.28l-354.7136-149.996308z"
        fill="#000000" p-id="2703"></path>
    <path
        d="M47.261538 370.215385a23.630769 23.630769 0 0 1 23.63077 23.630769v291.446154a23.630769 23.630769 0 0 1-47.261539 0v-291.446154a23.630769 23.630769 0 0 1 23.630769-23.630769z"
        fill="#000000" p-id="2704"></path>
</svg>
""";

    List<SVGPathResult?> parserResults = svgParser.parser(src);
    Paint mainPaint = Paint();

    parserResults.forEach((SVGPathResult? result) {
      if (result == null) return;
      if (result.path != null) {
        Path path = SvgUtils.convertFromSvgPath(result.path!);
        result.setPaint(mainPaint);
        canvas.drawPath(path, mainPaint);
        // PathMetrics pms = path.computeMetrics();
        // mainPaint.style = PaintingStyle.stroke;
        // pms.forEach((pm) {
        //   canvas.drawPath(pm.extractPath(0, pm.length * progress.value), mainPaint);
        // });
      }
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
