import 'package:flutter/material.dart';
import 'detail_screen.dart';
import '../models/story_model.dart';
import '../services/hn_api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Future<List<int>> topStories;

  @override
  void initState() {
    super.initState();

    topStories = HNApiService.fetchTopStories();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Hacker News"),
      ),

      body: FutureBuilder<List<int>>(

        future: topStories,

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final ids = snapshot.data!;

          return ListView.builder(

            itemCount: 20,

            itemBuilder: (context, index) {

              return FutureBuilder<Story>(

                future: HNApiService.fetchStory(ids[index]),

                builder: (context, storySnapshot) {

                  if (!storySnapshot.hasData) {

                    return const ListTile(
                      title: Text("Loading..."),
                    );
                  }

                  final story = storySnapshot.data!;

                  return Padding(

                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    child: InkWell(

                      borderRadius: BorderRadius.circular(18),

                      onTap: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              storyId: story.id,
                            ),
                          ),
                        );
                      },

                      child: Container(

                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(

                          color: Colors.white,

                          borderRadius: BorderRadius.circular(18),

                          boxShadow: [

                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Text(

                              story.title,

                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.4,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Row(

                              children: [

                                const Icon(
                                  Icons.person,
                                  size: 18,
                                  color: Colors.orange,
                                ),

                                const SizedBox(width: 5),

                                Expanded(
                                  child: Text(
                                    story.by,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),

                                const Icon(
                                  Icons.arrow_upward,
                                  size: 18,
                                  color: Colors.orange,
                                ),

                                const SizedBox(width: 4),

                                Text(
                                  "${story.score}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}