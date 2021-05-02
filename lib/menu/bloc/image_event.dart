part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class ChangeImageEvent extends ImageEvent{}
class GetImageEvent extends ImageEvent{}