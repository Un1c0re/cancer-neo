import 'package:flutter/material.dart';

import '../../widgets/profile/edit_profile_widget.dart';

class EditProfileScreen extends StatefulWidget {
  final Function onUpdate;

  const EditProfileScreen({
    super.key,
    required this.onUpdate,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Изменить профиль',
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: EditProfileWidget(onUpdate: widget.onUpdate),
      ),
    );
  }
}
