// File: lib/presentation/features/drug_search/screens/drug_search_results_screen.dart
import 'package:flutter/material.dart';
import 'package:medigo/core/theme/spacing.dart';
import 'package:medigo/service/drug_search_service.dart';

class DrugSearchResultsScreen extends StatefulWidget {
  final String searchQuery;

  const DrugSearchResultsScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  _DrugSearchResultsScreenState createState() => _DrugSearchResultsScreenState();
}

class _DrugSearchResultsScreenState extends State<DrugSearchResultsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchQuery;
    _currentQuery = widget.searchQuery;
    _performSearch(widget.searchQuery);
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _currentQuery = query;
    });

    try {
      final results = await DrugSearchService.searchMedication(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la recherche: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with search
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Back button and title
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back, size: 24),
                      ),
                      SizedBox(width: AppSpacing.space16(context)),
                      Expanded(
                        child: Text(
                          _currentQuery,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSpacing.space16(context)),

                  // Search bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSecondary,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onSubmitted: _performSearch,
                            decoration: InputDecoration(
                              hintText: "Chercher un médicament...",
                              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).focusColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: AppSpacing.space8(context)),
                      GestureDetector(
                        onTap: () => _performSearch(_searchController.text),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Results
            Expanded(
              child: _isLoading
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: AppSpacing.space16(context)),
                    Text("Recherche en cours..."),
                  ],
                ),
              )
                  : _searchResults.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: AppSpacing.space16(context)),
                    Text(
                      "Aucun résultat trouvé",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: AppSpacing.space8(context)),
                    Text(
                      "Essayez avec un autre nom de médicament",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final result = _searchResults[index];
                  return _buildSearchResultCard(result);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultCard(Map<String, dynamic> result) {
    final pharmacy = result['pharmacy'];
    final medication = result['medication'];
    final bool inStock = medication['inStock'];

    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.space16(context)),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: inStock ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pharmacy header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.local_pharmacy,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 20,
                ),
              ),
              SizedBox(width: AppSpacing.space16(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pharmacy['name'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      pharmacy['hours'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              // Stock status
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: inStock ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  inStock ? "En stock" : "Rupture",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: AppSpacing.space16(context)),

          // Medication details
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.medication,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 20,
                ),
                SizedBox(width: AppSpacing.space8(context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medication['name'].toString().toUpperCase(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (inStock) ...[
                        Text(
                          "${medication['price']} FCFA",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Quantité: ${medication['quantity']}",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: AppSpacing.space16(context)),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _callPharmacy(pharmacy),
                  icon: Icon(Icons.phone, size: 16),
                  label: Text('Appeler'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.space8(context)),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _getDirections(pharmacy),
                  icon: Icon(Icons.directions, size: 16),
                  label: Text('Itinéraire'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _callPharmacy(Map<String, dynamic> pharmacy) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Appel vers ${pharmacy['name']} - ${pharmacy['phone']}"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _getDirections(Map<String, dynamic> pharmacy) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Itinéraire vers ${pharmacy['name']}"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}