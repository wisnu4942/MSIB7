import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();
  final ThirdScreenController thirdScreenController =
      Get.put(ThirdScreenController());

  List<dynamic> _users = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _hasMoreData) {
        _fetchUsers();
      }
    });
  }

  Future<void> _fetchUsers() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final response = await http
        .get(Uri.parse('https://reqres.in/api/users?page=$_page&per_page=10'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _page++;
        _users.addAll(data['data']);
        _isLoading = false;
        if (data['data'].length < 10) {
          _hasMoreData = false;
        }
      });
    } else {
      setState(() {
        _isLoading = false;
        _hasMoreData = false;
      });
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Third Screen',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.indigo[600],
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 1.0,
            color: Colors.grey[300],
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _page = 1;
                  _users.clear();
                  _hasMoreData = true;
                });
                await _fetchUsers();
              },
              child: _users.isEmpty
                  ? Center(child: Text('No Users Found'))
                  : ListView.separated(
                      controller: _scrollController,
                      itemCount: _users.length + 1,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey[300],
                          thickness: 1.0,
                          indent: 16.0,
                          endIndent: 16.0,
                        );
                      },
                      itemBuilder: (context, index) {
                        if (index == _users.length) {
                          return _hasMoreData
                              ? Center(child: CircularProgressIndicator())
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text('No more users to load')),
                                );
                        }
                        final user = _users[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user['avatar']),
                            radius: 40.0,
                          ),
                          title: Text.rich(
                            TextSpan(
                              text: '${user['first_name']} ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text: user['last_name'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(user['email']),
                          onTap: () {
                            thirdScreenController.setSelectedUserName(
                                '${user['first_name']} ${user['last_name']}');
                            Get.back();
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
