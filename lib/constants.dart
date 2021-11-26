import 'package:flutter/material.dart';

const baseUrl = "http://192.168.1.11/trashure_api";

const kWalletHomeText = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w800,
  color: Colors.white,
);

const kBoldHeadlineHomeText = TextStyle(
  fontWeight: FontWeight.w800,
  fontSize: 28,
  color: Color(0xFF416188),
);

const kCircularHomeContainer = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(
    Radius.circular(4),
  ),
  boxShadow: [kBoxShadow],
);
const kBoxShadow = BoxShadow(
  color: Color(0x50808080),
  spreadRadius: 0,
  blurRadius: 17,
  offset: Offset(0, 5), // changes position of shadow
);

const kLightTextNotification =
    TextStyle(fontWeight: FontWeight.w400, fontSize: 12);

const kGreyTextProfile = TextStyle(
  color: Color(0x66000000),
  fontSize: 12,
);
