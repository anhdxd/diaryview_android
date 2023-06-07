import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../routes.dart';
import 'package:flutter_app/utils.dart';
import 'dart:convert';
import 'package:flutter_app/screen/detail.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final List<String> _itemList = [];
  var detail_item;
  String textNoData = '';
  void initDiary() async {
    String phone = await getIniFile('phone');
    String token = '';
    final diary = await getDiaryFromServer(phone, token);
    final lst = json.decode(diary);

    final List<String> lstName = [];
    for (var item in lst) {
      final name = item["AppName"].toString();
      lstName.add(name);
    }
    setState(() {
      detail_item = lst;
      _itemList.addAll(lstName);
      if (_itemList.isEmpty) {
        textNoData = "Không có dữ liệu";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initDiary();
  }

  @override
  Widget build(BuildContext context) {
    var heightSize = MediaQuery.of(context).size.height;
    Routes.configureRoutes();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhật ký sử dụng'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Color.fromARGB(221, 255, 255, 255),
      body: Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
                  itemCount: _itemList.length,
                  padding: const EdgeInsets.all(8.0),
                  reverse: false,
                  itemBuilder: (_, int index) {
                    final item =
                        detail_item[index]["AppName"]; //_itemList[index];
                    final detail = detail_item[index];
                    return Card(
                      color: Color.fromARGB(255, 64, 183, 215),
                      child: ListTile(
                        title: Text(item),
                        leading: const Icon(Icons.web),
                        subtitle: Text(item),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          onPressed: () {
                            setState(() {
                              _deleteItem(index);
                            });
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detail(
                                  item: item, detail: detail_item[index]),
                            ),
                          );
                          //log('vao day');
                          // Chuyển tới màn hình chi tiết và truyền tham số item
                          //_navigateToDetailScreen(context, item, "test");
                        },
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  void _deleteItem(int index) {
    _itemList.removeAt(index);
  }

  void _navigateToDetailScreen(
      BuildContext context, String item, String detail) {
    String route = '/detail/$item';
    Routes.router.navigateTo(context, route, transition: TransitionType.fadeIn);
  }
}
