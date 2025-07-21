import 'package:flutter/material.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController(text: 'Paris');

  // Categories for horizontal scroll
  final List<Map<String, dynamic>> categories = [
    {'icon': '🍽️', 'label': 'Food', 'color': Colors.orange[100]},
    {'icon': '🎭', 'label': 'Experience', 'color': Colors.purple[100]},
    {'icon': '🚗', 'label': 'Transport', 'color': Colors.blue[100]},
    {'icon': '📷', 'label': 'Photography', 'color': Colors.green[100]},
    {'icon': '🗽', 'label': 'Culture', 'color': Colors.teal[100]},
    {'icon': '🏆', 'label': 'Sport', 'color': Colors.yellow[100]},
  ];

  // Top destinations with flags
  final List<Map<String, dynamic>> destinations = [
    {'id': 1, 'name': 'Paris', 'flag': '🇫🇷', 'country': 'France'},
    {'id': 2, 'name': 'London', 'flag': '🇬🇧', 'country': 'UK'},
    {'id': 3, 'name': 'Tokyo', 'flag': '🇯🇵', 'country': 'Japan'},
    {'id': 4, 'name': 'New York', 'flag': '🇺🇸', 'country': 'USA'},
    {'id': 5, 'name': 'Dubai', 'flag': '🇦🇪', 'country': 'UAE'},
    {'id': 6, 'name': 'Sydney', 'flag': '🇦🇺', 'country': 'Australia'},
  ];

  final List<Map<String, dynamic>> hotels = [
    {
      'id': 1,
      'name': 'Jasmine Bell',
      'location': 'Thailand',
      'rating': 4.8,
      'price': 120,
      'image': '👩‍💼',
      'reviews': 'Very Good',
    },
    {
      'id': 2,
      'name': 'Jasmine Bell',
      'location': 'Thailand',
      'rating': 4.8,
      'price': 120,
      'image': '👨‍💼',
      'reviews': 'Very Good',
    },
    {
      'id': 3,
      'name': 'Jasmine Bell',
      'location': 'Thailand',
      'rating': 4.8,
      'price': 120,
      'image': '👩‍🎨',
      'reviews': 'Very Good',
    },
    {
      'id': 4,
      'name': 'Jasmine Bell',
      'location': 'Thailand',
      'rating': 4.8,
      'price': 120,
      'image': '👨‍🎨',
      'reviews': 'Very Good',
    },
  ];

  void _openSearchScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                SearchScreen(initialSearchQuery: searchController.text),
      ),
    );
  }

  void _onCategoryTapped(Map<String, dynamic> category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SearchScreen(initialSearchQuery: category['label']),
      ),
    );
  }

  void _onDestinationTapped(Map<String, dynamic> destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SearchScreen(initialSearchQuery: destination['name']),
      ),
    );
  }

  void _onHotelTapped(Map<String, dynamic> hotel) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(hotel['name']),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location: ${hotel['location']}'),
                Text('Rating: ${hotel['rating']} (${hotel['reviews']})'),
                Text('Price: \$${hotel['price']} per night'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => SearchScreen(
                            initialSearchQuery: hotel['location'],
                          ),
                    ),
                  );
                },
                child: Text('Book Now'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('9:41', style: TextStyle(fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(width: 2),
                      Container(
                        width: 16,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(width: 2),
                      Container(
                        width: 16,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(width: 2),
                      Container(
                        width: 24,
                        height: 12,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: EdgeInsets.all(16),
              child: GestureDetector(
                onTap: _openSearchScreen,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 12),
                      Text(
                        searchController.text.isEmpty
                            ? 'Paris'
                            : searchController.text,
                        style: TextStyle(
                          color:
                              searchController.text.isEmpty
                                  ? Colors.grey
                                  : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Categories Horizontal Scroll
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () => _onCategoryTapped(category),
                    child: Container(
                      width: 80,
                      margin: EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: category['color'],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                category['icon'],
                                style: TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            category['label'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 24),

            // Top Destination
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top destination',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'See more',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: destinations.length,
                      itemBuilder: (context, index) {
                        final dest = destinations[index];
                        return GestureDetector(
                          onTap: () => _onDestinationTapped(dest),
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  dest['flag'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  dest['name'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Super Hotel
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Super hotel',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'See more',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: hotels.length,
                        itemBuilder: (context, index) {
                          final hotel = hotels[index];
                          return GestureDetector(
                            onTap: () => _onHotelTapped(hotel),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 16),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        hotel['image'],
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          hotel['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          hotel['location'],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 12,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '${hotel['rating']}',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '(${hotel['reviews']})',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$${hotel['price']}',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'per night',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
