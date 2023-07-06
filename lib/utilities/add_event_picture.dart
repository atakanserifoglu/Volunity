import 'dart:io';

import 'package:flutter/material.dart';

import 'constants.dart';

class AddEventPicture extends StatelessWidget {
  const AddEventPicture({
    super.key,
    required this.deviceWidth,
    required File? photo,
  }) : _photo = photo;

  final double deviceWidth;
  final File? _photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _photo == null ? kButtonColor : Colors.white,
      child: _photo != null
          ? ClipRRect(
              borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)),
              child: Image.file(
                width: deviceWidth / 2,
                height: deviceWidth / 3,
                fit: BoxFit.cover,
                _photo!,
              ),
            )
          : Container(
              decoration: BoxDecoration(color: kButtonColor, boxShadow: [
                BoxShadow(
                  color: kThemeDarkColor.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ]),
              width: deviceWidth / 2,
              height: deviceWidth / 3,
              child: const Icon(
                Icons.camera_alt,
                color: Colors.black,
              ),
            ),
    );
  }
}
