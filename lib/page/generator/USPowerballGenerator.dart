import 'package:flutter/material.dart';

class USPowerballGenerator extends StatefulWidget {
  const USPowerballGenerator({super.key});

  @override
  State<USPowerballGenerator> createState() => _USPowerballGeneratorState();
}

class _USPowerballGeneratorState extends State<USPowerballGenerator> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      padding: EdgeInsets.symmetric(),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            const Color.fromARGB(255, 255, 137, 53),
            const Color(0xFFff0000)
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      child: Column(
        children: [
          
        ],
      ),
    );
  }
}