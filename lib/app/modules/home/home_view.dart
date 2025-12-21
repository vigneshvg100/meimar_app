import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:meimar_app/app/modules/plan_trip_form/plantrip_form_binding.dart';
import 'package:meimar_app/app/modules/plan_trip_form/plantrip_form_view.dart';
import '../../shared_modules/footer_menu/footer_menu_view.dart';
import 'package:get/get.dart';

class HomeView extends GetView {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Home')),
      body: Stack(
        children: [
          // 🔹 Background image
          Positioned.fill(
            child: Image.asset('pictures/sky.jpg', fit: BoxFit.cover),
          ),

          // 🔹 Box on top
          Center(
            child: Container(
              width: 300,
              height: 150,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'Where do you want to go next?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Text(
                    'Create your first trip and start planning',
                    style: TextStyle(fontSize: 11),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => Get.to(
                      () => const PlanTripForm(),
                      binding: PlanTripFormBinding(),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 17, 19, 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Create New Trip',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            // fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FooterMenu(
        currentIndex: _currentIndex,
        onTap: (index) => _currentIndex = index,
      ),
    );
  }
}
