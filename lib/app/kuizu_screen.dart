import 'package:flutter/material.dart';

class KuizuScreen extends StatefulWidget {

  const KuizuScreen({ super.key });

  @override
  State<KuizuScreen> createState() => _KuizuScreenState();
}

class _KuizuScreenState extends State<KuizuScreen> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Kuizu'),),
           body: Container(),
       );
  }
}