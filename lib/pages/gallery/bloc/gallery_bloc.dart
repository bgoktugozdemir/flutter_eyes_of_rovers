import 'package:bloc/bloc.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:nasa_repository/nasa_repository.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc({NasaRepository? nasaRepository})
      : _nasaRepository = nasaRepository ?? NasaRepository(),
        super(GalleryInitial()) {
    on<GalleryPhotosFetchedByMartianSolEvent>((event, emit) async {
      emit(GalleryFetchInProgress());
      try {
        final photos = await _nasaRepository.getMarsPhotosByMartianSol(
          event.rover,
          sol: event.sol,
          camera: event.camera,
          page: event.page,
        );
        emit(GalleryFetchSuccess(
          marsPhotos: photos,
          selectedCamera: event.camera != null
              ? EnumToString.fromString(Cameras.values, event.camera!)
              : null,
          rover: event.rover,
          sol: event.sol,
          camera: event.camera,
          page: event.page,
        ));
      } on Exception catch (error) {
        emit(GalleryFetchFailure(error));
      }
    });
    on<GalleryPhotosFetchedByEarthDateEvent>((event, emit) async {
      emit(GalleryFetchInProgress());
      try {
        final photos = await _nasaRepository.getMarsPhotosByEarthDate(
          event.rover,
          earthDate: event.earthDate,
          camera: event.camera,
          page: event.page,
        );
        emit(GalleryFetchSuccess(
          marsPhotos: photos,
          selectedCamera: event.camera != null
              ? EnumToString.fromString(Cameras.values, event.camera!)
              : null,
          rover: event.rover,
          earthDate: event.earthDate,
          camera: event.camera,
          page: event.page,
        ));
      } on Exception catch (error) {
        emit(GalleryFetchFailure(error));
      }
    });
    on<GalleryCameraChangedEvent>((event, emit) {
      if (state is GalleryFetchSuccess) {
        final currentState = state as GalleryFetchSuccess;
        if (currentState.sol != null) {
          add(GalleryPhotosFetchedByMartianSolEvent(
            sol: currentState.sol!,
            rover: currentState.rover,
            camera: event.camera,
            page: currentState.page,
          ));
        } else if (currentState.earthDate != null) {
          add(GalleryPhotosFetchedByEarthDateEvent(
            earthDate: currentState.earthDate!,
            rover: currentState.rover,
            camera: event.camera,
            page: currentState.page,
          ));
        }
      }
    });
  }

  final NasaRepository _nasaRepository;
}
