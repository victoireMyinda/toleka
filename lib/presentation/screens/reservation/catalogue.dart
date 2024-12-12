import 'package:flutter/material.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/screens/reservation/detailcar.dart';

class VehicleCatalogScreen extends StatefulWidget {
  @override
  _VehicleCatalogScreenState createState() => _VehicleCatalogScreenState();
}

class _VehicleCatalogScreenState extends State<VehicleCatalogScreen> {
  String searchQuery = "";
  String selectedFilter = "All";
  List? dataVehicule = [];
  bool isLoading = true;

  final List<String> filters = [
    "All",
    "Basic",
    "Confort",
    "Premium",
    "Familiale 7 places",
    "VIP 4x4"
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      Map? response = await SignUpRepository.getAllVehicule();
      List? vehicles = response["data"];

      setState(() {
        dataVehicule = vehicles?.reversed.toList() ?? [];
        isLoading = false;
      });
    } catch (e) {
      print("Error loading vehicles: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.8,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: dataVehicule
                        ?.where((vehicle) =>
                            (selectedFilter == "All" ||
                                vehicle['nom_categorie'] == selectedFilter) &&
                            (vehicle['nom_categorie']
                                    ?.toLowerCase()
                                    ?.contains(searchQuery.toLowerCase()) ??
                                false))
                        .length,
                    itemBuilder: (context, index) {
                      final filteredVehicles = dataVehicule
                          ?.where((vehicle) =>
                              (selectedFilter == "All" ||
                                  vehicle['nom_categorie'] == selectedFilter) &&
                              (vehicle['nom_categorie']
                                      ?.toLowerCase()
                                      ?.contains(searchQuery.toLowerCase()) ??
                                  false))
                          .toList();

                      final vehicle = filteredVehicles?[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CarDetailScreen()),
                          );
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage("assets/images/v1.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${vehicle['marque']} ${vehicle['modele']} - ${vehicle['nom_categorie']}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Tarif Journalier: \$${vehicle['tarif_journalier']}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
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
    );
  }
}
