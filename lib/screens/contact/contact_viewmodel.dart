import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/populate_lists.dart';
import '../../../helpers/scroll_controller_funcs.dart';
import '../../../helpers/stop_loader_and_show_snackbar.dart';
import '../../../models/package.dart';
import '../../../utils/api_base_helper.dart';
import '../../../utils/global_variables.dart';
import '../../../utils/url_paths.dart';

class ContactViewModel extends GetxController with GetSingleTickerProviderStateMixin{

  /// Controller(s) & Form keys
  ScrollController scrollController = ScrollController();
  TextEditingController allOrderSearchController = TextEditingController();
  TextEditingController packageNameController = TextEditingController();
  TextEditingController packageMainDescController = TextEditingController();
  TextEditingController packageSecDescController = TextEditingController();
  TextEditingController packageDownloadsController = TextEditingController();
  TextEditingController packagePubPointsController = TextEditingController();
  TextEditingController packageGithubController = TextEditingController();
  TextEditingController packagePackageManagerController = TextEditingController();
  TextEditingController packageLikesController = TextEditingController();
  TextEditingController packageVersionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  /// Controller(s) and Form keys End ///

  /// Packages Lists
  List<Package> allPackagesList = <Package>[];
  RxList<Package> visiblePackagesList = <Package>[].obs;

  /// Pagination Variables
  RxInt allPackagesPage = 0.obs;
  int allPackagesLimit = 10;
    
  Rx<Uint8List> packageImageOrGif = Uint8List(0).obs;

  RxList<String> keyFeaturesList = <String>[].obs;
  RxList<String> techStackList = <String>[].obs;

  @override
  void onReady() {
    animateSidePanelScrollController(scrollController);
    fetchAllPackages();
    super.onReady();
  }

  @override
  void onClose() {
    allOrderSearchController.dispose();
    packageNameController.dispose();
    packageMainDescController.dispose();
    packageSecDescController.dispose();
    packageDownloadsController.dispose();
    packagePubPointsController.dispose();
    packageGithubController.dispose();
    packagePackageManagerController.dispose();
    packageLikesController.dispose();
    packageVersionController.dispose();
    keyFeaturesList.clear();
    techStackList.clear();
    scrollController.dispose();
    super.onClose();
  }

  /// API call to get all package
  void fetchAllPackages() async {
    if(GlobalVariables.showLoader.isFalse) GlobalVariables.showLoader.value = true;

    ApiBaseHelper.getMethod(url: Urls.getPackages).then((value) {
      GlobalVariables.showLoader.value = false;
      if(value.success!) {
        populateLists(allPackagesList, value.data, visiblePackagesList, (dynamic json) => Package.fromJson(json));
      } else {
        showSnackBar(message: value.message!, success: false);
      }
    });
  }

  /// API call to add package
  void addPackage() {
    if(formKey.currentState!.validate()) {
      if(packageImageOrGif.value != Uint8List(0) && packageImageOrGif.value.isNotEmpty) {
        GlobalVariables.showLoader.value = true;
        FocusScope.of(Get.context!).unfocus();

        ApiBaseHelper.postMethod(
            url: Urls.addPackage,
            body: {
              'name': packageNameController.text.trim(),
              'main_desc': packageMainDescController.text.trim(),
              'secondary_desc': packageSecDescController.text.trim(),
              'downloads': int.tryParse(packageDownloadsController.text.trim()),
              'pub_points': int.tryParse(packagePubPointsController.text.trim()),
              'likes': int.tryParse(packageLikesController.text.trim()),
              'version': packageVersionController.text.trim(),
              'github_link': packageGithubController.text.trim(),
              'package_manager_link': packagePackageManagerController.text.trim(),
              'key_features': keyFeaturesList,
              'tech_stack': techStackList,
              // 'image':
            }
        ).then((value) {
          stopLoaderAndShowSnackBar(success: value.success!, message: value.message!);

          if(value.success!) {
            allPackagesList.add(Package.fromJson(value.data));
            addDataToVisibleList(allPackagesList, visiblePackagesList);
          }
        });
      } else {
        showSnackBar(message: 'Please select an image or GIF', success: false);
      }
    }
  }

  /// API call to change the status of package
  void changePackageStatus(int index) {
    GlobalVariables.showLoader.value = true;

    ApiBaseHelper.patchMethod(
      url: Urls.editPackage(visiblePackagesList[index].id!),
      body: {
        'status': !visiblePackagesList[index].status!,
      }
    ).then((value) {
      stopLoaderAndShowSnackBar(message: value.message!, success: value.success!);

      if(value.success!) {
        final allPackagesListIndex = allPackagesList.indexWhere((element) => element.id == visiblePackagesList[index].id);
        if(allPackagesListIndex >= 0) {
          allPackagesList[allPackagesListIndex].status = !allPackagesList[allPackagesListIndex].status!;
        }
        addDataToVisibleList(allPackagesList, visiblePackagesList);
      }
    });
  }

  /// API call to delete package
  void deletePackage(int index) {
    GlobalVariables.showLoader.value = true;

    ApiBaseHelper.deleteMethod(
        url: Urls.deletePackage(visiblePackagesList[index].id!)
    ).then((value) {
      stopLoaderAndShowSnackBar(message: value.message!, success: value.success!);

      if(value.success!) {
        allPackagesList.removeAt(index);
        addDataToVisibleList(allPackagesList, visiblePackagesList);
      }
    });
  }

  void searchList(String? value, List<Package> allList, RxList<Package> visibleList) {
    if(value == null || value.isEmpty || value == '') {
      addDataToVisibleList(allList, visibleList);
    } else {
      addDataToVisibleList(
          allList.where((element) => element.name!.toLowerCase().contains(value.toLowerCase().trim())
              || element.mainDesc!.toLowerCase().trim().contains(value.toLowerCase().trim())
          ).toList(), visibleList
      );
    }
  }
}