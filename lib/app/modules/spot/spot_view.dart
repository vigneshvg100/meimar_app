import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'spot_controller.dart';

class SpotView extends GetView<SpotController> {
  const SpotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Colors.black54, size: 20),
          ),
          onPressed: () => Get.back(),
        ),
        title: Obx(
          () => Text(
            controller.spotData['spot_name'] ?? "Spot Details",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final spot = controller.spotData;
        if (spot.isEmpty) {
          return const Center(child: Text("No data available"));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        "https://picsum.photos/seed/${spot['spot_id'] ?? 'default'}/600/400",
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 250,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.image_outlined,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: Text(
                        spot['spot_name'] ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 15,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Color(0xFF0F4B38),
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Category Chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 8,
                  children: [_buildChip("Nature"), _buildChip("Photography")],
                ),
              ),

              const SizedBox(height: 24),

              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTabItem(0, "Overview"),
                        _buildTabItem(1, "Details"),
                        _buildTabItem(2, "Tips"),
                        _buildTabItem(3, "Notes"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      switch (controller.selectedTabIndex.value) {
                        case 0:
                          return _buildOverviewTab(spot);
                        case 1:
                          return _buildDetailsTab(spot);
                        case 2:
                          return _buildTipsTab(spot);
                        case 3:
                          return _buildNotesTab();
                        default:
                          return _buildOverviewTab(spot);
                      }
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTabItem(int index, String label) {
    return Obx(() {
      final isSelected = controller.selectedTabIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF0F4B38) : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 3,
              width: 60,
              color: isSelected ? const Color(0xFF0F4B38) : Colors.transparent,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildOverviewTab(Map<String, dynamic> spot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Abbe Falls (also called Abbi Falls) is a beautiful waterfall near Madikeri in Coorg, Karnataka. The waterfall is especially stunning during the monsoon, and a short walk through a hanging bridge leads visitors to a great viewpoint.",
          style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.5),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildInfoCard(Icons.access_time, "Opening Hours", "9AM-5 PM"),
            const SizedBox(width: 12),
            _buildInfoCard(
              Icons.hourglass_empty,
              "Duration",
              "${spot['estimated_duration'] ?? '2-3 hours'}",
            ),
            const SizedBox(width: 12),
            _buildInfoCard(
              Icons.confirmation_num_outlined,
              "Entry Fee",
              "₹200",
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Why you should go",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildStep(
                1,
                "The waterfall is best viewed from a hanging bridge that gives a thrilling, cinematic perspective you won't usually find at other waterfalls.",
              ),
              const SizedBox(height: 20),
              _buildStep(
                2,
                "The walk to the falls takes you through private coffee estates, giving you a rare, immersive Coorg plantation experience along the way.",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsTab(Map<String, dynamic> spot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "About this place",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          "The surrounding area is covered with lush coffee plantations and spice estates, making it a complete sensory experience. The sound of cascading water combined with the fresh mountain air creates an unforgettable atmosphere. The falls drop from a height of 70 feet and are surrounded by dense forests that add to the scenic beauty.\n\nThe path to the waterfall takes you through private coffee estates, offering visitors a unique glimpse into Coorg's famous coffee culture. Local guides are available who can explain the coffee-making process and the history of the region.",
          style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.6),
        ),
        const SizedBox(height: 24),
        const Text(
          "Best time to visit",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          "The waterfall is most spectacular during the monsoon (July to October) when the flow is at its peak. However, the winter months (November to February) are also pleasant for trekking and photography.",
          style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.6),
        ),
      ],
    );
  }

  Widget _buildTipsTab(Map<String, dynamic> spot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Things to note",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        _buildTipItem(
          Icons.info_outline,
          "Carry anti-slip footwear",
          "The rocks and steps get extremely slippery near the falls",
        ),
        const SizedBox(height: 20),
        _buildTipItem(
          Icons.info_outline,
          "Be ready for a mini workout",
          "small backpacks and light luggage will make the experience smoother.",
        ),
        const SizedBox(height: 32),
        const Text(
          "Nearby Attractions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildBulletPoint("Anti-Slip shoes or trekking sandals."),
        _buildBulletPoint("Light backpack with water and snacks."),
        _buildBulletPoint("Waterproof bag for phone and camera."),
      ],
    );
  }

  Widget _buildTipItem(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF0F4B38), size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "$title: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("•", style: TextStyle(color: Colors.grey[600], fontSize: 18)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your Notes",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.edit_note, color: Color(0xFF0F4B38)),
                  const SizedBox(width: 8),
                  Text(
                    "Add Notes",
                    style: TextStyle(
                      color: const Color(0xFF0F4B38).withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  controller: controller.noteController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    hintText: "Add a note about this activity ...",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.addNote(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F4B38),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Add Notes",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Obx(
          () => Column(
            children: controller.notes.asMap().entries.map((entry) {
              final index = entry.key;
              final note = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note['text'] ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          note['time'] ?? "",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                        TextButton(
                          onPressed: () => controller.deleteNote(index),
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF2E7D32),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.grey, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$number",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
