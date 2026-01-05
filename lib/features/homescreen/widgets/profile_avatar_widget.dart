import 'dart:io';
import 'package:flutter/material.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final File? localImage;
  final String? networkImage;
  final VoidCallback? onTap;

  const ProfileAvatarWidget({
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
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        backgroundImage: _imageProvider,
        child: !_hasImage
            ? Icon(
                Icons.person,
                size: 25,
                color: Theme.of(context).colorScheme.primary,
              )
            : null,
      ),
    );
  }
}
