import 'package:flutter/material.dart';
import '../config/dependency_injector.dart';
import 'user_list_screen.dart';
import 'post_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Latihan 2: Mengambil instance repository dari DependencyInjector
    final di = DependencyInjector.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.security, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 24),
            const Text('Praktikum RPL & Keamanan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // Inject UserRepository
                    builder: (context) => UserListScreen(repository: di.userRepository),
                  ),
                );
              },
              icon: const Icon(Icons.people),
              label: const Text('Lihat Daftar Pengguna'),
            ),
            const SizedBox(height: 16),
            
            // LATIHAN 1: Tombol untuk layar Post
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // Inject PostRepository
                    builder: (context) => PostListScreen(repository: di.postRepository),
                  ),
                );
              },
              icon: const Icon(Icons.article),
              label: const Text('Lihat Daftar Post'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}