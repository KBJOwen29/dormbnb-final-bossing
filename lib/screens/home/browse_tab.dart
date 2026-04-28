import 'package:flutter/material.dart';
import '../../models/dorm_model.dart';
import '../../controller/dorm_controller.dart';

class BrowseScreen extends StatefulWidget {
  final String? initialCategory;
  const BrowseScreen({super.key, this.initialCategory});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedPriceFilter = "All";
  String _selectedCategoryFilter = "All";
  List<DormModel> _allDorms = [];
  List<DormModel> _filteredDorms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      _selectedCategoryFilter = widget.initialCategory!;
    }
    _fetchDorms();
  }

  Future<void> _fetchDorms() async {
    setState(() => _isLoading = true);
    try {
      final dorms = await DormController().getAllDorms();
      setState(() {
        _allDorms = dorms;
        _isLoading = false;
        _runFilter();
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching dorms: $e")),
        );
      }
    }
  }

  void _runFilter() {
    setState(() {
      _filteredDorms = _allDorms.where((dorm) {
        // 1. Match Search (Name or Address)
        final matchesSearch = dorm.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
            dorm.address.toLowerCase().contains(_searchController.text.toLowerCase());

        // 2. Match Price (Logic: Find the lowest non-zero price)
        final prices = [dorm.singleRoomPrice, dorm.doubleRoomPrice, dorm.bedSpacePrice]
            .where((p) => p > 0)
            .toList();

        // If no prices are set, default to 0.0 for comparison
        final minPrice = prices.isEmpty ? 0.0 : prices.reduce((a, b) => a < b ? a : b);

        bool matchesPrice = true;
        if (_selectedPriceFilter == "≤ ₱ 2k") {
          matchesPrice = minPrice <= 2000;
        } else if (_selectedPriceFilter == "₱ 2k - ₱ 4k") {
          matchesPrice = minPrice > 2000 && minPrice <= 4000;
        } else if (_selectedPriceFilter == "₱ 4k - ₱ 8k") {
          matchesPrice = minPrice > 4000 && minPrice <= 8000;
        }

        // 3. Match Category/Amenities
        bool matchesCategory = true;
        if (_selectedCategoryFilter == "Featured") {
          // Logic for featured: e.g. rating >= 4.0 as a proxy
          matchesCategory = dorm.rating >= 4.0;
        } else if (_selectedCategoryFilter == "Budget Friendly") {
          // Logic for budget friendly: e.g. min price <= 3000
          matchesCategory = minPrice > 0 && minPrice <= 3000;
        } else if (_selectedCategoryFilter != "All") {
          matchesCategory = dorm.amenities.contains(_selectedCategoryFilter);
        }

        return matchesSearch && matchesPrice && matchesCategory;
      }).toList();

      // If Budget Friendly is selected, also sort by price
      if (_selectedCategoryFilter == "Budget Friendly") {
        _filteredDorms.sort((a, b) {
          final pricesA = [a.singleRoomPrice, a.doubleRoomPrice, a.bedSpacePrice].where((p) => p > 0).toList();
          final pricesB = [b.singleRoomPrice, b.doubleRoomPrice, b.bedSpacePrice].where((p) => p > 0).toList();
          final minA = pricesA.isEmpty ? 0.0 : pricesA.reduce((a, b) => a < b ? a : b);
          final minB = pricesB.isEmpty ? 0.0 : pricesB.reduce((a, b) => a < b ? a : b);
          return minA.compareTo(minB);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔹 HEADER WITH BACKGROUND
          Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/images/LandingScreenBackground.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.white.withOpacity(0.4),
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          children: const [
                            Icon(Icons.arrow_back, color: Color(0xFF4A7DFF), size: 24),
                            SizedBox(width: 4),
                            Text(
                              "Back",
                              style: TextStyle(
                                color: Color(0xFF4A7DFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Browse Dorms",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 🔹 CONTENT AREA (Overlapping the header slightly)
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF8FBFF), // Very light blue-grey background
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔹 SEARCH BAR
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  hintText: "Search Dorms...",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.search, color: Colors.grey, size: 28),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                                ),
                                onSubmitted: (_) => _runFilter(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              onPressed: _runFilter,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4A7DFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                elevation: 2,
                              ),
                              child: const Text(
                                "Go",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // 🔹 FILTER CHIPS
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _priceFilterChip("All"),
                            _priceFilterChip("≤ ₱ 2k"),
                            _priceFilterChip("₱ 2k - ₱ 4k"),
                            _priceFilterChip("₱ 4k - ₱ 8k"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _categoryFilterChip("All"),
                            _categoryFilterChip("Featured"),
                            _categoryFilterChip("Budget Friendly"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      if (_isLoading)
                        const Expanded(child: Center(child: CircularProgressIndicator()))
                      else ...[
                        Text.rich(
                          TextSpan(
                            text: "Showing ",
                            style: const TextStyle(color: Colors.black87, fontSize: 15),
                            children: [
                              TextSpan(
                                text: "${_filteredDorms.length} Dorms",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const TextSpan(text: " near you"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // 🔹 DORM LIST
                        Expanded(
                          child: _filteredDorms.isEmpty
                              ? const Center(child: Text("No dorms found matching your filters."))
                              : ListView.builder(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  itemCount: _filteredDorms.length,
                                  itemBuilder: (context, index) {
                                    return _DormCard(dorm: _filteredDorms[index]);
                                  },
                                ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _priceFilterChip(String label) {
    bool isSelected = _selectedPriceFilter == label;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) {
          setState(() {
            _selectedPriceFilter = label;
          });
          _runFilter();
        },
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF4A7DFF),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade400,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget _categoryFilterChip(String label) {
    bool isSelected = _selectedCategoryFilter == label;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) {
          setState(() {
            _selectedCategoryFilter = label;
          });
          _runFilter();
        },
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF4A7DFF),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade400,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: const Color(0xFF4A7DFF),
        unselectedItemColor: Colors.grey.shade400,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            activeIcon: CircleAvatar(
              backgroundColor: Color(0xFF4A7DFF),
              child: Icon(Icons.search, color: Colors.white),
            ),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined, size: 28), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.mail_outline, size: 28), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 28), label: ""),
        ],
      ),
    );
  }
}

class _DormCard extends StatelessWidget {
  final DormModel dorm;
  const _DormCard({required this.dorm});

  String _getDormImage(String name) {
    if (name.contains('Marigold')) return 'lib/assets/images/DormAlpha.png';
    if (name.contains('Azure')) return 'lib/assets/images/DormBeta.png';
    if (name.contains('Modern Arch')) return 'lib/assets/images/DormCharlie.png';
    if (name.contains('Serene Stay')) return 'lib/assets/images/DormDelta.png';
    return 'lib/assets/images/DormAlpha.png'; // Default
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // 🔹 Dorm Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Image.asset(
                _getDormImage(dorm.name),
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const SizedBox(width: 110, height: 110, child: Icon(Icons.image_not_supported, size: 40)),
              ),
            ),
            // 🔹 Dorm Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dorm.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF333333),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 12, color: Colors.grey),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            dorm.address,
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₱ ${dorm.bedSpacePrice.toStringAsFixed(0)}/mo",
                          style: const TextStyle(
                            color: Color(0xFF4A7DFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xFF4A7DFF), size: 16),
                            Text(
                              " ${dorm.rating} (${dorm.numOfRating})",
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children: dorm.amenities.map((tag) => _tag(tag)).toList(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
