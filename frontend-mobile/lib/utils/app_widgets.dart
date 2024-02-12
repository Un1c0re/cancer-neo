import 'package:diplom/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyleCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const AppStyleCard({
    super.key,
    required this.backgroundColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 0.8,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Padding(padding: const EdgeInsets.all(8.0), child: child),
      ),
    );
  }
}

class ApppStyleChip extends StatefulWidget {
  final String label;

  const ApppStyleChip({
    super.key,
    required this.label,
  });

  @override
  State<ApppStyleChip> createState() => _ApppStyleChipState();
}

class _ApppStyleChipState extends State<ApppStyleChip> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 150,
        maxHeight: 70, // Добавьте максимальную высоту, чтобы предотвратить Infinity
      ),
      child: Stack(
        children: [
          AppStyleCard(
            backgroundColor: _isSelected? AppColors.redColor: Colors.white,
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isSelected = !_isSelected;
                  });
                },
                splashColor: AppColors.splashColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
