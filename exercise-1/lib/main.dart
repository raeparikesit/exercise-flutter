//MUHAMMAD RAEHAN PARIKESIT
//DAY 1
import 'package:flutter/material.dart';
import 'package:helping/model.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),Dart Analysis
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Film> films = [];

  final String apiUrl = "https://ghibliapi.herokuapp.com/films/";
  Future<List<Film>> _fecthData() async {
    try {
      var result = await http.get(Uri.parse(apiUrl));
      var body = filmsFromJson(result.body);
      for (var e in body) {
        print(e.toJson());
      }
      films = body;
      return body;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar API'),
      ),
      body: FutureBuilder<List<Film>>(
        future: _fecthData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: films.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(films[index].image),
                  ),
                  title: Text(
                      "${films[index].title} (${films[index].originalTitle})"),
                  subtitle: Text(films[index].director),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}