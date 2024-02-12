import 'media.dart';

class Livre extends Media {
  final String auteur;
  final int dateDeSortie;
  final String synopsis;

  Livre({
    required super.nom,
    required super.img,
    required this.auteur,
    required this.dateDeSortie,
    required this.synopsis,
  });
}
