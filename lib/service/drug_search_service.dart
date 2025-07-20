// File: lib/service/drug_search_service.dart
import 'dart:async';
import 'package:latlong2/latlong.dart';

class DrugSearchService {
  // Mock database of pharmacies with their medication inventory
  static final List<Map<String, dynamic>> _pharmacyInventory = [
    {
      'id': '1',
      'name': 'Pharmacie de l\'EPT',
      'type': 'pharmacy',
      'location': LatLng(14.6947, -17.4451),
      'address': 'Route de la Marine Française, Dakar',
      'hours': '9h-18h',
      'phone': '77 123 45 67',
      'medications': {
        'doliprane': {'inStock': true, 'price': 500, 'quantity': 25},
        'augmentin': {'inStock': true, 'price': 1200, 'quantity': 10},
        'soclav': {'inStock': true, 'price': 800, 'quantity': 15},
        'paracetamol': {'inStock': true, 'price': 300, 'quantity': 50},
        'aspirine': {'inStock': false, 'price': 400, 'quantity': 0},
      }
    },
    {
      'id': '2',
      'name': 'Pharmacie Khadidiatou BA',
      'type': 'pharmacy',
      'location': LatLng(14.6927, -17.4471),
      'address': 'Quartier Bass, Dakar',
      'hours': '8h-20h',
      'phone': '77 987 65 43',
      'medications': {
        'doliprane': {'inStock': true, 'price': 550, 'quantity': 30},
        'paracetamol': {'inStock': true, 'price': 350, 'quantity': 40},
        'amoxicilline': {'inStock': true, 'price': 900, 'quantity': 8},
        'soclav': {'inStock': false, 'price': 800, 'quantity': 0},
        'aspirine': {'inStock': true, 'price': 450, 'quantity': 20},
      }
    },
    {
      'id': '3',
      'name': 'Pharmacie Chamsoul Houda',
      'type': 'pharmacy',
      'location': LatLng(14.6887, -17.4481),
      'address': 'Avenue Thierry, Dakar',
      'hours': '9h-19h',
      'phone': '77 321 54 87',
      'medications': {
        'aspirine': {'inStock': true, 'price': 400, 'quantity': 35},
        'ibuprofene': {'inStock': true, 'price': 600, 'quantity': 12},
        'doliprane': {'inStock': true, 'price': 520, 'quantity': 18},
        'augmentin': {'inStock': false, 'price': 1200, 'quantity': 0},
      }
    },
    {
      'id': '4',
      'name': 'Pharmacie Le Fogny',
      'type': 'pharmacy',
      'location': LatLng(14.6867, -17.4511),
      'address': 'Quartier Le Fogny, Dakar',
      'hours': '9h-18h',
      'phone': '77 147 85 96',
      'medications': {
        'vitamines': {'inStock': true, 'price': 800, 'quantity': 25},
        'antiseptiques': {'inStock': true, 'price': 350, 'quantity': 30},
        'doliprane': {'inStock': true, 'price': 500, 'quantity': 22},
        'paracetamol': {'inStock': true, 'price': 320, 'quantity': 45},
      }
    },
    {
      'id': '5',
      'name': 'Pharmacie Sophie Samb',
      'type': 'pharmacy',
      'location': LatLng(14.6997, -17.4391),
      'address': 'Caty F DIOP, Dakar',
      'hours': '8h-20h',
      'phone': '77 258 14 73',
      'medications': {
        'antibiotiques': {'inStock': true, 'price': 1500, 'quantity': 8},
        'antalgiques': {'inStock': true, 'price': 700, 'quantity': 20},
        'doliprane': {'inStock': true, 'price': 480, 'quantity': 28},
        'soclav': {'inStock': true, 'price': 750, 'quantity': 12},
      }
    },
  ];

  static Future<List<Map<String, dynamic>>> searchMedication(String medicationName) async {
    // Simulate API delay
    await Future.delayed(Duration(milliseconds: 500));

    final normalizedQuery = medicationName.toLowerCase().trim();
    List<Map<String, dynamic>> results = [];

    for (var pharmacy in _pharmacyInventory) {
      Map<String, dynamic>? foundMedication;
      String? foundMedicationName;

      // Search through pharmacy medications
      for (var entry in pharmacy['medications'].entries) {
        String medName = entry.key.toLowerCase();
        if (medName.contains(normalizedQuery) || normalizedQuery.contains(medName)) {
          foundMedication = entry.value;
          foundMedicationName = entry.key;
          break;
        }
      }

      if (foundMedication != null) {
        results.add({
          'pharmacy': {
            'id': pharmacy['id'],
            'name': pharmacy['name'],
            'type': pharmacy['type'],
            'location': pharmacy['location'],
            'address': pharmacy['address'],
            'hours': pharmacy['hours'],
            'phone': pharmacy['phone'],
          },
          'medication': {
            'name': foundMedicationName,
            'inStock': foundMedication['inStock'],
            'price': foundMedication['price'],
            'quantity': foundMedication['quantity'],
          }
        });
      }
    }

    // Sort by availability first, then by price
    results.sort((a, b) {
      if (a['medication']['inStock'] && !b['medication']['inStock']) return -1;
      if (!a['medication']['inStock'] && b['medication']['inStock']) return 1;
      return a['medication']['price'].compareTo(b['medication']['price']);
    });

    return results;
  }

  static Future<List<String>> getMedicationSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 200));

    Set<String> allMedications = {};
    for (var pharmacy in _pharmacyInventory) {
      allMedications.addAll(pharmacy['medications'].keys.cast<String>());
    }

    final normalizedQuery = query.toLowerCase().trim();
    return allMedications
        .where((med) => med.toLowerCase().contains(normalizedQuery))
        .take(5)
        .toList();
  }

  static double calculateDistance(LatLng point1, LatLng point2) {
    const Distance distance = Distance();
    return distance.as(LengthUnit.Kilometer, point1, point2);
  }
}