import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mock_mart/common/widgets/custom_snack_bar.dart';
import 'package:mock_mart/features/map/models/coordinate_model.dart';
import 'package:mock_mart/features/map/repo/coordinate_repo.dart';

class CoordinateController extends GetxController implements GetxService {
  final CoordinateRepo coordinateRepo;

  CoordinateController({required this.coordinateRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<CoordinateModel> _branchList = [];
  List<CoordinateModel> get branchList => _branchList;

  @override
  void onInit() {
    super.onInit();
    fetchBranches();
  }

  Future<void> fetchBranches() async {
    _isLoading = true;
    update();

    try {
      Response response = await coordinateRepo.getBranches();

      if (response.statusCode == 200 && response.body is List) {
        _branchList = [];
        for (var item in response.body) {
          _branchList.add(CoordinateModel.fromJson(item));
        }
      } else {
        String errorMessage = "failed_to_load_branches".tr;
        if (response.body != null && response.body is Map) {
          errorMessage =
              response.body['message'] ?? response.statusText ?? errorMessage;
        }
        customSnackBar(errorMessage);
      }
    } catch (e) {
      customSnackBar("an_error_occurred_while_fetching_branches".tr);
      if (kDebugMode) {
        print('Fetch branches error: $e');
      }
    }

    _isLoading = false;
    update();
  }
}
