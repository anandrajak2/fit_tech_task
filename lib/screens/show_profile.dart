import 'package:flutter/material.dart';
import 'package:task_project_16/models/userListResponse.dart';
import 'package:task_project_16/networks/network_call.dart';

import '../widgets/user_card.dart';

class ShowProfileScreen extends StatefulWidget {
  const ShowProfileScreen({super.key});

  @override
  State<ShowProfileScreen> createState() => _ShowProfileScreenState();
}

class _ShowProfileScreenState extends State<ShowProfileScreen> {
  UsersListModel? usersListModel;
  bool isLoading = true;
  getUserDetails() async {
    setState(() {
      isLoading = true;
    });
    var response = await NetworkCall().getUserList();
    setState(() {
      isLoading = false;
    });
    response.fold((l) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("!Error"),
              content: Text(l.message ?? ''),
            );
          });
    }, (r) {
      setState(() {
        usersListModel = r;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      getUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Show Users List Screen"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: usersListModel != null
                  ? ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: usersListModel?.results.length,
                      itemBuilder: ((context, index) {
                        return UserCard(result: usersListModel!.results[index]);
                      }))
                  : const Center(child: Text("No Data Found")),
            ),
    );
  }
}
