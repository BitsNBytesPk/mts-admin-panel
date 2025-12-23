import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatItem {
  TextEditingController iconController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController labelController = TextEditingController();

  void dispose() {
    iconController.dispose();
    valueController.dispose();
    labelController.dispose();
  }
}

class InformaticsItem {
  TextEditingController labelController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  void dispose() {
    labelController.dispose();
    valueController.dispose();
  }
}

class MetricItem {
  TextEditingController labelController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  void dispose() {
    labelController.dispose();
    valueController.dispose();
  }
}

class TechStepItem {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  void dispose() {
    titleController.dispose();
    descController.dispose();
  }
}

class AppItem {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  void dispose() {
    titleController.dispose();
    descController.dispose();
  }
}

class ProjectItem {
  TextEditingController categoryController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  
  Rx<Uint8List> image = Uint8List(0).obs;
  
  RxList<MetricItem> metrics = <MetricItem>[].obs;
  RxList<TechStepItem> techSteps = <TechStepItem>[].obs;
  RxList<AppItem> applications = <AppItem>[].obs;

  void addMetric() => metrics.add(MetricItem());
  void removeMetric(MetricItem item) {
    item.dispose();
    metrics.remove(item);
  }

  void addStep() => techSteps.add(TechStepItem());
  void removeStep(TechStepItem item) {
    item.dispose();
    techSteps.remove(item);
  }

  void addApp() => applications.add(AppItem());
  void removeApp(AppItem item) {
    item.dispose();
    applications.remove(item);
  }

  void dispose() {
    categoryController.dispose();
    titleController.dispose();
    descController.dispose();
    for(var m in metrics) {
      m.dispose();
    }
    for(var s in techSteps) {
      s.dispose();
    }
    for(var a in applications) {
      a.dispose();
    }
  }
}
