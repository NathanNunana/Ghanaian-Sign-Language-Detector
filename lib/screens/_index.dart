library bc_screens;

import 'dart:io';

import 'package:ghana_sl/utils/_index.dart';
import 'package:ghana_sl/widgets/_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ghana_sl/providers/_index.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

part 'home.dart';
part 'loader.dart';

void showToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: CustomTextTheme.customTextTheme(context).textTheme.labelSmall,
      ),
      backgroundColor: AppTheme.appTheme(context).primaryColor,
    ),
  );
}
