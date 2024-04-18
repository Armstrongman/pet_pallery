import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostItem extends StatelessWidget {
  final String petName;
  final String username;
  final String description;
  final String imageUrl;
  final DateTime datePosted;

  const PostItem({
    Key? key,
    required this.petName,
    required this.username,
    required this.description,
    required this.imageUrl,
    required this.datePosted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$petName',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: double.infinity,
            child: Divider(color: Colors.grey,), // Add a divider between description and image
          ),
          imageUrl.isNotEmpty
              ? Container(
                  width: 300, // Set your desired width
                  height: 300, // Set your desired height
                  alignment: Alignment.center,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
              : SizedBox(), // Display image if available
          SizedBox(
            width: double.infinity,
            child: Divider(color: Colors.grey,), // Add a divider between description and image
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$username',
                  style: TextStyle(fontWeight: FontWeight.bold), // Bold style for the username
                ),
                TextSpan(
                  text: ' - $description', // Description remains normal
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          Text('Date Posted: ${DateFormat.yMMMd().format(datePosted)}'),
        ],
      ),
    );
  }
}
