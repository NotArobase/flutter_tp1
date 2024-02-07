import 'package:flutter/material.dart';
import 'main.dart';

class ListFavorite extends StatefulWidget {
  const ListFavorite({super.key});

  @override
  ListFavoriteState createState() => ListFavoriteState();
}

class ListFavoriteState extends State<ListFavorite> {
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
                icon: const Icon(Icons.heart_broken),
                onPressed: () {
                  // Ajouter les éléments sélectionnés à la liste de favoris
                  for (int i = 0; i < _selected.length; i++) {
                    if (_selected[i]) {
                      favorites.remove(films[i]);
                    }
                  }
                  // Sortir du mode de sélection
                  setState(() {
                    favorites = [...favorites]; // Cette ligne force la mise à jour de l'état
                  });
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
              children: [
                if(favorites.isNotEmpty) 
                  Center(
                  child: Image.asset(
                    favorites[index].img,
                    width: 120,
                    height: 160,
                  ),
                ),
                if (widget.selectedList[index] && favorites.isNotEmpty)
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
        itemBuilder: (_, int index)  {
        if (favorites.isEmpty) {
        // Si la liste de favoris est vide, ne rien retourner
        return const SizedBox.shrink();
      } else {
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
              title: Text(index < favorites.length ? favorites[index].nom : '',));
  }});
  }
}
