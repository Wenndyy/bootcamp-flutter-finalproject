import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'values/colors.dart';

class Styles {
  static TextStyle defaultTextStyle = const TextStyle(
    color: AppColors.black,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: '',
  );

  static TextStyle blackTextStyle = GoogleFonts.poppins(
    color: AppColors.black,
  );

  static TextStyle greyTextStyle = GoogleFonts.poppins(
    color: AppColors.grey6A,
  );

  static TextStyle whiteTextStyle = GoogleFonts.poppins(
    color: AppColors.white,
  );
}
