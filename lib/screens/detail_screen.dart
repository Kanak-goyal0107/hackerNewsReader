import 'package:flutter/material.dart';

import '../models/story_model.dart';
import '../services/hn_api_service.dart';

class DetailScreen extends StatelessWidget {

  final int storyId;

  const DetailScreen({
    super.key,
    required this.storyId,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Story Details"),
      ),

      body: FutureBuilder<Story>(

        future: HNApiService.fetchStory(storyId),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: const [

                  CircularProgressIndicator(
                    color: Colors.orange,
                  ),

                  SizedBox(height: 16),

                  Text(
                    "Loading Story...",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }

          final story = snapshot.data!;

          return SingleChildScrollView(

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(

                    story.title,

                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(

                    children: [

                      const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.orange,

                        child: Icon(
                          Icons.person,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Text(
                        story.by,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Row(

                    children: [

                      Icon(
                        Icons.comment,
                        color: Colors.orange,
                      ),

                      SizedBox(width: 8),

                      Text(
                        "Comments",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  if (story.kids != null)

                    ...story.kids!.map((commentId) {

                      return FutureBuilder<Story>(

                        future: HNApiService.fetchStory(commentId),

                        builder: (context, commentSnapshot) {

                          if (!commentSnapshot.hasData) {

                            return const Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            );
                          }

                          final comment = commentSnapshot.data!;

                          return Card(

                            margin: const EdgeInsets.only(bottom: 10),

                            child: Padding(
                              padding: const EdgeInsets.all(12),

                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,

                                children: [

                                  Text(
                                    comment.by,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    comment.text ?? "No Comment",
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}