import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: SpinKitCircle(
        size: 140,
        duration: const Duration(seconds: 1),
        itemBuilder: (context, index) {
          final colors = [Colors.white,Colors.deepPurple,Colors.blueAccent];
          final color = colors[index % colors.length];

          return DecoratedBox(decoration: BoxDecoration(
            color: color
          ));
        },
      )),
    );
  }
}