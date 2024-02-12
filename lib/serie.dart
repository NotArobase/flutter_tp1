import 'media.dart';

class Serie extends Media {
  final List<String> acteurs;
  final int episodes;
  final int dateDeSortie;
  final String synopsis;

  Serie({
    required super.nom,
    required super.img,
    required this.acteurs,
    required this.episodes,
    required this.dateDeSortie,
    required this.synopsis,
  });
}
