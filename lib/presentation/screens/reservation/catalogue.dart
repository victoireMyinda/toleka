import 'package:flutter/material.dart';
import 'package:toleka/presentation/screens/reservation/detailcar.dart';

class VehicleCatalogScreen extends StatefulWidget {
  @override
  _VehicleCatalogScreenState createState() => _VehicleCatalogScreenState();
}

class _VehicleCatalogScreenState extends State<VehicleCatalogScreen> {
  String searchQuery = "";
  String selectedFilter = "All";

  final List<Map<String, dynamic>> vehicles = [
    {
      "image":
          "https://i.pinimg.com/736x/7a/0a/5f/7a0a5f7ee7732e8195576f5c8223420b.jpg",
      "type": "VIP",
      "price": 120,
    },
    {
      "image":
          "https://i.pinimg.com/736x/98/bd/b1/98bdb1cb36c200937d2d49129a77431e.jpg",
      "type": "Basic",
      "price": 80,
    },
    {
      "image":
          "https://i.pinimg.com/736x/3e/7f/fd/3e7ffdcb36154d6340ced09fb2a38e55.jpg",
      "type": "Confort",
      "price": 100,
    },
    {
      "image":
          "https://i.pinimg.com/736x/7a/0a/5f/7a0a5f7ee7732e8195576f5c8223420b.jpg",
      "type": "VIP",
      "price": 120,
    },
    {
      "image":
          "https://i.pinimg.com/736x/98/bd/b1/98bdb1cb36c200937d2d49129a77431e.jpg",
      "type": "Basic",
      "price": 80,
    },
    {
      "image":
          "https://i.pinimg.com/736x/3e/7f/fd/3e7ffdcb36154d6340ced09fb2a38e55.jpg",
      "type": "Confort",
      "price": 100,
    },
    {
      "image":
          "https://i.pinimg.com/736x/7a/0a/5f/7a0a5f7ee7732e8195576f5c8223420b.jpg",
      "type": "VIP",
      "price": 120,
    },
    {
      "image":
          "https://i.pinimg.com/736x/98/bd/b1/98bdb1cb36c200937d2d49129a77431e.jpg",
      "type": "Basic",
      "price": 80,
    },
    {
      "image":
          "https://i.pinimg.com/736x/3e/7f/fd/3e7ffdcb36154d6340ced09fb2a38e55.jpg",
      "type": "Confort",
      "price": 100,
    },
  ];

  final List<String> filters = [
    "All",
    "VIP",
    "Basic",
    "Confort",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Catalogue de Véhicules',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0XFF0c3849),
        iconTheme: const IconThemeData(
            color: Colors.white), // Icône de retour en blanc
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Rechercher',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0XFF0c3849)),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = filters[index];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: selectedFilter == filters[index]
                          ? const Color(0XFF0c3849)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        filters[index],
                        style: TextStyle(
                          color: selectedFilter == filters[index]
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              padding: const EdgeInsets.all(8.0),
              itemCount: vehicles
                  .where((vehicle) =>
                      (selectedFilter == "All" ||
                          vehicle['type'] == selectedFilter) &&
                      vehicle['type']
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()))
                  .length,
              itemBuilder: (context, index) {
                final filteredVehicles = vehicles
                    .where((vehicle) =>
                        (selectedFilter == "All" ||
                            vehicle['type'] == selectedFilter) &&
                        vehicle['type']
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()))
                    .toList();

                final vehicle = filteredVehicles[index];

                return GestureDetector(
                  onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  CarDetailScreen()),
                        );
                      },

                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4.0)),
                          child: Image.network(
                            vehicle['image'],
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.error,
                              size: 100,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${vehicle['type']} - \$${vehicle['price']}', // Type et prix sur une seule ligne sans espace
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const Center(
                          child: Text(
                            'detail vehicule', // Type et prix sur une seule ligne sans espace
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
