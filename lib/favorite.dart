import 'package:flutter/material.dart';
import 'package:flutter_tp1/serie.dart';
import 'film.dart';
import 'media.dart';
import 'bd.dart';
import 'livre.dart';
import 'data.dart';

class ListFavorite extends StatefulWidget {
  const ListFavorite({super.key});

  @override
  ListFavoriteState createState() => ListFavoriteState();
}

class ListFavoriteState extends State<ListFavorite> with SingleTickerProviderStateMixin {
  late List<bool> _selected;
  late List<Film> _films;
  late List<Serie> _series;
  late List<BD> _bds;
  late List<Livre> _livres;
  late bool _isGridMode = true;
  bool isSelectionMode = false;
  final int listLength = favorites.length;
  bool _selectAll = false;
  int _selectedTabIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _films = favorites.whereType<Film>().toList();
    _series = favorites.whereType<Serie>().toList();
    _bds = favorites.whereType<BD>().toList();
    _livres = favorites.whereType<Livre>().toList();
    initializeSelection();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void initializeSelection() {
    _selected = List<bool>.generate(listLength, (_) => false);
  }

  void updateSelectionMode(bool value) {
    setState(() {
      isSelectionMode = value;
    });
  }
  void _handleTabSelection() {
    setState(() {
      _selectedTabIndex = _tabController.index;
    });
  }

  List<Media> _getTabData(int tabIndex) {
  switch (tabIndex) {
    case 0:
      return _films;
    case 1:
      return _series;
    case 2:
      return _bds;
    case 3:
      return _livres;
    default:
      return [];
  }
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
                      updateSelectionMode(false);
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
                icon: const Icon(Icons.heart_broken_outlined),
                onPressed: () {
                  final tabData = _getTabData(_selectedTabIndex);
                  // Retirer les éléments sélectionnés à la liste de favoris
                  for (int i = 0; i < _selected.length; i++) {
                    if (_selected[i] && favorites.contains(tabData[i])) {
                      favorites.remove(tabData[i]);
                    }
                  }
                  // Sortir du mode de sélection
                  setState(() {
                    updateSelectionMode(false);
                    // Remettre à zéro la sélection
                    initializeSelection();
                  });
                },
              ),
          ],
        ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: <Widget>[
             TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Films'),
                Tab(text: 'Séries'),
                Tab(text: 'BDs'),
                Tab(text: 'Livres'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildContent(_films),
                  _buildContent(_series),
                  _buildContent(_bds),
                  _buildContent(_livres),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(List<Media> favorites) {
    return _isGridMode
        ? GridBuilder(
          isSelectionMode: isSelectionMode,
            selectedList: _selected,
            onSelectionChange: (bool x) {
              setState(() {isSelectionMode = x;});
            },
            media : favorites
          )
        : ListBuilder(
          isSelectionMode: isSelectionMode,
            selectedList: _selected,
            onSelectionChange: (bool x) {
              setState(() {isSelectionMode = x;});
            },
            media : favorites
          );
  }
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
    required this.media, // Add media parameter
  });

  final bool isSelectionMode;
  final ValueChanged<bool>? onSelectionChange;
  final List<bool> selectedList;
  final List<Media> media; // Define media parameter

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
      itemCount: widget.media.length, // Use widget.media.length instead of widget.selectedList.length
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
                    widget.media.isNotEmpty && index < widget.media.length ? widget.media[index].img : '',
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
    required this.media,
  });

  final bool isSelectionMode;
  final List<bool> selectedList;
  final ValueChanged<bool>? onSelectionChange;
  final List<Media> media;

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
              title: Text(widget.media[index].nom));
        });
  }
}
