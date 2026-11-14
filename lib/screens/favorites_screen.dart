
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/post_model.dart';
import '../services/favorites_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final FavoritesService service = FavoritesService();

    return Scaffold(

      appBar: AppBar(
        title: const Text('My Favorites'),
      ),

      body: ValueListenableBuilder(

        valueListenable:
            Hive.box<Post>('favoritesBox').listenable(),

        builder: (context, box, child) {

          final favorites = service.getFavorites();

          // Empty state
          if (favorites.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.star_border,
                    size: 70,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    'Add some posts to your favorites!',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          // Display favorite posts
          return ListView.builder(

            itemCount: favorites.length,

            itemBuilder: (context, index) {

              Post post = favorites[index];

              return Card(
                margin: const EdgeInsets.all(8),

                child: ListTile(

                  leading: CircleAvatar(
                    child: Text(post.id.toString()),
                  ),

                  title: Text(
                    post.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    post.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  trailing: IconButton(

                    icon: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),

                    onPressed: () async {
                      await service.toggleFavorite(post);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
