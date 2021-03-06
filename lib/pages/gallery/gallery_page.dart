import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_eyes_of_rovers/widgets/circle_image.dart';
import 'package:nasa_repository/nasa_repository.dart';

import 'package:flutter_eyes_of_rovers/core/widgets/widgets.dart';
import 'package:flutter_eyes_of_rovers/pages/gallery/bloc/gallery_bloc.dart';
import 'package:flutter_eyes_of_rovers/pages/gallery/widgets/widgets.dart';
import 'package:flutter_eyes_of_rovers/pages/landing/bloc/authentication_bloc.dart';
import 'package:flutter_eyes_of_rovers/widgets/widgets.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => GalleryPageState();
}

class GalleryPageState extends State<GalleryPage> {
  int currentIndex = 0;

  late final List<BottomNavigationBarItem> bottomBarItems;

  @override
  void initState() {
    super.initState();

    bottomBarItems = const [
      BottomNavigationBarItem(
        icon: AdaptiveIcon(
          cupertinoIcon: CupertinoIcons.cloud,
          materialIcon: Icons.cloud,
        ),
        label: 'Curiosity',
      ),
      BottomNavigationBarItem(
        icon: AdaptiveIcon(
          cupertinoIcon: CupertinoIcons.smiley,
          materialIcon: Icons.sentiment_satisfied,
        ),
        label: 'Opportunity',
      ),
      BottomNavigationBarItem(
        icon: AdaptiveIcon(
          cupertinoIcon: CupertinoIcons.person,
          materialIcon: Icons.person,
        ),
        label: 'Spirit',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        materialAppBar: AppBar(
          title: Text(user.name ?? 'Gallery Page'),
          actions: [
            IconButton(
              onPressed: _signOut,
              icon: user.photo != null
                  ? CircleAvatar(child: _ProfilePhoto(photoUrl: user.photo))
                  : const Icon(Icons.logout),
            ),
          ],
        ),
        cupertinoAppBar: CupertinoNavigationBar(
          middle: Text(user.name ?? 'Gallery Page'),
          trailing: GestureDetector(
            onTap: _signOut,
            child: user.photo != null
                ? _ProfilePhoto(photoUrl: user.photo)
                : const Icon(CupertinoIcons.multiply),
          ),
        ),
      ),
      body: _GalleryBody(rover: currentRover),
      bottomNavigationBar: AdaptiveBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (currentIndex != index) {
            setState(() => currentIndex = index);
            context.read<GalleryBloc>().add(
                  GalleryPhotosFetchedByMartianSolEvent(rover: currentRover),
                );
          }
        },
        items: bottomBarItems,
      ),
    );
  }

  void _signOut() => context
      .read<AuthenticationBloc>()
      .add(const AuthenticationSignOutRequested());

  Rovers get currentRover {
    switch (currentIndex) {
      case 2:
        return Rovers.spirit;
      case 1:
        return Rovers.opportunity;
      case 0:
      default:
        return Rovers.curiosity;
    }
  }
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto({Key? key, required this.photoUrl}) : super(key: key);

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    if (photoUrl == null) {
      return const SizedBox.shrink();
    }
    return CircleImage.network(photoUrl!);
  }
}

class _GalleryBody extends StatelessWidget {
  const _GalleryBody({Key? key, required this.rover}) : super(key: key);

  final Rovers rover;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case GalleryFetchSuccess:
            final photos = (state as GalleryFetchSuccess).marsPhotos.photos;
            return Column(
              children: [
                _TopActionBar(rover: rover),
                _MarsPhotosView(photos: photos),
              ],
            );
          case GalleryFetchInProgress:
            return const LoadingView();
          case GalleryFetchFailure:
            final failure = (state as GalleryFetchFailure).failure.runtimeType;
            return ErrorView(
              title: 'Error',
              message: failure is NasaApiRequestFailure
                  ? 'The request has failed!'
                  : 'Your daily limit has exceeded!',
            );
          case GalleryInitial:
          default:
            return EmptyView(
              icon: const AdaptiveIcon(
                cupertinoIcon: CupertinoIcons.refresh,
                materialIcon: Icons.refresh,
              ).icon,
              message: 'Try to load the images.',
            );
        }
      },
    );
  }
}

class _TopActionBar extends StatelessWidget {
  const _TopActionBar({Key? key, required this.rover}) : super(key: key);

  final Rovers rover;

  @override
  Widget build(BuildContext context) {
    if (context.read<GalleryBloc>().state is GalleryFetchSuccess) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _FilterButton(rover: rover),
          _SolCounter(rover: rover),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({Key? key, required this.rover}) : super(key: key);

  final Rovers rover;

  @override
  Widget build(BuildContext context) {
    final galleryBloc = context.read<GalleryBloc>();
    final currentState = galleryBloc.state as GalleryFetchSuccess;

    return AdaptiveDropdownButton(
      value: currentState.selectedCamera != null
          ? EnumToString.convertToString(currentState.selectedCamera)
          : null,
      onSelectedItemChanged: (index) {
        context.read<GalleryBloc>().add(
              GalleryCameraChangedEvent(
                index != null
                    ? EnumToString.convertToString(cameras[index])
                    : null,
              ),
            );
      },
      defaultValue: 'ALL',
      items: cameras
          .map((camera) => EnumToString.convertToString(camera))
          .toList(),
      child: Row(
        children: [
          const Icon(Icons.filter_alt_outlined),
          const SizedBox(width: 4),
          Text(
            currentState.selectedCamera != null
                ? EnumToString.convertToString(currentState.selectedCamera)
                : 'ALL',
          ),
        ],
      ),
    );
  }

  List<Cameras> get cameras {
    switch (rover) {
      case Rovers.curiosity:
        return curiosityCameras;
      case Rovers.opportunity:
        return opportunityCameras;
      case Rovers.spirit:
        return spiritCameras;
    }
  }
}

class _SolCounter extends StatelessWidget {
  const _SolCounter({Key? key, required this.rover}) : super(key: key);

  final Rovers rover;

  @override
  Widget build(BuildContext context) {
    final galleryBloc = context.read<GalleryBloc>();
    final currentState = galleryBloc.state as GalleryFetchSuccess;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Counter(
        onChanged: (value) {
          context.read<GalleryBloc>().add(
                GalleryPhotosFetchedByMartianSolEvent(
                  rover: rover,
                  sol: value,
                  camera: currentState.camera,
                ),
              );
        },
        value: currentState.sol!,
      ),
    );
  }
}

class _MarsPhotosView extends StatelessWidget {
  const _MarsPhotosView({Key? key, required this.photos}) : super(key: key);

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    // TODO: Pagination
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) => PhotoCardFromNetwork(
          photos[index].imgSrc,
        ),
      ),
    );
  }
}
