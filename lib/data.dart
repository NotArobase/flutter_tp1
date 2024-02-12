import 'film.dart';
import 'media.dart';
import 'serie.dart';
import 'bd.dart';
import 'livre.dart';

BD asterix = BD(
      nom: "Astérix",
      img: "assets/img/asterix-and-obelix-i167755.jpg",
      auteur: "René Goscinny",
      dateDeSortie: 1959,
      synopsis: "Les aventures d'un Gaulois et de son ami Obélix",
    );
BD tintin = 
    BD(
      nom: "Tintin en Amérique",
      img: "assets/img/tintin-en-amerique-fr.png",
      auteur: "Hergé",
      dateDeSortie: 1929,
      synopsis: "Les aventures d'un jeune reporter et de son chien Milou",
    );
Livre livre1 = Livre(
      nom: "Le Seigneur des Anneaux",
      img: "assets/img/J02275.jpg",
      auteur: "J.R.R. Tolkien",
      dateDeSortie: 1954,
      synopsis: "Une quête pour détruire un anneau maléfique",
    );
Livre livre2 = Livre(
      nom: "Harry Potter",
      img: "assets/img/libriweb.jpg",
      auteur: "J.K. Rowling",
      dateDeSortie: 1997,
      synopsis: "Les aventures d'un jeune sorcier",
    );
Film lupin = Film(
  nom: "Lupin",
  img: "assets/img/lupin.jpg",
  acteurs: ["Omar Si", "Mario"],
  dateDeSortie: 2023,
  synopsis: "bonsoir",
);

Film inception = Film(
  nom: "Inception",
  img: "assets/img/inception.jpg",
  acteurs: ["Leonardo DiCaprio", "Joseph Gordon-Levitt"],
  dateDeSortie: 2010,
  synopsis: "Un voleur expérimenté vole des secrets précieux dans les rêves de ses cibles.",
);

Film theDarkKnight = Film(
  nom: "The Dark Knight",
  img: "assets/img/the-dark-knight.jpg",
  acteurs: ["Christian Bale", "Heath Ledger"],
  dateDeSortie: 2008,
  synopsis: "Batman s'associe à Gordon et Harvey Dent pour éliminer le crime organisé de Gotham City. Un criminel brillant connu sous le nom de Joker sème le chaos et la terreur.",
);

Serie serie1 = Serie(
      nom: "Game of Thrones",
      img: "assets/img/0717778.jpg-c_310_420_x-f_jpg-q_x-xxyxx.jpg",
      acteurs: ["Kit Harington", "Emilia Clarke"],
      episodes: 73,
      dateDeSortie: 2011,
      synopsis: "Une lutte de pouvoir dans un monde fantastique",
    );
Serie serie2= Serie(
      nom: "Breaking Bad",
      img: "assets/img/3956503.jpg-c_310_420_x-f_jpg-q_x-xxyxx.jpg",
      acteurs: ["Bryan Cranston", "Aaron Paul"],
      episodes: 62,
      dateDeSortie: 2008,
      synopsis: "Un professeur de chimie devient un fabricant de drogue",
    );

List<Media> media = [lupin, inception, theDarkKnight, tintin, asterix, livre1, livre2, serie1, serie2];
List<Media> favorites = [lupin];