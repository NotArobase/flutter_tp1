import 'package:flutter/material.dart';
import 'favorite.dart';

/// Flutter code sample for [BottomNavigationBar].

void main() => runApp(const MediaApp());

class MediaApp extends StatelessWidget {
  const MediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ListTileSelectExample(),
    ListFavorite(),
    Text(
      'Index 2: About',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}



class ListTileSelectExample extends StatefulWidget {
  const ListTileSelectExample({super.key});

  @override
  ListTileSelectExampleState createState() => ListTileSelectExampleState();
}

class ListTileSelectExampleState extends State<ListTileSelectExample> {
  bool isSelectionMode = false;
  final int listLength = films.length;
  late List<bool> _selected;
  bool _selectAll = false;
  bool _isGridMode = false;

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {
    _selected = List<bool>.generate(listLength, (_) => false);
  }

  @override
  void dispose() {
    _selected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title : const Text('Médiathèque'),
          leading: isSelectionMode
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      isSelectionMode = false;
                    });
                    initializeSelection();
                  },
                )
              : const SizedBox(),
          actions: <Widget>[
            if (_isGridMode)
              IconButton(
                icon: const Icon(Icons.grid_on),
                onPressed: () {
                  setState(() {
                    _isGridMode = false;
                  });
                },
              )
            else
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  setState(() {
                    _isGridMode = true;
                  });
                },
              ),
            if (isSelectionMode)
              TextButton(
                  child: !_selectAll
                      ? const Text(
                          'select all',
                          style: TextStyle(color: Colors.black),
                        )
                      : const Text(
                          'unselect all',
                          style: TextStyle(color: Colors.black),
                        ),
                  onPressed: () {
                    _selectAll = !_selectAll;
                    setState(() {
                      _selected =
                          List<bool>.generate(listLength, (_) => _selectAll);
                    });
                  }),
            if (isSelectionMode)
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  // Ajouter les éléments sélectionnés à la liste de favoris
                  for (int i = 0; i < _selected.length; i++) {
                    if (_selected[i] && !favorites.contains(films[i])) {
                      favorites.add(films[i]);
                    }
                  }
                  // Sortir du mode de sélection
                  setState(() {
                    isSelectionMode = false;
                    // Remettre à zéro la sélection
                    initializeSelection();
                  });
                },
              ),
          ],
        ),
        body: _isGridMode
            ? GridBuilder(
                isSelectionMode: isSelectionMode,
                selectedList: _selected,
                onSelectionChange: (bool x) {
                  setState(() {
                    isSelectionMode = x;
                  });
                },
              ) 
            : ListBuilder(
                isSelectionMode: isSelectionMode,
                selectedList: _selected,
                onSelectionChange: (bool x) {
                  setState(() {
                    isSelectionMode = x;
                  });
                },
              ));
  }
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final ValueChanged<bool>? onSelectionChange;
  final List<bool> selectedList;

  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.selectedList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (_, int index) {
        return InkWell(
          onTap: () => _toggle(index),
          onLongPress: () {
            if (!widget.isSelectionMode) {
              setState(() {
                widget.selectedList[index] = true;
              });
              widget.onSelectionChange!(true);
            }
          },
          child: GridTile(
            child: Stack(
              children: [Center(child: 
                Image.asset(
                    films.isNotEmpty && index < films.length ? films[index].img : '',
                    width: 120,
                    height: 160,
                  ),),
                if (widget.selectedList[index])
                  Center(
                      child: Checkbox(
                        onChanged: (bool? x) => _toggle(index),
                        value: widget.selectedList[index],
                      ),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final List<bool> selectedList;
  final ValueChanged<bool>? onSelectionChange;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.selectedList.length,
        itemBuilder: (_, int index) {
          return ListTile(
              onTap: () => _toggle(index),
              onLongPress: () {
                if (!widget.isSelectionMode) {
                  setState(() {
                    widget.selectedList[index] = true;
                  });
                  widget.onSelectionChange!(true);
                }
              },
              trailing: widget.isSelectionMode
                  ? Checkbox(
                      value: widget.selectedList[index],
                      onChanged: (bool? x) => _toggle(index),
                    )
                  : const SizedBox.shrink(),
              title: Text(films[index].nom));
        });
  }
}

class Film {
  final String nom;
  final String img;
  final List<String> acteurs;
  final int dateDeSortie;
  final String synopsis;

  Film({
    required this.nom,
    required this.img,
    required this.acteurs,
    required this.dateDeSortie,
    required this.synopsis,
  });
}

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

// Création de la liste de films
List<Film> films = [lupin, inception, theDarkKnight];
List<Film> favorites = [];

