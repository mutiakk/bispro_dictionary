import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterdict/page/stateless.dart';
import 'package:http/http.dart' as http;
import '../env.dart';
import '../fonts.dart';
import '../word.dart';


class ListWord extends StatefulWidget {
  const ListWord({Key? key}) : super(key: key);

  @override
  State<ListWord> createState() => _ListWordState();
}

class _ListWordState extends State<ListWord> {
  final ScrollController _scrollController = ScrollController();
  bool showbtn = false;
  bool _loading = true;
  var _words = <Words>[];
  var _post = <Words>[];

  Future getDataList() async {
    final response = await http.get(Env().getListWord());
    if (response.statusCode == 200) {
      setState(() {
        _loading = false;
        Iterable it = jsonDecode(response.body);
        print(response.body);
        _words = it.map<Words>((e) => Words.fromJson(e)).toList();
      });
      return _words;
    }
  }

  Future<void> fetchDataAndSetState() async {
    try {
      List<Words> dataList = await getDataList();
      setState(() {
        _loading = false;
        _words = dataList;
        _post = _words;
      });
    } catch (e) {
      print("Error! ");
      showDialog(
          context: context, // Provide the context of your widget
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Failed to fetch data. Check your internet and try again'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }
  }

  @override
  void initState() {
    fetchDataAndSetState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
        },
        child: Icon(Icons.keyboard_arrow_up),
      ),
      body: SafeArea(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _post.length + 1,
          itemBuilder: (context, i) {
            return i == 0
                ? _searchBar()
                : ListUi(
              words: _post[i - 1].word.toString(),
              text1: _post[i - 1].textFirst.toString(),
              text2: _post[i - 1].textScnd.toString(),
            );
          },
        )

        ),
      );
    //);
  }


  _searchBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 30),
      height: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
          color: Colors.teal[700],
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10, // Adjust the left value as needed
            child: Container(
              height: 50,
              width: 100, // Adjust the width and height as needed
              child: Image.asset(
                'pict/bispro.png', // Replace with your image asset path
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 10,
            bottom: 10,
            right: 10, // Adjust the left value as needed
            child: Container(
              color: Color.fromARGB(0, 0, 0, 0), // Transparent color
              child: Opacity(
                opacity: 0.3,
                // Set the opacity value (0.0 fully transparent, 1.0 fully opaque)
                child: Icon(
                  Icons.business, // Replace with the desired Icon
                  color: Colors.teal, // Set the color of the icon
                  size: 250, // Set the size of the icon
                ),
              ),
            ),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
                  child: Text(
                    'Business Glossaries',
                    style: ThemeFonts.textTitleDict
                        .copyWith(fontSize: 40, letterSpacing: 2),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 10,5),
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.teal)),
                      hintText: 'Search..',
                      fillColor: Colors.white,
                      filled: true),
                  onChanged: (text) {
                    text = text.toLowerCase();
                    setState(() {
                      _post = _words.where((e) {
                        var keyword = e.word.toLowerCase();
                        return keyword.contains(text);
                      }).toList();
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
