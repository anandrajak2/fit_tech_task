import 'package:flutter/material.dart';
import 'package:task_project_16/extenstions/utils_extentions.dart';

import '../models/userListResponse.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.result,
  });

  final Result result;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: Colors.grey)),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 4.0, right: 20),
        horizontalTitleGap: 5,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(width: 1, color: Colors.grey)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45),
            child: Image.network(
              result.picture.medium ?? '',
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.group);
              },
              fit: BoxFit.fill,
              // loadingBuilder: (context, child, loadingProgress) {
              //   return const CircularProgressIndicator();
              // },
            ),
          ),
        ),
        title: Text(
            "${result.name.title} ${result.name.first} ${result.name.last}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(result.email),
            Text(
                "${result.location.street} ${result.location.city} ${result.location.state}"),
            Text("Days Since Register : "
                "${result.registered.date.toString().calculateDaysSinceGivenDate()}")
          ],
        ),
      ),
    );
  }
}
