import 'package:get/get.dart';
import 'package:mts_website_admin_panel/helpers/populate_lists.dart';

void searchList(String? value, List<dynamic> list, RxList<dynamic> visibleList, dynamic searchFilterType) {
  if(value == null || value.isEmpty || value == '') {
    addDataToVisibleList(list, visibleList);
  } else {
    addDataToVisibleList(
        list.where((element) => element.searchFilterType.toLowerCase().contains(value.toLowerCase())).toList(),
        visibleList
    );
  }
}