import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key});

  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title : const Center(child :Text('Médiathèque', textAlign: TextAlign.left,))),
      body: const Center(
        child: Expanded(
          child: Text(
            'Application made by Maxime Grenet and Thibault Magnin',
            textAlign: TextAlign.center, // Ensure text is centered within Expanded widget
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
