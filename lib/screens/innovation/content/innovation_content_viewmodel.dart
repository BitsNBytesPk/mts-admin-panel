import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helpers/scroll_controller_funcs.dart';
import 'innovation_content_models.dart';

class InnovationContentViewModel extends GetxController {

  ScrollController scrollController = ScrollController();

  TextEditingController overviewLabelController = TextEditingController();
  TextEditingController overviewHeadingController = TextEditingController();
  TextEditingController overviewDescController = TextEditingController();

  RxList<StatItem> stats = <StatItem>[].obs;

  RxList<ProjectItem> projects = <ProjectItem>[].obs;
  
  // Informatics
  RxList<InformaticsItem> informaticsList = <InformaticsItem>[].obs;
  
  late ProjectItem currentProjectInput;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    
    initProjectInput();

    for(int i=0; i<3; i++) {
      addStat();
    }
  }

  @override
  void onReady() {
    animateSidePanelScrollController(scrollController);
    super.onReady();
  }

  void addStat() => stats.add(StatItem());
  void removeStat(StatItem item) {
    item.dispose();
    stats.remove(item);
  }

  void addInformatics() {
    if(informaticsList.length < 3) {
      informaticsList.add(InformaticsItem());
    }
  }

  void removeInformatics(InformaticsItem item) {
    item.dispose();
    informaticsList.remove(item);
  }

  void addProjectToStorage() {
    if(projects.length >= 6) {
      Get.snackbar("Limit Reached", "You can only add up to 6 projects.", backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    if(currentProjectInput.titleController.text.trim().isEmpty) {
       Get.snackbar("Error", "Project Title is required.", backgroundColor: Colors.redAccent, colorText: Colors.white);
       return;
    }

    projects.add(currentProjectInput);
    
    currentProjectInput = ProjectItem();
    currentProjectInput.addMetric();
    currentProjectInput.addStep(); 
    currentProjectInput.addApp();
    update();
  }

  Rx<ProjectItem> currentProjectInputRx = ProjectItem().obs;

  void initProjectInput() {
    var p = ProjectItem();
    p.addMetric();
    p.addStep();
    p.addApp();
    currentProjectInputRx.value = p;
  }

  void addProjectToStorageRx() {
    if(projects.length >= 6) {
      Get.snackbar("Limit Reached", "You can only add up to 6 projects.", backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    if(currentProjectInputRx.value.titleController.text.trim().isEmpty) {
       Get.snackbar("Error", "Project Title is required.", backgroundColor: Colors.redAccent, colorText: Colors.white);
       return;
    }

    projects.add(currentProjectInputRx.value);
    initProjectInput();
  }

  void removeProjectFromStorage(ProjectItem item) {
    item.dispose();
    projects.remove(item);
  }

  @override
  void onClose() {
    scrollController.dispose();
    overviewLabelController.dispose();
    overviewHeadingController.dispose();
    overviewDescController.dispose();
    searchController.dispose();

    for(var s in stats) {
      s.dispose();
    }
    for(var i in informaticsList) {
      i.dispose();
    }
    for(var p in projects) {
      p.dispose();
    }
    currentProjectInputRx.value.dispose();

    super.onClose();
  }
}
