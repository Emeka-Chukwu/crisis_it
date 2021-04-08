import 'dart:ui';

import 'package:create_it/src/cores/cores.dart';
import 'package:flutter/material.dart';

Align align() => Align(
      alignment: Alignment.centerLeft,
      child: Text("Hi {name},",
          style: TextStyle(
            color: AppColor.bBlue,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          )),
    );
