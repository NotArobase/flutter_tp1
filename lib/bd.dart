import 'media.dart';

class BD extends Media {
  final String auteur;
  final int dateDeSortie;
  final String synopsis;

  BD({
    required super.nom,
    required super.img,
    required this.auteur,
    required this.dateDeSortie,
    required this.synopsis,
  });
}