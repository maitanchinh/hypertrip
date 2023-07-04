// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Gap {
  static final k4 = GapDimension(4);
  static final k8 = GapDimension(8);
  static final k16 = GapDimension(16);
  static final kSection = GapDimension(32);
}

class GapDimension {
  final double size;

  GapDimension(this.size);

  SizedBox get height => SizedBox(height: size);

  SizedBox get width => SizedBox(width: size);
}

//
// class Gap {
//   static const gap_4 = SizedBox(width: 4, height: 4);
//
//   static const gap_v_4 = SizedBox(height: 4);
//   static const gap_v_8 = SizedBox(height: 8);
//
//   static const gap_h_4 = SizedBox(width: 4);
//   static const gap_h_8 = SizedBox(width: 8);
//
//   static const section_v_gap = SizedBox(height: 32);
//
//   static const section_h_gap = SizedBox(height: 32);
// }
