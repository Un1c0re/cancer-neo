import 'package:diplom/views/widgets/profile/profile_card_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/profile/edit_profile_widget.dart';

class ProfileCardScreen extends StatefulWidget {
  const ProfileCardScreen({super.key});

  @override
  State<ProfileCardScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карточка пациента'),
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
        child: ProfileCardWidget(),
      ),
    );
  }
}
