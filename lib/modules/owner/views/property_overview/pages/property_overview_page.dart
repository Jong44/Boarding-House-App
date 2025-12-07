import 'package:boarding_house_app/modules/owner/features/provider/property_provider.dart';
import 'package:boarding_house_app/modules/owner/views/property_overview/components/property_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PropertyOverviewPage extends ConsumerWidget {
  const PropertyOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertyState = ref.watch(propertyProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: propertyState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : propertyState.error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${propertyState.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(propertyProvider.notifier).refresh(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : propertyState.properties.isEmpty
          ? const Center(child: Text('Belum ada property'))
          : RefreshIndicator(
              onRefresh: () async {
                ref.read(propertyProvider.notifier).refresh();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: propertyState.properties.length,
                itemBuilder: (context, index) {
                  return PropertyCard(
                    property: propertyState.properties[index],
                  );
                },
              ),
            ),
    );
  }
}
