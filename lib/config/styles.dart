import 'package:flutter/material.dart';

import 'colors.dart';

const TextStyle textStyleColor = TextStyle(
  color: kPurple,
);

const TextStyle textStyleFontWeight = TextStyle(
  fontWeight: FontWeight.bold,
);

const TextStyle textStyleFontSize = TextStyle(
  fontSize: 16,
);

const TextStyle textStyleRichText = TextStyle(
  color: kWhite,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const TextStyle textStyleButtonsHome = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

ButtonStyle buttonStyleRounded = TextButton.styleFrom(
  padding: const EdgeInsets.symmetric(
    horizontal: 25,
    vertical: 5,
  ),
  textStyle: textStyleButtonsHome,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);

ButtonStyle buttonStylebottomless = TextButton.styleFrom(
  backgroundColor: kTransparent,
);

ButtonStyle buttonStylebottomMax = TextButton.styleFrom(
  backgroundColor: kBluebackButton,
  minimumSize: const Size(10, 10),
);

ButtonStyle buttonStyleToken = TextButton.styleFrom(
  backgroundColor: kGrayLessDark,
  minimumSize: const Size(double.infinity, 50),
);

ButtonStyle buttonStyleTokenActivate = TextButton.styleFrom(
  backgroundColor: kBlueLight,
  minimumSize: const Size(double.infinity, 50),
);

ButtonStyle buttonStyleActivate = TextButton.styleFrom(
  backgroundColor: kBlueLight,
);

const TextStyle textStyleFontWeightDark = TextStyle(
  color: kGrayDark,
  fontSize: 32,
  fontWeight: FontWeight.w400,
);

const TextStyle textStyleFontLight = TextStyle(
  color: kGrayLight,
  fontSize: 19,
);

const TextStyle textStyleFont = TextStyle(
  color: kWhite,
  fontSize: 15,
);

const TextStyle textStyleFontLightBlue = TextStyle(
  color: kBlueDark,
  fontSize: 14,
);

const TextStyle textStyleFontLightGray = TextStyle(
  color: kGrayLight,
  fontSize: 16,
);

const TextStyle textStyleCandlesticks = TextStyle(
  color: kWhite,
  fontSize: 22,
);

const TextStyle textStyleCandlesticksNumber = TextStyle(
  color: kWhite,
  fontSize: 42,
  fontWeight: FontWeight.bold,
);
