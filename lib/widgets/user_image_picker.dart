import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) onPickImage;
  final String? initialImage;

  const UserImagePicker({
    required this.onPickImage,
    this.initialImage,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? getImageProvider() {
      if (_pickedImageFile != null) {
        return FileImage(_pickedImageFile!);
      }
      if (widget.initialImage != null) {
        return NetworkImage(widget.initialImage!);
      }
      return null;
    }

    return Stack(
      children: [
        Container(
          width: 83,
          height: 83,
         decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.white,
         ),
         child: Center(
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage: getImageProvider(),
            child: _pickedImageFile == null && widget.initialImage == null
                ? const Icon(Icons.person, size: 60, color: Colors.white)
                : null,
          ),
         )
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(43, 47, 0, 0),
          child: ElevatedButton(
            onPressed: _pickImage,
            child: const Icon(
              Icons.camera_alt,
              size: 17,
              color: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(5),
              minimumSize: const Size(17, 17),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
}
