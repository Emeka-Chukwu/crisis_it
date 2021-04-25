import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void changeScreen(BuildContext context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void changeScreenRemove(BuildContext context, Widget widget) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);

void changeScreenWithoutRoot(BuildContext context, Widget widget) =>
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => widget));

void changeScreenWithRemove(BuildContext context, Widget widget) =>
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget), (route) => false);

void changeScreenWithFlash(BuildContext context, Widget widget) =>
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => widget,
              )
            ],
          ),
        ));
