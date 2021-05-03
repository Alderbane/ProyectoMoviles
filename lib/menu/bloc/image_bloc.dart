import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:path_provider/path_provider.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial());
  //  static final ImageBloc _booksRepository = ImageBloc._internal();

  // factory ImageBloc() {
  //   return _booksRepository;
  // }
  // // ImageBloc(){};
  // ImageBloc._internal() : super(ImageInitial());

  @override
  Stream<ImageState> mapEventToState(
    ImageEvent event,
  ) async* {
    if(event is GetImageEvent){
      File img;
      img = await downloadFile();
    yield ImageUpdatedState(image: img);
    }else if(event is ChangeImageEvent){
      File img = await _pickImage();
      print(img);
      await uploadFile(img);
      yield ImageUpdatedState(image: img);
    }
  }
}


 Future<File> _pickImage() async {
    final picker = ImagePicker();
    final PickedFile chosenImage = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    return File(chosenImage.path);
  }

Future<void> uploadFile(File file) async {
  try {
    await firebase_storage.FirebaseStorage.instance
        .ref('${FirebaseAuth.instance.currentUser.uid}/avatar.jpg')
        .putFile(file);
  } on firebase_core.FirebaseException catch (e) {
    // e.g, e.code == 'canceled'
  }
}


Future<File> downloadFile() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  File downloadToFile = File('${appDocDir.path}/avatar.jpg');

  try {
    await firebase_storage.FirebaseStorage.instance
        .ref('${FirebaseAuth.instance.currentUser.uid}/avatar.jpg')
        .writeToFile(downloadToFile);
      return downloadToFile;
  } on firebase_core.FirebaseException catch (e) {
    return null;
    // e.g, e.code == 'canceled'
  }
}