part of 'gallery_bloc.dart';

abstract class GalleryState extends Equatable {
  const GalleryState();

  @override
  List<Object?> get props => [];
}

class GalleryInitial extends GalleryState {}

class GalleryFetchInProgress extends GalleryState {}

class GalleryFetchSuccess extends GalleryState {
  const GalleryFetchSuccess({
    required this.marsPhotos,
    required this.selectedCamera,
    required this.rover,
    this.sol,
    this.earthDate,
    this.camera,
    this.page,
  });

  final MarsPhotos marsPhotos;
  final Cameras? selectedCamera;
  final Rovers rover;
  final int? sol;
  final String? earthDate;
  final String? camera;
  final int? page;

  @override
  List<Object?> get props => [
        marsPhotos,
        selectedCamera,
        rover,
        sol,
        earthDate,
        camera,
        page,
      ];
}

class GalleryFetchFailure extends GalleryState {
  const GalleryFetchFailure(this.failure);

  final Exception failure;

  @override
  List<Object?> get props => [failure];
}
