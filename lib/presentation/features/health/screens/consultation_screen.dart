import 'package:flutter/material.dart';
import 'package:medigo/core/theme/spacing.dart';
import 'package:medigo/presentation/shared/widgets/CustomTextField.dart';

import 'doctor_chat_screen.dart';

class ConsultationScreen extends StatefulWidget {
  @override
  _ConsultationScreenState createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  String _selectedSpecialty = 'Tout';

  final List<String> _specialties = [
    'Tout',
    'Dentiste',
    'Ophtalmo',
    'Psychiatre',
    'Cardiologue',
    'Pédiatre',
  ];

  final List<Map<String, dynamic>> _myDoctors = [
    {
      'name': 'Dr. Fatah',
      'specialty': 'Dentiste',
      'location': 'Infirmerie de l\'EPT',
      'avatar': 'assets/fatah.jpg',
      'rating': 4.5,
      'isOnline': true,
    },
    {
      'name': 'Dr. Aminata',
      'specialty': 'Pédiatre',
      'location': 'Clinique des Enfants',
      'avatar': 'assets/aminata.jpg',
      'rating': 4.8,
      'isOnline': false,
    },
    {
      'name': 'Dr. Omar',
      'specialty': 'Cardiologue',
      'location': 'Hôpital Principal',
      'avatar': 'assets/omar.jpg',
      'rating': 4.6,
      'isOnline': true,
    },
  ];

  final List<Map<String, dynamic>> _availableDoctors = [
    {
      'name': 'Dr. Fatah',
      'specialty': 'Dentiste',
      'location': 'Infirmerie de l\'EPT',
      'avatar': 'assets/fatah.jpg',
      'rating': 4.5,
      'isOnline': true,
      'nextAvailable': 'Disponible maintenant',
    },
    {
      'name': 'Dr. Khadija',
      'specialty': 'Ophtalmo',
      'location': 'Centre Vision',
      'avatar': 'assets/khadija.jpg',
      'rating': 4.7,
      'isOnline': true,
      'nextAvailable': 'Disponible maintenant',
    },
    {
      'name': 'Dr. Moussa',
      'specialty': 'Psychiatre',
      'location': 'Cabinet Privé',
      'avatar': 'assets/moussa.jpg',
      'rating': 4.9,
      'isOnline': false,
      'nextAvailable': 'Disponible à 14h',
    },
    {
      'name': 'Dr. Aminata',
      'specialty': 'Pédiatre',
      'location': 'Clinique des Enfants',
      'avatar': 'assets/aminata.jpg',
      'rating': 4.8,
      'isOnline': true,
      'nextAvailable': 'Disponible maintenant',
    },
  ];

  List<Map<String, dynamic>> get _filteredDoctors {
    if (_selectedSpecialty == 'Tout') {
      return _availableDoctors;
    }
    return _availableDoctors.where((doctor) =>
    doctor['specialty'] == _selectedSpecialty
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/logo-medigo.png",
                        height: 36,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.medical_services,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                      ),
                      SizedBox(width: AppSpacing.space16(context)),
                      Text(
                        "Medigo",
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  GestureDetector(
                    child: Icon(Icons.menu, size: 24),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.space32(context)),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mes médecins",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: AppSpacing.space16(context)),

                    // Horizontal scrollable list of my doctors
                    Container(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _myDoctors.length,
                        itemBuilder: (context, index) {
                          final doctor = _myDoctors[index];
                          return Container(
                            width: 100,
                            margin: EdgeInsets.only(right: AppSpacing.space16(context)),
                            child: GestureDetector(
                              onTap: () => _navigateToChat(doctor),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[300],
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            doctor['avatar'],
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) =>
                                                Icon(
                                                  Icons.person,
                                                  size: 35,
                                                  color: Colors.grey[600],
                                                ),
                                          ),
                                        ),
                                      ),
                                      if (doctor['isOnline'])
                                        Positioned(
                                          bottom: 5,
                                          right: 5,
                                          child: Container(
                                            width: 16,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                              border: Border.all(color: Colors.white, width: 2),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: AppSpacing.space8(context)),
                                  Text(
                                    doctor['name'].split(' ')[1], // Just the name part
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    doctor['specialty'],
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                      fontSize: 10,
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
                  ],
                ),
              ),

              SizedBox(height: AppSpacing.space32(context)),

              // Search bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: CustomTextField(hintText: "Opticien")),
                  ),
                  SizedBox(width: AppSpacing.space8(context)),
                  Container(
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
                ],
              ),

              SizedBox(height: AppSpacing.space32(context)),

              // Filter section
              Text(
                "Filtrer",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppSpacing.space16(context)),

              // Specialty filter chips
              Container(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _specialties.length,
                  itemBuilder: (context, index) {
                    final specialty = _specialties[index];
                    final isSelected = specialty == _selectedSpecialty;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSpecialty = specialty;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: AppSpacing.space16(context)),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                _getSpecialtyIcon(specialty),
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 24,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              specialty,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: AppSpacing.space32(context)),

              // Available doctors list
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                      ...(_filteredDoctors.map((doctor) => _buildDoctorCard(doctor))),
                  ],
                ),
              ),

              SizedBox(height: 100), // Space for navigation bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.space16(context)),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Doctor avatar
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: ClipOval(
                  child: Image.asset(
                    doctor['avatar'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.grey[600],
                        ),
                  ),
                ),
              ),
              if (doctor['isOnline'])
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(width: AppSpacing.space16(context)),

          // Doctor info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor['name'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  doctor['specialty'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  doctor['location'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  doctor['nextAvailable'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: doctor['isOnline'] ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Rating and actions
          Column(
            children: [
              // Rating
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      index < doctor['rating'].floor()
                          ? Icons.star
                          : index < doctor['rating']
                          ? Icons.star_half
                          : Icons.star_border,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 16,
                    );
                  }),
                ],
              ),
              SizedBox(height: AppSpacing.space8(context)),

              // Action buttons
              Row(
                children: [
                  // Call button
                  GestureDetector(
                    onTap: () => _callDoctor(doctor),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.phone,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.space8(context)),

                  // Chat button
                  GestureDetector(
                    onTap: () => _navigateToChat(doctor),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.chat,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getSpecialtyIcon(String specialty) {
    switch (specialty) {
      case 'Tout':
        return Icons.grid_view;
      case 'Dentiste':
        return Icons.medical_services;
      case 'Ophtalmo':
        return Icons.visibility;
      case 'Psychiatre':
        return Icons.psychology;
      case 'Cardiologue':
        return Icons.favorite;
      case 'Pédiatre':
        return Icons.child_care;
      default:
        return Icons.local_hospital;
    }
  }

  void _navigateToChat(Map<String, dynamic> doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DoctorChatScreen(doctor: doctor),
      ),
    );
  }

  void _callDoctor(Map<String, dynamic> doctor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Appel vers ${doctor['name']}..."),
        backgroundColor: Colors.green,
      ),
    );
  }
}