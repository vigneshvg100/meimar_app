import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FooterMenu extends GetView {
  final int? currentIndex;
  final Function(int) onTap;

  const FooterMenu({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/home_current.svg'),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/my_trip_icon.svg'),
          label: 'My Trip',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/add_blue_icon.svg'),
          label: ' ',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/guide_icon.svg'),
          label: 'Guide',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/profile.svg'),
          label: 'Profile',
        ),
      ],
    );
  }
}

//      BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: onTap,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Colors.blue,
//       unselectedItemColor: Colors.grey,
//       showUnselectedLabels: true,
//       items: [
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset('assets/icons/home_current.svg'),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset('assets/icons/my_trip_icon.svg'),
//           label: 'My Trip',
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset('assets/icons/add_blue_icon.svg'),
//           label: ' ',
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset('assets/icons/guide_icon.svg'),
//           label: 'Guide',
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset('assets/icons/profile.svg'),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }
