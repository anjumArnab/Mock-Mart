import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mock_mart/api/remote/api_client.dart';
import 'package:mock_mart/common/widgets/custom_snack_bar.dart';
import 'package:mock_mart/features/auth/repo/auth_repo.dart';
import 'package:mock_mart/features/profile/model/profile_model.dart';
import 'package:mock_mart/features/profile/repo/user_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mock_mart/helpers/route_helper.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  final AuthRepo authRepo;

  UserController({required this.userRepo, required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProfileModel? _profileModel;
  ProfileModel? get profileModel => _profileModel;

  XFile? _pickedFile;
  XFile? get pickedFile => _pickedFile;

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  Future<void> getUserData() async {
    _isLoading = true;
    update();

    try {
      Response response = await userRepo.getUserProfile();

      if (response.statusCode == 200) {
        _profileModel = ProfileModel.fromJson(response.body);
        customSnackBar("user_found".tr, type: ToasterMessageType.success);
      } else {
        String errorMessage = "user_not_found".tr;
        if (response.body != null && response.body is Map) {
          errorMessage =
              response.body['message'] ?? response.statusText ?? errorMessage;
        }
        customSnackBar(errorMessage);
      }
    } catch (e) {
      customSnackBar("an_error_occurred_during_fetching_user_data".tr);
      if (kDebugMode) {
        print('Fetch user error: $e');
      }
    }
    _isLoading = false;
    update();
  }

  void pickImage() async {
    try {
      _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_pickedFile != null) {
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Image picker error: $e');
      }
      customSnackBar("failed_to_pick_image".tr);
    }
  }

  void removeImage() {
    _pickedFile = null;
    update();
  }

  Future<void> updateProfile({
  String? fName,
  String? lName,
  String? email,
  String? phone,
}) async {
  _isUpdating = true;
  update();

  try {
    Map<String, String> body = {
      'f_name': fName ?? _profileModel?.fName ?? '',
      'l_name': lName ?? _profileModel?.lName ?? '',
      'email': email ?? _profileModel?.email ?? '',
      'phone': phone ?? _profileModel?.phone ?? '',
    };

    List<MultipartBody>? multipartBody;
    if (_pickedFile != null) {
      multipartBody = [MultipartBody('image', _pickedFile!)];
    }

    Response response = await userRepo.updateUserProfile(body, multipartBody);

    if (response.statusCode == 200) {
      _pickedFile = null;
      
      await getUserData();
      
      customSnackBar("profile_updated_successfully".tr, type: ToasterMessageType.success);
      Get.back();
    } else {
      String errorMessage = "failed_to_update_profile".tr;
      if (response.body != null && response.body is Map) {
        errorMessage =
            response.body['message'] ?? response.statusText ?? errorMessage;
      }
      customSnackBar(errorMessage);
    }
  } catch (e) {
    customSnackBar("an_error_occurred_during_updating_profile".tr);
    if (kDebugMode) {
      print('Update profile error: $e');
    }
  }
  _isUpdating = false;
  update();
}

  Future<void> logOut() async {
    await authRepo.clearSharedData();
    Get.offAllNamed(RouteHelper.getSignInRoute());
    customSnackBar("logged_out_successfully".tr, type: ToasterMessageType.success);
  }
}