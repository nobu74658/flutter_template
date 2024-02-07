import 'package:app/features/auth/screens/sign_up/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EntranceScreen extends HookWidget {
  const EntranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState<int>(0);
    final pages = [
      const Text('first page'),
      ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut().then(
                (_) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SignUpScreen()),
                ),
              );
        },
        child: const Text('log out'),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrance'),
      ),
      body: pages[currentIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (index) => currentIndex.value = index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
