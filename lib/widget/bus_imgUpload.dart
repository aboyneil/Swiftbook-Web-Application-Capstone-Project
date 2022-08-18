import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'dart:html';

class BusImage extends StatelessWidget {
  const BusImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: 160,
          child: Icon(Icons.people_alt_rounded),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.white.withOpacity(0.15)),
            borderRadius: const BorderRadius.all(
              Radius.circular(defaultPadding),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              uploadImage();
            },
            child: Text('Upload Bus Image'),
          ),
        ),
      ],
    );
  }
}

void uploadImage() {
  FileUploadInputElement uploadInput = FileUploadInputElement()
    ..accept = 'image/*';
  uploadInput.click();

  uploadInput.onChange.listen((event) {
    final file = uploadInput.files.first;
    final reader = FileReader();
    reader.readAsDataUrl(file);
    reader.onLoadEnd.listen((event) {});
  });
}
