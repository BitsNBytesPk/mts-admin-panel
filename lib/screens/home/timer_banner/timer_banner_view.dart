import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mts_website_admin_panel/screens/home/timer_banner/timer_banner_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_material_button.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/section_container.dart';
import 'package:mts_website_admin_panel/utils/validators.dart';

import '../../../utils/custom_widgets/custom_text_form_field.dart';

class HomeTimerBannerView extends StatelessWidget {
  HomeTimerBannerView({super.key});

  final HomeTimerBannerViewModel _viewModel = Get.put(HomeTimerBannerViewModel());
  
  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        selectedSidePanelItem: 2,
        scrollController: _viewModel.scrollController,
        children: [
          SectionContainer(
              children: [
                CustomTextFormField(
                  title: 'Title',
                  includeAsterisk: true,
                  showCounter: true,
                  maxLength: 30,
                  validator: (value) => Validators.validateEmptyField(value),
                ),
                CustomTextFormField(
                  title: 'Description',
                  includeAsterisk: true,
                  maxLength: 80,
                  maxLines: 3,
                  showCounter: true,
                  validator: (value) => Validators.validateLongDescriptionText(value, maxLength: 80),
                ),
                Row(
                  spacing: 15,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: _viewModel.startDateController,
                        readOnly: true,
                        onTap: () async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: _viewModel.endDate == null ? DateTime.now() : _viewModel.endDate!.subtract(Duration(days: 1)),
                              lastDate: _viewModel.endDate == null ? DateTime.now().add(Duration(days: 60)) : _viewModel.endDate!.add(Duration(days: 60))
                          );

                          if(date != null) {
                            _viewModel.startDate = date;
                            _viewModel.startDateController.text = DateFormat('dd/MM/yyyy').format(date);
                          }
                        },
                        hint: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                        title: 'Start Date',
                        prefixIcon: Icon(
                          Icons.calendar_month_rounded,
                          color: primaryGrey,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _viewModel.startDateController.clear();
                            _viewModel.startDate = null;
                          },
                          icon: Icon(Icons.highlight_remove_rounded, color: errorRed,),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CustomTextFormField(
                        controller: _viewModel.endDateController,
                        prefixIcon: Icon(
                          Icons.calendar_month_rounded,
                          color: primaryGrey,
                        ),
                        readOnly: true,
                        onTap: () async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: _viewModel.startDate == null ? DateTime.now().add(Duration(days: 1)) : _viewModel.startDate!.add(Duration(days: 1)),
                              lastDate: _viewModel.startDate == null ? DateTime.now().add(Duration(days: 60)) : _viewModel.startDate!.add(Duration(days: 60))
                          );

                          if(date != null) {
                            _viewModel.endDate = date;
                            _viewModel.endDateController.text = DateFormat('dd/MM/yyyy').format(date);
                          }
                        },
                        hint: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                        title: 'End Date',
                        includeAsterisk: true,
                        validator: (value) => Validators.validateDate(value),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _viewModel.endDateController.clear();
                            _viewModel.endDate = null;
                          },
                          icon: Icon(Icons.highlight_remove_rounded, color: errorRed,),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                    child: Text(
                      'Informatics',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                ),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: _viewModel.firstInformaticsHeadingController,
                        title: 'Heading',
                        showCounter: true,
                        maxLength: 15,
                        onChanged: (value) {
                          if(value == '' || value.isEmpty) {
                            _viewModel.enableFirstInformaticsValueField.value = false;
                            _viewModel.firstInformaticsValueController.clear();
                          } else {
                            _viewModel.enableFirstInformaticsValueField.value = true;
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: Obx(() => CustomTextFormField(
                        enabled: _viewModel.enableFirstInformaticsValueField.value,
                          title: 'Value',
                          controller: _viewModel.firstInformaticsValueController,
                          showCounter: true,
                          maxLength: 10,
                        validator: (value) {
                          if(_viewModel.firstInformaticsHeadingController.text.trim() == '' || _viewModel.firstInformaticsHeadingController.text.trim().isEmpty) {
                            return null;
                          } else {
                            return Validators.validateEmptyField(value);
                          }
                        },
                        ),
                      ),
                    ),
                    Obx(() => _viewModel.secondInformaticsAdded.value ? IconButton(
                        onPressed: () {
                          _viewModel.secondInformaticsAdded.value = false;
                          _viewModel.firstInformaticsValueController.text = _viewModel.secondInformaticsValueController.text;
                          _viewModel.firstInformaticsHeadingController.text = _viewModel.secondInformaticsHeadingController.text;
                          _viewModel.secondInformaticsValueController.clear();
                          _viewModel.secondInformaticsHeadingController.clear();
                        },
                        icon: Icon(
                          Icons.remove_circle_outline_outlined,
                          size: 18,
                          color: primaryGrey,
                        )
                    ) : SizedBox())
                  ],
                ),
                Obx(() => !_viewModel.secondInformaticsAdded.value ? IconButton(
                    onPressed: () => _viewModel.secondInformaticsAdded.value = true,
                    icon: Icon(
                      Icons.add_circle_outline_rounded,
                      color: primaryGrey,
                      size: 30,
                    )
                ) : SizedBox()),
                Obx(() => _viewModel.secondInformaticsAdded.value ? Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: _viewModel.secondInformaticsHeadingController,
                        title: 'Heading',
                        showCounter: true,
                        maxLength: 15,
                        onChanged: (value) {
                          if(value == '' || value.isEmpty) {
                            _viewModel.enableSecondInformaticsValueField.value = false;
                            _viewModel.secondInformaticsValueController.clear();
                          } else {
                            _viewModel.enableSecondInformaticsValueField.value = true;
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: Obx(() => CustomTextFormField(
                        enabled: _viewModel.enableFirstInformaticsValueField.value,
                        title: 'Value',
                        controller: _viewModel.secondInformaticsValueController,
                        showCounter: true,
                        maxLength: 10,

                      ),
                      ),
                    ),
                    Obx(() => _viewModel.secondInformaticsAdded.value ? IconButton(
                        onPressed: () {
                          _viewModel.secondInformaticsAdded.value = false;
                          _viewModel.secondInformaticsValueController.clear();
                          _viewModel.secondInformaticsHeadingController.clear();
                          _viewModel.enableSecondInformaticsValueField.value = false;
                        },
                        icon: Icon(
                          Icons.remove_circle_outline_outlined,
                          size: 18,
                          color: primaryGrey,
                        )
                    ) : SizedBox())
                  ],
                ) : SizedBox())
              ]
          ),
          Row(
            spacing: 15,
            mainAxisAlignment: isSmallScreen(context) ? MainAxisAlignment.center : MainAxisAlignment.end,
            children: [
              CustomMaterialButton(
                onPressed: () {},
                width: isSmallScreen(context) ? 150 : 200,
                text: 'Remove Banner',
                buttonColor: errorRed,
                borderColor: errorRed,
              ),
              CustomMaterialButton(
                onPressed: () {},
                width: isSmallScreen(context) ? 150 : 200,
                text: 'Update Banner',
              ),
            ],
          )
        ]
    );
  }
}