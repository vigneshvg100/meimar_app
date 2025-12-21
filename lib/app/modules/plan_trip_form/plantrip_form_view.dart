import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meimar_app/app/modules/plan_trip_form/plantrip_form_controller.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Make sure flutter_svg is in pubspec

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFF3F3F3)),
                      child: const Icon(Icons.close, color: Colors.grey),
                    ),
                  ),
                  const Spacer(),
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
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(width: 40), // Balance the close button
                ],
              ),
              const SizedBox(height: 40),

              // Search City
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: controller.cityController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    hintText: 'Search for city',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
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
              GestureDetector(
                onTap: () {
                    // TODO: Open Date Picker
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: AbsorbPointer(
                    child: TextField(
                      controller: controller.dateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Icons.calendar_today_outlined, color: Colors.grey),
                        hintText: 'Start & End Date',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
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
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.companions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1, 
                ),
                itemBuilder: (context, index) {
                  final item = controller.companions[index];
                  return Obx(() {
                    final isSelected =
                        controller.selectedCompanion.value == index;
                    return GestureDetector(
                      onTap: () => controller.selectCompanion(index),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFF3F0FF)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF6200EE) // Primary Purple
                                : Colors.grey.shade200,
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: (item['id'] == 'solo' && isSelected) ? const Color.fromARGB(255, 179, 158, 241) : const Color(0xFFF5F5F5), // Light grey bg for icon
                                    shape: BoxShape.circle,
                                ),
                                child: Icon(item['icon'] as IconData,
                                    size: 20, color: isSelected ? const Color(0xFF6200EE) : Colors.purple)
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item['title'] as String,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? const Color(0xFF6200EE)
                                    : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['desc'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected
                                    ? const Color(0xFF6200EE)
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: controller.distanceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.generateItinerary,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF131596), // Deep Blue
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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
}
