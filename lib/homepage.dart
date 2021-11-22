// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_app/config.dart';
import 'package:user_app/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = Uri.parse("https://reqres.in/api/users");
  var res, list = true, isSearching = false, isDark = false;
  var users = [];
  var filterusers = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    res = await http.get(url);
    users = filterusers = jsonDecode(res.body)['data'];
    setState(() {});
  }

  void _filteruser(value) {
    setState(() {
      filterusers = users
          .where(
            (user) =>
                user['first_name'].toLowerCase().contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = "User App";
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading:
            isDark
            ? IconButton(
              onPressed: () {
                currentTheme.switchTheme();
                isDark = !isDark;
                setState(() {});
              },
              icon: Icon(Icons.wb_sunny),
            )
            : IconButton(
              onPressed: () {
                currentTheme.switchTheme();
                isDark = !isDark;
                setState(() {});
              },
              icon: Icon(Icons.brightness_2_outlined),
            ),
            title: !isSearching
                ? Text(data)
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        _filteruser(value);
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: 'Search user',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
            elevation: 0.0,
            actions: <Widget>[
              isSearching
                  ? IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        isSearching = false;
                        filterusers = users;
                        setState(() {});
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        isSearching = true;
                        setState(() {});
                      },
                    )
            ]
          ),
        body: Center(
          child: res != null
              ? list
                  ? ListView.builder(
                      itemCount: filterusers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              filterusers[index]['avatar'] ??
                                  "http://www.4motiondarlington.org/wp-content/uploads/2013/06/No-image-found.jpg",
                            ),
                          ),
                          title: Text(
                            "${filterusers[index]['first_name']}",
                            style: const TextStyle(
                              fontSize: 26,
                            ),
                          ),
                          subtitle: Text(
                            "${filterusers[index]['last_name']}",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserDetail(user: filterusers[index]),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: filterusers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              filterusers[index]["avatar"] ??
                                  "http://www.4motiondarlington.org/wp-content/uploads/2013/06/No-image-found.jpg",
                            ),
                          ),
                          title: Text(
                            "${filterusers[index]["first_name"]}",
                            style: const TextStyle(
                              fontSize: 26,
                            ),
                          ),
                          subtitle: Text(
                            "${filterusers[index]["last_name"]}",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserDetail(user: filterusers[index]),
                              ),
                            );
                          },
                        );
                      },
                    )
              : const CircularProgressIndicator(
                  backgroundColor: Colors.white),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            list = !list;
            setState(() {});
          },
          child:
              list ? const Icon(Icons.grid_3x3) : const Icon(Icons.list)));
  }
}
