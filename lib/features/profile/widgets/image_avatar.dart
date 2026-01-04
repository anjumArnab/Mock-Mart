import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mock_mart/theme/app_theme.dart';

class ImageAvatar extends StatelessWidget {
  final File? localImage;
  final String? networkImage;
  final VoidCallback? onTap;

  const ImageAvatar({
    super.key,
    this.localImage,
    this.networkImage,
    this.onTap,
  });

  bool get _hasImage =>
      localImage != null || (networkImage != null && networkImage!.isNotEmpty);

  ImageProvider? get _imageProvider {
    if (localImage != null) {
      return FileImage(localImage!);
    }
    if (networkImage != null && networkImage!.isNotEmpty) {
      return NetworkImage(networkImage!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
            backgroundImage: _imageProvider,
            child: !_hasImage
                ? Icon(Icons.person, size: 50, color: AppTheme.primaryColor)
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
