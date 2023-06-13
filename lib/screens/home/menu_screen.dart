import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questable_quiz_flutter/configs/themes/app_colors.dart';
import 'package:questable_quiz_flutter/configs/themes/ui_parameters.dart';
import 'package:questable_quiz_flutter/controllers/zoom_drawer_controller.dart';

class MyMenuScreen extends GetView<MyZoomDrawerController> {
  const MyMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: UIParameters.mobileScreenPadding,
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: mainGradient(),
        ),
        child: Theme(
          data: ThemeData(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: onSurfaceTextColor,
              ),
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // Positioned(
                //   top: 0,
                //   right: 0,
                //   child: BackButton(
                //     color: Colors.black,
                //     onPressed: () {
                //       controller.toggleDrawer();
                //     },
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.1),
                  child: Column(
                    children: [
                      Obx(
                        () => controller.user.value == null
                            ? const SizedBox()
                            : Text(
                                controller.user.value!.displayName ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      _DrawerButton(
                        icon: Icons.web,
                        label: "website",
                        onPressed: () => controller.website(),
                      ),
                      _DrawerButton(
                        icon: Icons.facebook,
                        label: "facebook",
                        onPressed: () => controller.facebook(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                        ),
                        child: _DrawerButton(
                          icon: Icons.email,
                          label: "email",
                          onPressed: () => controller.email(),
                        ),
                      ),
                      const Spacer(
                        flex: 4,
                      ),
                      _DrawerButton(
                        icon: Icons.logout,
                        label: "logout",
                        onPressed: () => controller.signOut(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
  });
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 15,
        color: Colors.black,
      ),
      label: Text(
        label,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
