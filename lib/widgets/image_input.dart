import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key,required this.onSelectedImage});

  final void Function(File image) onSelectedImage;

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedPicture;
  bool granted = false;
  @override
  void initState() {
    super.initState();
    checkeCameraPermission();
  }

  void checkeCameraPermission() async {
    if (await Permission.camera.isGranted) {
      setState(() {
        granted = true;
      });
    }
    PermissionStatus status = await Permission.camera.request();
    setState(() {
      granted = status.isGranted;
    });
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final takenPicture =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (takenPicture == null) {
      return;
    }

    setState(() {
      _selectedPicture = File(takenPicture.path);
    });
    widget.onSelectedImage(_selectedPicture!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: granted
          ? _takePicture
          : () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Permission'),
                      content: const Text(
                          'To use the camera, please allow camera access.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await Permission.camera.request();
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'),
                        ),
                      ],
                    );
                  });
            },
      icon: const Icon(Icons.camera),
      label: const Text('Take a picture'),
    );

    if (_selectedPicture != null) {
      content = Image.file(
        _selectedPicture!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
        ),
        height: 250,
        width: double.infinity,
        alignment: Alignment.center,
        child: content);
  }
}
