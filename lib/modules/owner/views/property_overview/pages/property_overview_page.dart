import 'package:boarding_house_app/modules/owner/views/property_overview/components/property_card.dart';
import 'package:flutter/material.dart';

class PropertyOverviewPage extends StatelessWidget {
  const PropertyOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final properties = [
      {
        'id': '1',
        'name': 'Kost Utama',
        'location': 'Jl. Sudirman No. 123, Jakarta',
        'totalUnits': 100,
        'occupiedUnits': 85,
        'revenue': 170000000,
        'status': 'Normal',
      },
      {
        'id': '2',
        'name': 'Rumah Kontrakan A',
        'location': 'Jl. Merdeka No. 45, Jakarta',
        'totalUnits': 1,
        'occupiedUnits': 1,
        'revenue': 15000000,
        'status': 'Normal',
      },
      {
        'id': '3',
        'name': 'Rumah Kontrakan B',
        'location': 'Jl. Gatot Subroto No. 78, Jakarta',
        'totalUnits': 1,
        'occupiedUnits': 0,
        'revenue': 0,
        'status': 'Unit Kosong',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          return PropertyCard(property: properties[index]);
        },
      ),
    );
  }
}
