import 'package:flutter/material.dart';

import 'main.dart';

class DataSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, DataSearch());
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List foundData = [];
    String surah = '';
    int ayahNumber = 0;
    if (query.isNotEmpty) {
      foundData = found
          .where(
            (element) => element.toString().contains(
                  query.trim(),
                ),
          )
          .toList();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                for (int i = 0; i < foundData.length; i++) ...{
                  Text(
                    textDirection: TextDirection.rtl,
                    '${foundData[i]} . ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                },
              ],
            );
          },
        ),
      );
    }
    return Center(
      child: Text(
        'محتوى البحث ',
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> foundData = [];
    List<String> surah = [];
    List<int> ayahNumber = [];
    if (query.isNotEmpty) {
      foundData = found
          .where(
            (element) => element.toString().contains(
                  query.trim(),
                ),
          )
          .toList();

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                for (int i = 0; i < foundData.length; i++) ...{
                  Text(
                    textDirection: TextDirection.rtl,
                    '${foundData[i]} . ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                },
              ],
            );
          },
        ),
      );
    } else {
      return Center(
        child: Text(
          'محتوى البحث ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
      );
    }
    return Center(
      child: Text(
        'محتوى البحث ',
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
