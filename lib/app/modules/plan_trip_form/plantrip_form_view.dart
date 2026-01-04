import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meimar_app/app/modules/plan_trip_form/plantrip_form_controller.dart';
import 'widgets/embedded_date_picker.dart';

class PlanTripForm extends GetView<PlantripFormController> {
  const PlanTripForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF3F3F3),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        'Plan a new Trip',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tell us your travel style to begin',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Search City
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: controller.currentField.value == "place"
                        ? Border.all(color: const Color(0xFF0F4B38), width: 1.5)
                        : Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    onTap: () {
                      controller.selectPlace();
                    },
                    controller: controller.cityController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      hintText: 'Search for city',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // When are you travelling
              const Text(
                'When are you travelling ?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: controller.currentField.value == "date"
                        ? Border.all(color: const Color(0xFF0F4B38), width: 1.5)
                        : Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    controller: controller.dateController,
                    readOnly: true, // prevents keyboard from showing
                    onTap: controller.toggleDatePicker,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                      ),
                      hintText: 'Start & End Date',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => Visibility(
                  visible: controller.isDatePickerOpen.value,
                  child: EmbeddedDatePicker(
                    startDate: controller.startDate.value,
                    endDate: controller.endDate.value,
                    onDateSelected: controller.updateDateRange,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Who's coming along
              const Text(
                'Who’s coming along ?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(controller.companions.length, (
                    index,
                  ) {
                    final item = controller.companions[index];
                    return Obx(() {
                      final isSelected =
                          controller.selectedCompanion.value == index;
                      return GestureDetector(
                        onTap: () => controller.selectCompanion(index),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFE8F5E9)
                                : Colors
                                      .transparent, // Light Green or Transparent
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                item['icon'] as IconData,
                                size: 18,
                                color: Colors.black87,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item['title'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              if (isSelected) ...[
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.cancel,
                                  size: 16,
                                  color: Colors.black87,
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    });
                  }),
                ),
              ),

              const SizedBox(height: 24),
              // Distance to be covered
              const Text(
                'Distance to be covered',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(controller.radiusMap.length, (index) {
                    final item = controller.radiusMap[index];
                    return Obx(() {
                      final isDistanceSelected =
                          controller.selectedDistanceOption.value == index;
                      return GestureDetector(
                        onTap: () => controller.selectRadiusOption(index),
                        child: _buildDistanceCard(
                          index,
                          item['title'] as String,
                          item['description'] as String,
                        ),
                      );
                    });
                  }),
                ),
              ),
              const SizedBox(height: 40),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.generateItinerary,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F4B38), // Dark Green
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Generate Itinerary',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDistanceCard(int index, String title, String subtitle) {
    return Obx(() {
      final isSelected = controller.selectedDistanceOption.value == index;
      return GestureDetector(
        onTap: () => controller.selectRadiusOption(index),
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF0F4B38)
                  : Colors.grey.shade300,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
