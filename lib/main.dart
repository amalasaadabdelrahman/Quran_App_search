import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data_search.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<dynamic> all = [];
List<dynamic> found = [];

class _MyHomePageState extends State<MyHomePage> {
  final surahCount = List.generate(114, (index) => index);
  final PageController _pageController = PageController();
  String ayatOfPage = '';
  int pageNo = 1;
  String surahName = '';
  int jozz = 1;

  getData() async {
    ayatOfPage = '';
    String temp = await rootBundle.loadString('assets/hafs_smart_v8.json');
    all = jsonDecode(temp) as List;
    for (var item in all) {
      if (item['page'] == pageNo) {
        ayatOfPage += '${item['aya_text']} ';
        surahName = item['sura_name_ar'];
        jozz = item['jozz'];
      }
      found.add('${item['aya_text_emlaey']}');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _pageController.dispose();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [Color(0x0fff2dfd3), Color(0x0fff2dfd3)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الجزء $jozz',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown),
                  ),
                  Text(
                    '$surahName',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown),
                  ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      pageNo++;
                      getData();
                    });
                  },
                  itemCount: 604,
                  itemBuilder: (context, index) {
                    return RichText(
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        text: '',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontFamily: 'Hafs',
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(text: ' ${ayatOfPage}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      getData();
                      setState(() {
                        pageNo == 1 ? pageNo : pageNo--;
                      });
                    },
                    child: Text(
                      'الصفحة السابقة',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.brown),
                    ),
                  ),
                  Text(
                    '$pageNo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        getData();
                        pageNo == 604 ? pageNo : pageNo++;
                      });
                    },
                    child: Text(
                      'الصفحة التالية',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.brown),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
