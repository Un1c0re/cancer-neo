import 'package:diplom/views/widgets/profile/profile_card_widget.dart';
import 'package:flutter/material.dart';

class ProfileCardScreen extends StatefulWidget {
  final Function onUpdate;
  const ProfileCardScreen({
    super.key, 
    required this.onUpdate,
  });

  @override
  State<ProfileCardScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карточка пациента', style:TextStyle(fontSize: 28)),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ProfileCardWidget(onUpdate: widget.onUpdate),
      ),
    );
  }
}
