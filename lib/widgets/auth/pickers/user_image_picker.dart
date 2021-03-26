import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {

  final Function(File pickedImage) imagePickFn;
  UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  File _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void _pickerImage(ImageSource src) async{
    final pickedImageFile = await _picker.getImage(source: src, imageQuality: 50, maxWidth: 150);
    if(pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagePickFn(_pickedImage);
    }
    print("No Image selected");
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 40,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(onPressed: ()=> _pickerImage(ImageSource.camera),
            textColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.photo_camera_outlined),
              label: Text('Add Image\nfrom camera', textAlign: TextAlign.center,),
            ),
            FlatButton.icon(onPressed: ()=> _pickerImage(ImageSource.gallery),
            textColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.image_outlined),
              label: Text('Add Image\nfrom Gallery', textAlign: TextAlign.center,),
            ),
          ],
        )
      ],
    );
  }
}
