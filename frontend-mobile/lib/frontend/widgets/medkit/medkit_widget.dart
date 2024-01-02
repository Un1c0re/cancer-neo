import 'package:diplom/frontend/Theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../Theme/app_style.dart';
import '../../Theme/constants.dart';

class MedKitWidget extends StatefulWidget {
  const MedKitWidget({super.key});

  @override
  State<MedKitWidget> createState() => _MedKitWidgetState();
}

class _MedKitWidgetState extends State<MedKitWidget> {


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        
        SizedBox(
          height: DeviceScreenConstants.screenHeight * 0.5,

          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text('Вы еще не добавили ни одного препарата', 
                textAlign: TextAlign.center,
                style: TextStyle(
                color: AppColors.activeColor,
                fontSize: 25,
                ),
              ),
            ),
          ),
        ),

        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 100,
            maxWidth: 250,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
        
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 50
                ),
                child: ElevatedButton(
                  style: AppButtonStyle.basicButton,
                  onPressed: () => {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_outlined),
                      SizedBox(width: 5),
                      Text('Добавить',
                      style: TextStyle(
                        fontSize: 18,
                      ),),
                    ],
                  ),
                ),
              ),
        
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}