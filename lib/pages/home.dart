import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_8/pages/create.dart';
import 'package:flutter_8/services/http_service.dart';
import 'package:flutter_8/services/logger.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

import '../ models/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //apiPostList();
    var post = Post( title: 'til', body: 'tana', userId: 1);
    apiPostCreate(post);
  }

  //list
  void apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_POST, Network.paramsEmpty());
    setState(() {
      isLoading = false;
      if (response != null) {
        items = Network.parsePostList(response);
      } else {
        items = [];
      }
    });
  }

  //create
  void apiPostCreate(Post post) async {
    var response =
        await Network.POST(Network.API_POST, Network.paramsCreate(post));
  }

  //update
  void apiPostUpdate(Post post) async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.PUT(
        Network.API_UPDATE + post.id.toString(), Network.paramsUpdate(post));
    setState(() {
      if (response != null) {
        apiPostList();
      } else {}
      isLoading = false;
    });
  }

  //delete
  void apiPostDelete(Post post) async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.DEL(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    setState(() {
      if (response != null) {
        apiPostList();
      } else {}
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return itemOfPost(items[index]);
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CreatePage(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemOfPost(Post post) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              apiPostUpdate(post);
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Update',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              apiPostDelete(post);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title!.toUpperCase()),
            const SizedBox(height: 5),
            Text(post.body.toString()),
          ],
        ),
      ),
    );
  }
}
