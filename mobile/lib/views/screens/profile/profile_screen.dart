import 'package:cancerneo/views/widgets/profile/profile_card_widget.dart';
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
        title: const Text(
          'Карточка пациента',
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      body: Center(child: ProfileCardWidget(onUpdate: widget.onUpdate)),
    );
  }
}
