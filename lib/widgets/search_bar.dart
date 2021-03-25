import 'package:flutter/material.dart';
import 'package:plantpal/models/plant.dart';
import 'package:plantpal/providers/plants.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {




  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  final _searchInputController = TextEditingController();

  void submitSearch() {
    final searchInput = _searchInputController.text;

    if(searchInput.isEmpty) return;

    Provider.of<Plants>(context, listen: false).searchForPlants(searchInput);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      child: TextField(
                decoration: InputDecoration(labelText: 'Search'),
                controller: _searchInputController,
                onSubmitted: (_) => submitSearch(),
                autofocus: true,
              ),
    );
  }
}