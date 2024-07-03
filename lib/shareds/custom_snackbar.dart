import 'package:flutter/material.dart';
import 'package:tractian_challenge/utils/app_colors.dart';

enum SnackType { success, error, warning }

class CustomSnackbar {
  const CustomSnackbar();

  static show({
    required BuildContext context,
    required SnackType type,
    String? message,
    Function? callback,
    Widget? rightAction,
    VoidCallback? onActionPressed,
    VoidCallback? doAfterDismissed,
    Widget? richTextWidget,
    Widget? content,
    double? bottomMargin,
    double? width,
    Duration onScreenDuration = const Duration(seconds: 5),
  }) async {
    Widget icon;
    Color? backgroundIconColor;
    Color? borderColor;

    switch (type) {
      case SnackType.success:
        icon = const Icon(Icons.check, color: AppColors.white);
        backgroundIconColor = AppColors.primary;
        borderColor = AppColors.primary;
      case SnackType.error:
        icon = const Icon(Icons.close_rounded, color: AppColors.white);
        backgroundIconColor = AppColors.red;
        borderColor = AppColors.red;
      case SnackType.warning:
        icon = const Icon(Icons.warning_amber, color: AppColors.primary);
        backgroundIconColor = AppColors.yellow;
        borderColor = AppColors.yellow;
    }

    OverlayState? overlayState = Overlay.of(context);
    late OverlayEntry overlay;
    overlay = OverlayEntry(
      maintainState: true,
      builder: (context) {
        return Positioned(
          bottom: bottomMargin ?? MediaQuery.of(context).viewInsets.bottom,
          child: SafeArea(
            child: Material(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor!, width: 2),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.4),
                      offset: const Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: -9,
                    )
                  ],
                ),
                width: width ?? MediaQuery.of(context).size.width,
                height: 65,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: callback != null && richTextWidget == null
                      ? () {
                          overlay.remove();
                          callback();
                        }
                      : () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: double.infinity,
                        width: 60,
                        color: backgroundIconColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: icon,
                        ),
                      ),
                      Expanded(
                        child: richTextWidget ??
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: content ??
                                  (message == null
                                      ? const SizedBox.shrink()
                                      : Text(message)),
                            ),
                      ),
                      if (rightAction != null && onActionPressed != null)
                        InkWell(
                          onTap: () {
                            onActionPressed();
                            overlay.remove();
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: rightAction),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    overlayState.insert(overlay);
    await Future.delayed(onScreenDuration);
    try {
      overlay.remove();
      if (doAfterDismissed != null) doAfterDismissed();
    } catch (_) {}
  }
}
