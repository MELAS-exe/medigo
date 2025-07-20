import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:medigo/core/theme/spacing.dart';
import 'package:medigo/presentation/features/map/widgets/place_details_sheet.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  // Dakar coordinates (user's location)
  final LatLng _dakarCenter = LatLng(14.6937, -17.4441);

  String _selectedFilter = 'all'; // all, hospital, pharmacy
  bool _showBottomSheet = false;
  Map<String, dynamic>? _selectedPlace;

  // Sample data for pharmacies and hospitals in Dakar
  final List<Map<String, dynamic>> _places = [
    {
      'id': '1',
      'name': 'Pharmacie de l\'EPT',
      'type': 'pharmacy',
      'location': LatLng(14.6947, -17.4451),
      'address': 'Route de la Marine Française, Dakar',
      'hours': '9h-18h',
      'phone': '77 123 45 67',
      'hasStock': true,
      'medications': ['Doliprane', 'Augmentin', 'Soclav'],
    },
    {
      'id': '2',
      'name': 'Hôpital Principal de Dakar',
      'type': 'hospital',
      'location': LatLng(14.6957, -17.4431),
      'address': 'Avenue Cheikh Anta Diop, Dakar',
      'hours': '24h/24',
      'phone': '33 889 12 34',
      'services': ['Urgences', 'Cardiologie', 'Chirurgie'],
    },
    {
      'id': '3',
      'name': 'Pharmacie Khadidiatou BA',
      'type': 'pharmacy',
      'location': LatLng(14.6927, -17.4471),
      'address': 'Quartier Bass, Dakar',
      'hours': '8h-20h',
      'phone': '77 987 65 43',
      'hasStock': true,
      'medications': ['Paracétamol', 'Amoxicilline'],
    },
    {
      'id': '4',
      'name': 'Hôpital Cheikh Khalifa',
      'type': 'hospital',
      'location': LatLng(14.6907, -17.4401),
      'address': 'Sokhna Diarra Sow, Dakar',
      'hours': '24h/24',
      'phone': '33 456 78 90',
      'services': ['Cardiologie', 'Neurologie', 'Pédiatrie'],
    },
    {
      'id': '5',
      'name': 'Pharmacie Chamsoul Houda',
      'type': 'pharmacy',
      'location': LatLng(14.6887, -17.4481),
      'address': 'Avenue Thierry, Dakar',
      'hours': '9h-19h',
      'phone': '77 321 54 87',
      'hasStock': false,
      'medications': ['Aspirine', 'Ibuprofène'],
    },
    {
      'id': '6',
      'name': 'COTAS (Centre Ophtalmologique)',
      'type': 'hospital',
      'location': LatLng(14.6977, -17.4411),
      'address': 'Rue de Thiong, Dakar',
      'hours': '8h-17h',
      'phone': '33 654 32 10',
      'services': ['Ophtalmologie', 'Chirurgie oculaire'],
    },
    {
      'id': '7',
      'name': 'Pharmacie Le Fogny',
      'type': 'pharmacy',
      'location': LatLng(14.6867, -17.4511),
      'address': 'Quartier Le Fogny, Dakar',
      'hours': '9h-18h',
      'phone': '77 147 85 96',
      'hasStock': true,
      'medications': ['Vitamines', 'Antiseptiques'],
    },
    {
      'id': '8',
      'name': 'Pharmacie Sophie Samb',
      'type': 'pharmacy',
      'location': LatLng(14.6997, -17.4391),
      'address': 'Caty F DIOP, Dakar',
      'hours': '8h-20h',
      'phone': '77 258 14 73',
      'hasStock': true,
      'medications': ['Antibiotiques', 'Antalgiques'],
    },
    {
      'id': '9',
      'name': 'Clinique Cheikh Sidaty',
      'type': 'hospital',
      'location': LatLng(14.6847, -17.4521),
      'address': 'Avenue Thierry, Dakar',
      'hours': '24h/24',
      'phone': '33 789 45 62',
      'services': ['Médecine générale', 'Radiologie'],
    },
  ];

  List<Map<String, dynamic>> get _filteredPlaces {
    switch (_selectedFilter) {
      case 'hospital':
        return _places.where((place) => place['type'] == 'hospital').toList();
      case 'pharmacy':
        return _places.where((place) => place['type'] == 'pharmacy').toList();
      default:
        return _places;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Map
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _dakarCenter,
                initialZoom: 13.0,
                onTap: (tapPosition, point) {
                  setState(() {
                    _showBottomSheet = false;
                  });
                },
              ),
              children: [
                // Map tiles
                TileLayer(
                  urlTemplate: 'https://api.mapbox.com/styles/v1/sirnoodles/cmdawukd806qr01sh809m64hg/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2lybm9vZGxlcyIsImEiOiJjbThzdHpsajkwNG9zMmxzNjhpMzYyOHlwIn0.3wexSseFBrrLiL01q3LgHg',
                  userAgentPackageName: 'com.medigo.medigo',
                ),

                // Markers for places
                MarkerLayer(
                  markers: _buildMarkers(),
                ),

                // User location marker
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _dakarCenter,
                      width: 40,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Top controls
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Text(
                'Pousser pour naviguer',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Menu button
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.menu, size: 24),
              ),
            ),

            // Bottom controls
            Positioned(
              bottom: 120,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Proches',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppSpacing.space16(context)),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFilterButton(
                          'Hôpital',
                          Icons.local_hospital,
                          'hospital',
                        ),
                        _buildFilterButton(
                          'Pharmacie',
                          Icons.local_pharmacy,
                          'pharmacy',
                        ),
                        _buildFilterButton(
                          'Chercher',
                          Icons.search,
                          'search',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Place details bottom sheet
            if (_showBottomSheet && _selectedPlace != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: PlaceDetailsSheet(
                  place: _selectedPlace!,
                  onClose: () {
                    setState(() {
                      _showBottomSheet = false;
                    });
                  },
                  onGetDirections: () => _getDirections(_selectedPlace!),
                  onCall: () => _callPlace(_selectedPlace!),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Marker> _buildMarkers() {
    return _filteredPlaces.map((place) {
      return Marker(
        point: place['location'],
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => _onMarkerTapped(place),
          child: Container(
            decoration: BoxDecoration(
              color: place['type'] == 'hospital'
                  ? Colors.red
                  : Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              place['type'] == 'hospital'
                  ? Icons.local_hospital
                  : Icons.local_pharmacy,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildFilterButton(String label, IconData icon, String filter) {
    final isSelected = _selectedFilter == filter ||
        (filter == 'search' && _selectedFilter == 'all');

    return GestureDetector(
      onTap: () => _onFilterTapped(filter),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onSurface,
              size: 28,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _onMarkerTapped(Map<String, dynamic> place) {
    setState(() {
      _selectedPlace = place;
      _showBottomSheet = true;
    });

    // Center map on selected place
    _mapController.move(place['location'], 15.0);
  }

  void _onFilterTapped(String filter) {
    setState(() {
      if (filter == 'search') {
        _selectedFilter = 'all';
        _showSearchDialog();
      } else {
        _selectedFilter = _selectedFilter == filter ? 'all' : filter;
      }
      _showBottomSheet = false;
    });
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rechercher'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Nom du lieu ou médicament...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement search logic
            },
            child: Text('Rechercher'),
          ),
        ],
      ),
    );
  }

  void _getDirections(Map<String, dynamic> place) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Itinéraire vers ${place['name']}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _callPlace(Map<String, dynamic> place) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appel vers ${place['name']} - ${place['phone']}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}