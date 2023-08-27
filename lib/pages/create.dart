import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var isLoading = false;

  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  var userIdController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Page'),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: bodyController,
                    decoration: const InputDecoration(
                      hintText: 'Body',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: userIdController,
                    decoration: const InputDecoration(
                      hintText: 'UserId',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
