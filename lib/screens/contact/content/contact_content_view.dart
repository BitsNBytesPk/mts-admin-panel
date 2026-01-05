import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mts_website_admin_panel/screens/contact/content/contact_content_viewmodel.dart';
import 'package:mts_website_admin_panel/utils/constants.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/custom_material_button.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/screens_base_widget.dart';
import 'package:mts_website_admin_panel/utils/custom_widgets/section_container.dart';
import 'package:mts_website_admin_panel/utils/validators.dart';

import '../../../utils/custom_widgets/custom_text_form_field.dart';

class ContactContentView extends StatelessWidget {
  ContactContentView({super.key});

  final ContactContentViewModel _viewModel = Get.put(ContactContentViewModel());

  @override
  Widget build(BuildContext context) {
    return ScreensBaseWidget(
        selectedSidePanelItem: 12,
        scrollController: _viewModel.scrollController,
        children: [
          SectionContainer(
            headingText: 'Emails',
              height: _viewModel.emailsFormHeight,
              formKey: _viewModel.emailsFormKey,
              children: [
                Obx(() => Column(
                    spacing: 10,
                    children: List.generate(_viewModel.emails.length, (index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: _viewModel.emails[index],
                              maxLength: 20,
                              showCounter: true,
                              validator: (value) => Validators.validateEmptyField(value),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: InkWell(
                              onTap: () {
                                if(_viewModel.emails.length > 1) {
                                  _viewModel.emails.removeAt(index);
                                  _viewModel.emails.refresh();
                                }
                              },
                              child: Icon(
                                Icons.remove_circle_outline_outlined,
                                size: 20,
                                color: errorRed,
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                ),
                Center(
                  child: IconButton(
                      onPressed: () {
                        if(_viewModel.emails.length < 5) {
                          _viewModel.emails.add(TextEditingController());
                          _viewModel.emails.refresh();
                        }
                      },
                      icon: Icon(
                        Icons.add_circle_outline_sharp,
                        size: 30,
                        color: primaryGrey,
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomMaterialButton(
                    onPressed: () {},
                    text: 'Save',
                    width: 150,
                    margin: EdgeInsets.only(top: 20),
                  ),
                )
              ]
          ),
          SectionContainer(
              height: _viewModel.locationFormHeight,
              formKey: _viewModel.locationsFormKey,
              headingText: 'Office Locations',
              children: [
                Obx(() => Column(
                  spacing: 20,
                  children: List.generate(_viewModel.offices.length, (index) {
                    return Row(
                      spacing: 15,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            title: index == 0 ? 'Title' : '',
                            includeAsterisk: true,
                            controller: _viewModel.offices.keys.elementAt(index),
                            maxLength: 50,
                            maxLines: 1,
                            showCounter: true,
                            validator: (value) => Validators.validateEmptyField(value),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Column(
                                children: List.generate(_viewModel.offices.values.elementAt(index).length, (index2) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 15,
                                    children: [
                                      Expanded(
                                        child: CustomTextFormField(
                                          maxLength: 60,
                                          showCounter: true,
                                          includeAsterisk: true,
                                          title: index == 0 && index2 == 0 ? 'Address Line' : '',
                                          controller: _viewModel.offices.values.elementAt(index)[index2],
                                          validator: (value) => Validators.validateEmptyField(value),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: index == 0 && index2 == 0 ? 40 : 15),
                                        child: InkWell(
                                          onTap: () {
                                            if(_viewModel.offices.values.elementAt(index).length > 1) {
                                              _viewModel.offices.values.elementAt(index).removeAt(index2);
                                            } else {
                                              _viewModel.offices.remove(_viewModel.offices.keys.elementAt(index));
                                            }

                                            _viewModel.offices.refresh();
                                          },
                                          child: Icon(
                                            Icons.remove_circle_outline_outlined,
                                            size: 22,
                                            color: errorRed,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }),
                              ),
                              Center(
                                child: IconButton(
                                    onPressed: () {
                                      if(_viewModel.offices.values.elementAt(index).length < 3) {
                                        _viewModel.offices.values.elementAt(index).add(TextEditingController());
                                        _viewModel.offices.refresh();
                                      }
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline_outlined,
                                      size: 22,
                                      color: primaryGrey,
                                    )
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }),
                )),
                Center(
                  child: IconButton(
                      onPressed: () {
                        _viewModel.offices.addAllIf(_viewModel.offices.length < 6,
                            {TextEditingController() : [TextEditingController()]});
                        _viewModel.offices.refresh();
                      },
                      icon: Icon(
                        Icons.add_circle_outline_sharp,
                        size: 30,
                        color: primaryGrey,
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomMaterialButton(
                      onPressed: () {},
                    text: 'Save',
                    width: 150,
                    margin: EdgeInsets.only(top: 20),
                  ),
                )
              ]
          ),
          SectionContainer(
            headingText: 'Whatsapp',
              formKey: _viewModel.whatsappFormKey,
              height: _viewModel.whatsappFormHeight,
              children: [
                Obx(() => Column(
                  spacing: 10,
                  children: List.generate(_viewModel.whatsapp.length, (index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: _viewModel.whatsapp[index],
                            maxLength: 20,
                            showCounter: true,
                            validator: (value) => Validators.validateEmptyField(value),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: InkWell(
                            onTap: () {
                              if(_viewModel.whatsapp.length > 1) {
                                _viewModel.whatsapp.removeAt(index);
                                _viewModel.whatsapp.refresh();
                              }
                            },
                            child: Icon(
                              Icons.remove_circle_outline_outlined,
                              size: 20,
                              color: errorRed,
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                ),
                ),
                Center(
                  child: IconButton(
                      onPressed: () {
                        if(_viewModel.whatsapp.length < 5) {
                          _viewModel.whatsapp.add(TextEditingController());
                          _viewModel.whatsapp.refresh();
                        }
                      },
                      icon: Icon(
                        Icons.add_circle_outline_sharp,
                        size: 30,
                        color: primaryGrey,
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomMaterialButton(
                    onPressed: () {},
                    text: 'Save',
                    width: 150,
                    margin: EdgeInsets.only(top: 20),
                  ),
                )
              ]
          ),
          SectionContainer(
            headingText: 'Phone Numbers',
            formKey: _viewModel.phoneFormKey,
              height: _viewModel.phoneFormHeight,
              children: [
                Obx(() => Column(
                  spacing: 15,
                  children: List.generate(_viewModel.phoneNos.length, (index) {
                    return InformaticsOrStatsTextFormFields(
                        headingController: _viewModel.phoneNos.keys.elementAt(index),
                        subtitleController: _viewModel.phoneNos.values.elementAt(index),
                      headingText: 'Country',
                      subtitleText: 'Number',
                      includeTitle: index == 0,
                      includeButton: true,
                      onTap: () {
                          if(_viewModel.phoneNos.length > 1) {
                            _viewModel.phoneNos.remove(_viewModel.phoneNos.keys.elementAt(index));
                            _viewModel.phoneNos.refresh();
                          }
                      },
                    );
                  }),
                )),
                Center(
                  child: IconButton(
                      onPressed: () {
                        if(_viewModel.phoneNos.length < 5) {
                          _viewModel.phoneNos.addAll({TextEditingController() : TextEditingController()});
                          _viewModel.phoneNos.refresh();
                        }
                      },
                      icon: Icon(
                        Icons.add_circle_outline_sharp,
                        size: 30,
                        color: primaryGrey,
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomMaterialButton(
                    onPressed: () {},
                    text: 'Save',
                    width: 150,
                    margin: EdgeInsets.only(top: 20),
                  ),
                )
              ]
          )
        ]
    );
  }
}
