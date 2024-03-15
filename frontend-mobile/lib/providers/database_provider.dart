import 'package:diplom/data/moor_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatabaseProvider extends StatelessWidget {
  final Widget child;

  const DatabaseProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AppDatabase>(
      create: (_) => AppDatabase(),
      child: child,
    );
  }

  static AppDatabase of(BuildContext context) {
    return Provider.of<AppDatabase>(context, listen: false);
  }
}
