part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object?> get props => [];
}

class GalleryPhotosFetchedByMartianSolEvent extends GalleryEvent {
  const GalleryPhotosFetchedByMartianSolEvent({
    required this.rover,
    this.sol = 1000,
    this.camera,
    this.page,
  });

  final Rovers rover;
  final int sol;
  final String? camera;
  final int? page;

  @override
  List<Object?> get props => [rover, sol, camera, page];
}

class GalleryPhotosFetchedByEarthDateEvent extends GalleryEvent {
  const GalleryPhotosFetchedByEarthDateEvent({
    required this.rover,
    this.earthDate = '2015-06-03',
    this.camera,
    this.page,
  });

  final Rovers rover;
  final String earthDate;
  final String? camera;
  final int? page;

  @override
  List<Object?> get props => [rover, earthDate, camera, page];
}

class GalleryCameraChangedEvent extends GalleryEvent {
  const GalleryCameraChangedEvent(this.camera);

  final String? camera;

  @override
  List<Object?> get props => [camera];
}
