import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_pallery/Pages/Home%20Pages/comment_page.dart';
import 'package:pet_pallery/Pages/User%20Pages/user_page.dart';

class PostItem extends StatelessWidget {
  // Declaring variables
  final String petName;
  final String userId;
  final String username;
  final String postId;
  final String description;
  final String imageUrl;
  final DateTime datePosted;

  // Constructor that will be used to build out a post widget with the information passed into it
  const PostItem({
    Key? key,
    required this.petName,
    required this.username,
    required this.description,
    required this.imageUrl,
    required this.datePosted, required this.userId, required this.postId
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
        // Showing the name of the pet at the top of the page
        Text(
          '$petName',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // Add a divider between description and image
        SizedBox(
          width: double.infinity,
          child: Divider(color: Colors.grey,),
        ),
        // Displaying the image based off of the url in the collection instance
        imageUrl.isNotEmpty
            ? Container(
                width: 300,
                height: 300,
                alignment: Alignment.center,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              )
            : SizedBox(),
        // Add a divider between description and image
        SizedBox(
          width: double.infinity,
          child: Divider(color: Colors.grey,),
        ),
        GestureDetector(
          onTap: () {
            // Navigate to the user's page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserPage(documentId: '$userId',)),
            );
          },
          // Bold style for the username
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$username',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' - $description', // Description remains normal
                ),
              ],
            ),
          ),
        ),
        // Gesture detector to visit the comment section of this post
        GestureDetector(
          onTap: () {
            // Navigate to the user's page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CommentPage(documentId: '$postId',)),
            );
          },
          child: Text(
            'View Comments',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
        SizedBox(height: 5.0),
        // Show the day of when the post was uploaded
        Text('Date Posted: ${DateFormat.yMMMd().format(datePosted)}'),
      ],
    ),
  );
}

}
