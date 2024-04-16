import 'package:diplom/utils/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppConstants {
  static const int minColorValue = 180;
  static const int maxColorValue = 255;
  static const int diffColorValue = maxColorValue - minColorValue + 1;
}


abstract class AppBorderRounds {
  static const cardRoundedBorder = BorderRadius.all(
    Radius.circular(10.0),
  );
}

abstract class AppButtonStyle {

  // Basic buttons
  
  static ButtonStyle basicButton = ButtonStyle(
    backgroundColor:  const MaterialStatePropertyAll(AppColors.primaryColor),
    foregroundColor:  const MaterialStatePropertyAll(Colors.white),
    overlayColor:     const MaterialStatePropertyAll(AppColors.overlayColor),
  
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(vertical: 12),
    ),
  );

  // Rounded buttons

  static ButtonStyle roundedButton = ButtonStyle(
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(400),
      ),
    ),
  );

  static final outlinedRedRoundedButton = roundedButton.copyWith(
    backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
    foregroundColor: const MaterialStatePropertyAll(Colors.red),
    overlayColor:    const MaterialStatePropertyAll(Color.fromRGBO(253, 139, 131, 0.5)),
    side:            const MaterialStatePropertyAll(BorderSide(color: Colors.red)),
  );

  static final filledRoundedButton = roundedButton.copyWith(
    backgroundColor:  const MaterialStatePropertyAll(AppColors.activeColor),
    foregroundColor:  const MaterialStatePropertyAll(Colors.white),
    overlayColor:     const MaterialStatePropertyAll(AppColors.overlayColor),
  );

  static final outlinedRoundedButton = roundedButton.copyWith(
    backgroundColor:  const MaterialStatePropertyAll(Colors.transparent),
    shadowColor:      const MaterialStatePropertyAll(Colors.transparent),
    foregroundColor:  const MaterialStatePropertyAll(AppColors.primaryColor),
    overlayColor:     const MaterialStatePropertyAll(AppColors.overlayColor),
    side:             const MaterialStatePropertyAll(BorderSide(color: AppColors.primaryColor)),
  );

  static ButtonStyle filterButton = ButtonStyle (
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(vertical: 15),
    ),

    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),

    iconSize: const MaterialStatePropertyAll(20),
  );
 
  static final inactiveFavButton = filterButton.copyWith(
    backgroundColor:  const MaterialStatePropertyAll(Colors.transparent),
    foregroundColor:  const MaterialStatePropertyAll(Color.fromARGB(255, 230, 87, 111)),
    overlayColor:     const MaterialStatePropertyAll(Color.fromARGB(71, 230, 119, 152)),
    shadowColor:      const MaterialStatePropertyAll(Colors.transparent),
  );

  static final activeFavButton = filterButton.copyWith(
    backgroundColor:  const MaterialStatePropertyAll(Color.fromARGB(255, 230, 87, 111)),
    foregroundColor:  const MaterialStatePropertyAll(Colors.black),
    overlayColor:     const MaterialStatePropertyAll(Color.fromARGB(71, 230, 119, 152)),
  );

  static final dateButton = filterButton.copyWith(
    // backgroundColor:  const MaterialStatePropertyAll(Color.fromRGBO(228, 242, 239, 1)),
    backgroundColor:  const MaterialStatePropertyAll(Colors.transparent),
    foregroundColor:  const MaterialStatePropertyAll(Colors.black),
    shadowColor:      const MaterialStatePropertyAll(Colors.transparent),
    overlayColor:     const MaterialStatePropertyAll(Color.fromARGB(71, 162, 209, 250)),
  );

  // Text Buttons

  static ButtonStyle textButton = ButtonStyle(
    backgroundColor:  const MaterialStatePropertyAll(Colors.transparent),
    shadowColor:      const MaterialStatePropertyAll(Colors.transparent),
    foregroundColor:  const MaterialStatePropertyAll(AppColors.activeColor),
    overlayColor:     const MaterialStatePropertyAll(AppColors.overlayColor),

    side: const MaterialStatePropertyAll(BorderSide.none),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(400),
      ),
    ),
  );

  static final textRoundedButton = textButton;
}


abstract class AppStyleTextFields {

  static OutlineInputBorder textFieldBorder = const OutlineInputBorder (
    borderSide: BorderSide(
      color: Colors.transparent,
    ),

    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  );

  static final enabledBorder = textFieldBorder;

  static final disabledBorder = textFieldBorder.copyWith(
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 1.5,
    ),

    borderRadius: const BorderRadius.all(
      Radius.circular(10.0),
    ),
  );

  static final focusedBorder = textFieldBorder.copyWith(
    borderSide: const BorderSide(
      color: AppColors.activeColor,
      width: 1.5,
    ),
  );

  static final errorBorder = textFieldBorder.copyWith(
    borderSide: const BorderSide(
      color: Colors.red,
      width: 1.5,
    ),
  );

  static InputDecoration sharedDecoration = InputDecoration (
    floatingLabelStyle: const TextStyle(
      color: AppColors.activeColor,
    ),

    isCollapsed: true,
    contentPadding: const EdgeInsets.all(15),

    filled: true,
    fillColor: AppColors.fillColor,
    enabledBorder: AppStyleTextFields.enabledBorder,
    disabledBorder: AppStyleTextFields.disabledBorder,
    focusedBorder: AppStyleTextFields.focusedBorder,
    errorBorder: AppStyleTextFields.errorBorder,
  );
}

