import 'package:get/get.dart';
import 'package:mock_mart/common/widgets/custom_snack_bar.dart';
import 'package:mock_mart/features/auth/repo/auth_repo.dart';
import 'package:mock_mart/helpers/route_helper.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  Future<void> logOut() async {
    await authRepo.clearSharedData();
    Get.offAllNamed(RouteHelper.getSignInRoute());
    customSnackBar("logged_out_successfully".tr, type: ToasterMessageType.success);
  }

}