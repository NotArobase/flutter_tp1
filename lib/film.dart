import 'media.dart';

class Film extends Media {
  final List<String> acteurs;
  final int dateDeSortie;
  final String synopsis;

  Film({
    required super.nom,
    required super.img,
    required this.acteurs,
    required this.dateDeSortie,
    required this.synopsis,
  });
}


