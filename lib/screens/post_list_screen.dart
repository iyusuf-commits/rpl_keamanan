import 'package:flutter/material.dart';
import '../models/post.dart';
import '../repositories/post_repository.dart';

class PostListScreen extends StatefulWidget {
  final PostRepository repository;
  const PostListScreen({super.key, required this.repository});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  List<Post> _posts = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final posts = await widget.repository.getPosts();
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Post'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_errorMessage', style: const TextStyle(color: Colors.red)),
            ElevatedButton(onPressed: _loadPosts, child: const Text('Coba Lagi')),
          ],
        ),
      );
    }
    if (_posts.isEmpty) return const Center(child: Text('Tidak ada post'));

    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
        );
      },
    );
  }
}