import 'package:flutter/material.dart';
import 'package:tdd_demo/empty_placeholder.dart';

class StartupNameList extends StatefulWidget {
  final List entries;

  const StartupNameList({Key key, this.entries = const []}) : super(key: key);

  @override
  _StartupNameListState createState() => _StartupNameListState();
}

class _StartupNameListState extends State<StartupNameList> {
  // Step 24: Add a state that keeps track of which has been favourited
  final _saved = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        // Step 30: We can add the Icon here
        actions: [
          IconButton(
              icon: Icon(Icons.list),
              // Step 31: We need to add to onPressed here
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Saved Suggestions'),
                    ),
                    // Step 34: We need to add the ListTile here
                    body: ListView(
                      children: _saved
                          .map((name) => ListTile(title: Text(name)))
                          .toList(),
                    ),
                  );
                }));
              })
        ],
      ),
      body: widget.entries.isEmpty
          ? EmptyPlaceholder()
          : ListView(
              children: widget.entries.map((entry) {
                final alreadySaved = _saved.contains(entry);
                return ListTile(
                  title: Text(entry),
                  // Step 24: Change the icon when it's favourited
                  trailing: Icon(
                    alreadySaved ? Icons.favorite : Icons.favorite_outline,
                    color: alreadySaved ? Colors.red : null,
                  ),
                  // Step 24: Add onTap to add to favourite
                  onTap: () {
                    setState(() {
                      // Step 28: We need to do something here
                      if (alreadySaved) {
                        _saved.remove(entry);
                      } else {
                        _saved.add(entry);
                      }
                    });
                  },
                );
              }).toList(),
            ),
    );
  }
}

/*
// Step 3: Go ahead at create the StartupNameList widget
class StartupNameList extends StatelessWidget {
  // Step 12: Add an argument `entries`
  final List entries;

  const StartupNameList({Key key, this.entries = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Step 6: The test failed because no AppBar with text "Startup Name Generator" is found
    // We need an AppBar here, with the text "Startup Name Generator"
    // return Container();
    return Scaffold(
      appBar: AppBar(title: Text('Startup Name Generator')),
      // Step 13: Add empty placeholder here
      // body: EmptyPlaceholder(),

      // Step 16: We should do something here
      body: entries.isEmpty
          ? EmptyPlaceholder()
          // Step 19: We need to change here
          // : ListTile(
          //     title: Text(entries.first),
          //   ),
          : ListView(
              children: entries
                  .map((entry) => ListTile(
                        title: Text(entry),
                        // Step 21: Add trailing icon here
                        trailing: Icon(Icons.favorite_outline),
                      ))
                  .toList(),
            ),
    );
  }
}
*/
