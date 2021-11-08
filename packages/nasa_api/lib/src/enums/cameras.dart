// ignore_for_file: constant_identifier_names

enum Cameras {
  FHAZ,
  RHAZ,
  MAST,
  CHEMCAM,
  MAHLI,
  MARDI,
  NAVCAM,
  PANCAM,
  MINITES,
}

const List<Cameras> curiosityCameras = [
  Cameras.FHAZ,
  Cameras.RHAZ,
  Cameras.MAST,
  Cameras.CHEMCAM,
  Cameras.MAHLI,
  Cameras.MARDI,
  Cameras.NAVCAM,
];

const List<Cameras> opportunityCameras = [
  Cameras.FHAZ,
  Cameras.RHAZ,
  Cameras.NAVCAM,
  Cameras.PANCAM,
  Cameras.MINITES,
];

const List<Cameras> spiritCameras = [
  Cameras.FHAZ,
  Cameras.RHAZ,
  Cameras.NAVCAM,
  Cameras.PANCAM,
  Cameras.MINITES,
];
