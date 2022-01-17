import 'package:e_transaction/model/palette.dart';
import 'package:flutter/material.dart';

RoundedRectangleBorder kRoundedBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(18.0),
);

const kFixedSize = const Size(200, 30); //for the buttons

const kTextFieldDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Palette.kTeal, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Palette.kTeal, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
