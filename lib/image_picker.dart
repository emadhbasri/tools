import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:io';

class ToolsImagePickerData {
  final Image image;
  final ImageProvider imageProvider;
  final File? file;
  final Uint8List bytes;
  final String? mimeType,path;
  final String name;

  final int length;
  final DateTime? lastModified;



  ToolsImagePickerData(
      {required this.image,
      required this.imageProvider,
      this.file,
      required this.bytes,
      this.mimeType,
      required this.name,
      required this.path,
      required this.length,
       this.lastModified});
}

Future<List<ToolsImagePickerData>> toolsimagePicker(
    {required bool kIsWeb,
    bool isVideo = false,
    bool isMulti = false,
    ///true
    bool isGallery = true,
    bool isCameraRear = true,
    BoxFit? fit}) async {
  List<XFile?>? xfiles = await toolsimagePickerPick(
      isCameraRear: isCameraRear,
      isGallery: isGallery,
      isMulti: isMulti,
      isVideo: isVideo);

  if (xfiles == null || xfiles.isEmpty) return [];
  List<ToolsImagePickerData> out = [];
  for (XFile? xfile in xfiles) {
    if (xfile != null) {
      if (isVideo == false) {
        Image image;
        ImageProvider imageProvider;
        File? file;
        Uint8List bytes;
        String? mimeType;
        String name, path;
        int length;
        DateTime lastModified;

        bytes = await xfile.readAsBytes();
        mimeType = xfile.mimeType;
        name = xfile.name;
        path = xfile.path;
        length = await xfile.length();
        lastModified = await xfile.lastModified();

        if (kIsWeb) {
          image = Image.memory(bytes, fit: fit);
          imageProvider = MemoryImage(bytes);
        } else {
          File file = File(path);
          image = Image.file(file, fit: fit);
          imageProvider = FileImage(file);
        }
        out.add(ToolsImagePickerData(
            file: file,
            mimeType: mimeType,
            image: image,
            imageProvider: imageProvider,
            bytes: bytes,
            name: name,
            path: path,
            length: length,
            lastModified: lastModified));
      }
    }
  }

  return out;
}

Future<List<XFile?>?> toolsimagePickerPick({
  bool isVideo = false,
  bool isMulti = false,
  bool isGallery = true,
  bool isCameraRear = true,
}) async {
  final ImagePicker picker = ImagePicker();
  if (isMulti) {
    return await picker.pickMultiImage();
  } else {
    if (isVideo) {
      return [
        await picker.pickVideo(
            source: isGallery ? ImageSource.gallery : ImageSource.camera,
            preferredCameraDevice:
                isCameraRear ? CameraDevice.rear : CameraDevice.front)
      ];
    } else {
      return [
        await picker.pickImage(
            source: isGallery ? ImageSource.gallery : ImageSource.camera,
            preferredCameraDevice:
                isCameraRear ? CameraDevice.rear : CameraDevice.front)
      ];
    }
  }
}
