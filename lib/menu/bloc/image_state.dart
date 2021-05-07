part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();
  
  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageUpdatedState extends ImageState {
  final String image;

  ImageUpdatedState({@required this.image});
  
  List<Object> get props => [image];
}