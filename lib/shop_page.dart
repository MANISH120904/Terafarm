import 'package:flutter/material.dart';
import 'home_page.dart';
import 'community_page.dart';
import 'dashboard_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final int _selectedIndex = 3; 

  
  final List<Map<String, dynamic>> farmingTools = [
    {"name": "Pots", "image": "assets/pot.png", "quantity": 0},
    {"name": "Grow Bags", "image": "assets/growing_bags.png", "quantity": 0},
  ];

  final List<Map<String, dynamic>> seeds = [
    {"name": "Tomato seeds", "image": "assets/tomato_seed.png", "quantity": 0},
    {"name": "Beans seeds", "image": "assets/beans.png", "quantity": 0},
    {"name": "Apple seeds", "image": "assets/Apple.png", "quantity": 0},
    {"name": "Grape seeds", "image": "assets/grape.png", "quantity": 0},
  ];

  // Function to update quantity
  void updateQuantity(
    List<Map<String, dynamic>> category,
    int index,
    int change,
  ) {
    setState(() {
      category[index]["quantity"] = (category[index]["quantity"] + change)
          .clamp(0, 99);
    });
  }

  
  bool hasItemsInCart() {
    return farmingTools.any((item) => item["quantity"] > 0) ||
        seeds.any((item) => item["quantity"] > 0);
  }


  Widget buildInventoryItem(
    Map<String, dynamic> item,
    List<Map<String, dynamic>> category,
    int index,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            Image.asset(
              item["image"],
              width: 50,
              height: 50,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported,
                  size: 50,
                  color: Colors.grey,
                );
              },
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                item["name"],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.red),
                    onPressed: () {
                      updateQuantity(category, index, -1);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "${item["quantity"]}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.green),
                    onPressed: () {
                      updateQuantity(category, index, 1);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  void _onNavItemTapped(int index) {
    if (index == _selectedIndex) return; 

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CommunityPage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Shop"),
        backgroundColor: Colors.green.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const Text(
              "Inventory",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Farming tools",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children:
                  farmingTools
                      .asMap()
                      .entries
                      .map(
                        (entry) => buildInventoryItem(
                          entry.value,
                          farmingTools,
                          entry.key,
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 10),
            const Text(
              "Seeds",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children:
                  seeds
                      .asMap()
                      .entries
                      .map(
                        (entry) =>
                            buildInventoryItem(entry.value, seeds, entry.key),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
      floatingActionButton:
          hasItemsInCart()
              ? FloatingActionButton.extended(
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                },
                label: const Text("Buy Now"),
                icon: const Icon(Icons.shopping_cart),
              )
              : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: _onNavItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment),
            label: 'Community',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.agriculture), label: 'Farm'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shop'),
        ],
      ),
    );
  }
}
