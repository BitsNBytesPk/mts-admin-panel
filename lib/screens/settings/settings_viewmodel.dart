import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/helpers/stop_loader_and_show_snackbar.dart';
import 'package:mts_website_admin_panel/models/portfolio_general_data.dart';
import 'package:mts_website_admin_panel/utils/api_base_helper.dart';
import 'package:mts_website_admin_panel/utils/global_variables.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';
import 'package:web/web.dart';
import 'package:http/http.dart' as http;

class SettingsViewModel extends GetxController {

    ScrollController scrollController = ScrollController();

    TextEditingController nameController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    TextEditingController githubLinkController = TextEditingController();
    TextEditingController linkedinLinkController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController copyrightsTextController = TextEditingController();
    TextEditingController footerDescController = TextEditingController();
    TextEditingController aboutMeController = TextEditingController();
    TextEditingController aboutMeSecondaryDescController = TextEditingController();
    TextEditingController summaryTextController = TextEditingController();

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Rx<Uint8List> newPortfolioImage = Uint8List(0).obs;
    Rx<Uint8List> newCvFile = Uint8List(0).obs;
    RxString cvFileName = ''.obs;

    Rx<PortfolioGeneralData> portfolioGeneralData = PortfolioGeneralData().obs;

    RxString portfolioImageLink = ''.obs;
    Rx<Uint8List> uploadedCv = Uint8List(0).obs;

    @override
    void onReady() {
        _fetchPortfolioData();
        super.onReady();
    }

    void _fetchPortfolioData() {
        GlobalVariables.showLoader.value = true;
        ApiBaseHelper.getMethod(url: Urls.portfolioData).then((value) {
            GlobalVariables.showLoader.value = false;
           if(value.success!) {
               portfolioGeneralData.value = PortfolioGeneralData.fromJson(value.data);
               _initializeValues();
           } else {
               showSnackBar(message: 'Could not fetch data', success: false);
           }
        });
    }

    void _initializeValues() {
        nameController.text = portfolioGeneralData.value.portfolioName ?? '';
        titleController.text = portfolioGeneralData.value.title ?? '';
        githubLinkController.text = portfolioGeneralData.value.githubLink ?? '';
        linkedinLinkController.text = portfolioGeneralData.value.linkedinLink ?? '';
        emailController.text = portfolioGeneralData.value.email ?? '';
        copyrightsTextController.text = portfolioGeneralData.value.copyrightsText ?? '';
        footerDescController.text = portfolioGeneralData.value.footerText ?? '';
        aboutMeController.text = portfolioGeneralData.value.aboutMe ?? '';
        summaryTextController.text = portfolioGeneralData.value.summaryText ?? '';
        if(portfolioGeneralData.value.displayImage != null && portfolioGeneralData.value.displayImage != '') {
            portfolioImageLink.value = portfolioGeneralData.value.displayImage!;
        }
        if(portfolioGeneralData.value.cvLink != null && portfolioGeneralData.value.cvLink!.contains('https://firebasestorage.googleapis.com')) {
            final fileName = portfolioGeneralData.value.cvLink!.split('/o/')[1].split('?')[0];
            cvFileName.value = fileName.split('%20').join(' ');
        }
        aboutMeSecondaryDescController.text = portfolioGeneralData.value.aboutMeSecondaryDesc ?? '';

    }

    void pickCvFile() async {
        final file = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            compressionQuality: 60,
            allowedExtensions: ['pdf']
        );

        if(file != null) {
            newCvFile.value = file.files.first.bytes!;
            cvFileName.value = file.files.first.name;
        }
    }
    
    void updateDetails() {
        if(formKey.currentState!.validate()) {
            
            List<http.MultipartFile> files = [];
            
            if(newCvFile.value.isNotEmpty && newCvFile.value != Uint8List(0)) {
                files.add(http.MultipartFile.fromBytes('cv_file', newCvFile.value));
            }
            
            if(newPortfolioImage.value.isNotEmpty && newPortfolioImage.value != Uint8List(0)) {
                files.add(http.MultipartFile.fromBytes('display_image', newPortfolioImage.value, filename: 'Display Image'));
            }
            
            Map<String, String> body = {};
            
            body.addIf(nameController.text != portfolioGeneralData.value.portfolioName, 'name', nameController.text);
            body.addIf(titleController.text != portfolioGeneralData.value.title, 'title', titleController.text);
            body.addIf(aboutMeController.text != portfolioGeneralData.value.aboutMe, 'about_me', aboutMeController.text);
            body.addIf(aboutMeSecondaryDescController.text != portfolioGeneralData.value.aboutMeSecondaryDesc, 'about_me_secondary_desc', aboutMeSecondaryDescController.text);
            body.addIf(emailController.text != portfolioGeneralData.value.email, 'email', emailController.text);
            body.addIf(copyrightsTextController.text != portfolioGeneralData.value.copyrightsText, 'copyrights_text', copyrightsTextController.text);
            body.addIf(footerDescController.text != portfolioGeneralData.value.footerText, 'footer_text', footerDescController.text);
            body.addIf(githubLinkController.text != portfolioGeneralData.value.githubLink, 'github_link', githubLinkController.text);
            body.addIf(linkedinLinkController.text != portfolioGeneralData.value.linkedinLink, 'linkedin_link', linkedinLinkController.text);
            body.addIf(summaryTextController.text != portfolioGeneralData.value.summaryText, 'summary_text', summaryTextController.text);

            if(files.isEmpty && body.isEmpty) {
                showSnackBar(message: 'No Data Updated', success: false);
            } else {
                GlobalVariables.showLoader.value = true;
                ApiBaseHelper.patchMethodForImage(
                    url: Urls.updatePortfolioData(portfolioGeneralData.value.id!),
                    files: files,
                    fields: body,
                ).then((value) {
                    stopLoaderAndShowSnackBar(success: value.success!, message: value.message!);
                    
                    if(value.success!) {
                      portfolioGeneralData.value = PortfolioGeneralData.fromJson(value.data);
                    }
                });
            }
        }
    }

    void downloadCv() {

        GlobalVariables.showLoader.value = true;
        ApiBaseHelper.getMethod(url: "${Urls.downloadCv}?download_url=${portfolioGeneralData.value.cvLink}").then((value) {
            GlobalVariables.showLoader.value = false;
            if(value.success!) {

                final data = Uint8List.fromList(List<int>.from(value.data['data']));
                HTMLAnchorElement()
                    ..href = 'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(data)}'
                    ..setAttribute('download', 'Syed Wajeeh Ahsan - Flutter.pdf')..click();
            } else {
                showSnackBar(message: value.message!, success: false);
            }
        });
    }
}