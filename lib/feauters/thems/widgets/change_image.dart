import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maine_app/domain/user_theme.dart';

class ChangeImage extends StatefulWidget {
  const ChangeImage({
    required this.parameterName,
    required this.onImageSelected,
    super.key
  });

  final String parameterName;
  final ValueChanged<String> onImageSelected;

  @override
  ChangeImageState createState() => ChangeImageState();
}

class ChangeImageState extends State<ChangeImage> {
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      widget.onImageSelected(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final UserTheme theme = GetIt.I.get<UserTheme>();
    final String backgroundImagePath = theme.imagePath;

    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.transparent,
          border: Border.all(color: Colors.black, width: 2.0),
          image: _imageFile != null
              ? DecorationImage(
                  image: FileImage(_imageFile!),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                      image: backgroundImagePath.startsWith('assets/')
                          ? AssetImage(backgroundImagePath) as ImageProvider
                          : FileImage(File(backgroundImagePath)),
                      fit: BoxFit.cover,
                    ),
        ),
        margin: EdgeInsets.only(bottom: screenSize.height * 0.01),
        height: screenSize.height * 0.22,
        width: screenSize.width * 0.91,
        child: Center(
          child: Text(
            widget.parameterName,
            style: TextStyle(
              color: theme.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
