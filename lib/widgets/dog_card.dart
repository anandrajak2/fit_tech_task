import 'package:flutter/material.dart';

import '../models/dog_image_model.dart';

class DogCard extends StatelessWidget {
  const DogCard({
    super.key,
    required this.dogImageModel,
  });

  final DogImageModel? dogImageModel;

  @override
  Widget build(BuildContext context) {
    return dogImageModel != null
        ? Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(width: 1, color: Colors.grey)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                dogImageModel!.message ?? '',
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.group);
                },
                fit: BoxFit.fill,
                // loadingBuilder: (context, child, loadingProgress) {
                //   return const CircularProgressIndicator();
                // },
              ),
            ),
          )
        : const Center(child: Text("No Data Found"));
  }
}
