import 'package:boarding_house_app/modules/owner/features/service/property_service.dart';
import 'package:boarding_house_app/modules/owner/features/state/property_state.dart';
import 'package:state_notifier/state_notifier.dart';

class PropertyNotifier extends StateNotifier<PropertyState> {
  final PropertyService propertyService;

  PropertyNotifier({required this.propertyService})
    : super(const PropertyState());

  Future<void> loadProperties() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final properties = await propertyService.getProperties();
      state = state.copyWith(isLoading: false, properties: properties);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void refresh() {
    loadProperties();
  }
}
