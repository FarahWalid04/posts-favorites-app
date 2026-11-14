
import 'package:hive/hive.dart';

import '../models/post_model.dart';

class FavoritesService {

  // Get the favorites box
  Box<Post> get _box => Hive.box<Post>('favoritesBox');

  // Add or remove a favorite post
  Future<void> toggleFavorite(Post post) async {

    if (_box.containsKey(post.id)) {

      // Remove from favorites
      await _box.delete(post.id);

    } else {

      // Create a copy of the post
      Post copy = Post(
        id: post.id,
        title: post.title,
        body: post.body,
        userId: post.userId,
      );

      // Save the copy using the post ID
      await _box.put(post.id, copy);
    }
  }

  // Check whether a post is a favorite
  bool isFavorite(int id) {
    return _box.containsKey(id);
  }

  // Get all favorite posts
  List<Post> getFavorites() {
    return _box.values.toList();
  }
}
