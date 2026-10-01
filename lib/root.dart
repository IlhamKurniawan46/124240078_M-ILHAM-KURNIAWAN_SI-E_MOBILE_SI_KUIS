import 'package:flutter/material.dart';
import 'home.dart';
import 'profile.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _selectedIndex = 0;

  // Method bantuan untuk membuat ikon dengan background
  Widget _buildIcon(IconData iconData, int index) {
    bool isSelected = _selectedIndex == index;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blueAccent : Colors.transparent, // Background oranye saat dipilih
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        iconData,
        color: isSelected ? Colors.white : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      const ProfilePage(nama: 'Ilham'),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent, // Warna teks saat terpilih
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.shopping_bag, 0),
            label: 'Barang',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.person, 1),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}