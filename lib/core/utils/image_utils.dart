import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dialog_utils.dart';
import 'logger.dart';

Future<List<XFile>> pickImages(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  List<XFile> imageFiles = [];

  try {
    PermissionStatus status = await Permission.photos.status;
    Logger.info('Current Photo Permission Status: $status');

    status = await Permission.photos.request();

    if (status.isGranted) {
      final List<XFile>? pickedFiles = await picker.pickMultiImage();

      if (pickedFiles != null) {
        imageFiles.addAll(pickedFiles);
      }
    } else if (status.isLimited) {
      showCustomDialog(
        context: context,
        title: '접근 권한이 필요합니다.',
        content: '사진 접근 권한을 허용하시겠습니까?',
        onSettingsPressed: () async {
          await openAppSettings();
        },
        settingsButtonText: '설정으로 이동',
      );
    } else if (status.isPermanentlyDenied) {
      showCustomDialog(
        context: context,
        title: '접근 권한이 필요합니다.',
        content: '사진 접근 권한을 허용하시겠습니까?',
        onSettingsPressed: () async {
          await openAppSettings();
        },
        settingsButtonText: '설정으로 이동',
      );
    }
  } catch (e) {
    Logger.error('An error occurred while picking images: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('이미지 선택 중 오류가 발생했습니다. 다시 시도해주세요.')),
    );
  }

  return imageFiles;
}
