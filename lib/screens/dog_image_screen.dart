import 'package:flutter/material.dart';
import 'package:task_project_16/models/dog_image_model.dart';

import '../networks/network_call.dart';
import '../widgets/dog_card.dart';

class DogImageScreen extends StatefulWidget {
  const DogImageScreen({super.key});

  @override
  State<DogImageScreen> createState() => _DogImageScreenState();
}

class _DogImageScreenState extends State<DogImageScreen> {
  DogImageModel? dogImageModel;
  bool isLoading = true;

  getDogDetails() async {
    setState(() {
      isLoading = true;
    });
    var response = await NetworkCall().getDogImage();
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
        dogImageModel = r;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      getDogDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Show Dogs Screen"),
        actions: [
          IconButton(
              onPressed: () {
                getDogDetails();
              },
              icon: const Icon(Icons.refresh_outlined))
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : DogCard(dogImageModel: dogImageModel),
      ),
    );
  }
}
