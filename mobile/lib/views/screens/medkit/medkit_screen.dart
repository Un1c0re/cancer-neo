import 'package:diplom/views/widgets/medkit/medkit_widget.dart';
import 'package:flutter/material.dart';

class MedKitScreen extends StatefulWidget {
  const MedKitScreen({super.key});

  @override
  State<MedKitScreen> createState() => _MedkitScreenState();
}

class _MedkitScreenState extends State<MedKitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Аптечка'),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: MedKitWidget(),
      ),
    );
  }
}
