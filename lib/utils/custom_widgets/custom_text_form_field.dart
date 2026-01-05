import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../validators.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 8,
    ),
    this.initialValue,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.autoValidateMode,
    this.hint,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.onTap,
    this.minLines,
    this.showCursor,
    this.suffixIcon,
    this.prefixIconSize,
    this.suffixIconSize,
    this.fillColor,
    this.prefixIcon,
    this.errorText,
    this.readOnly = false,
    this.inputFormatters,
    this.suffixOnPressed,
    this.onFieldSubmitted,
    this.textAlign = TextAlign.start,
    this.prefix,
    this.prefixText,
    this.prefixTextStyle,
    this.title,
    this.enabled,
    this.includeAsterisk = false,
    this.boxConstraints,
    this.titleColor,
    this.focusNode,
    this.maxLength,
    this.showCounter = false,
  });

  final String? hint;
  final Widget? prefix;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final AutovalidateMode? autoValidateMode;
  final bool? showCursor;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? prefixIconSize;
  final double? suffixIconSize;
  final EdgeInsetsGeometry contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? suffixOnPressed;
  final void Function(String)? onFieldSubmitted;
  final TextAlign textAlign;
  final String? prefixText;
  final TextStyle? prefixTextStyle;
  final String? title;
  final bool? enabled;
  final bool includeAsterisk;
  final BoxConstraints? boxConstraints;
  final Color? titleColor;
  final FocusNode? focusNode;
  final int? maxLength;
  final bool showCounter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title != null && title != '') Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: RichText(
            text: TextSpan(
              text: title!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: titleColor ?? primaryBlack,
                fontWeight: FontWeight.w600
              ),
              children: includeAsterisk ? [
                TextSpan(
                  text: ' *',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: errorRed,
                  ),
                ),
              ] : []
            ),
          ),
        ),
        TextFormField(
          focusNode: focusNode,
          maxLength: maxLength,
          buildCounter: showCounter ? (context, {required currentLength, required isFocused, required maxLength}) {
            return Text(
              '$currentLength/$maxLength',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: maxLength != null && currentLength <= maxLength ? null : errorRed
              )
            );
          } : (context, {required currentLength, required isFocused, required maxLength}) => null,
          onChanged: onChanged,
          enabled: enabled,
          readOnly: readOnly,
          maxLines: maxLines,
          minLines: minLines,
          onTap: onTap,
          initialValue: initialValue,
          showCursor: showCursor,
          controller: controller,
          autovalidateMode: autoValidateMode,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: keyboardType,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            constraints: boxConstraints,
            prefixIcon: prefixIcon,
            prefixText: prefixText,
            prefixStyle: prefixTextStyle,
            prefix: prefix,
            prefixIconConstraints: BoxConstraints(minWidth: 40, maxWidth: 40, minHeight: prefixIconSize ?? kMinInteractiveDimension),
            errorText: errorText,
            errorStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: errorRed,
                fontWeight: FontWeight.w600
            ),
            suffixIconConstraints: BoxConstraints(minWidth: suffixIconSize ?? 40, maxWidth: suffixIconSize ?? 40, minHeight: suffixIconSize ?? kMinInteractiveDimension),
            suffixIcon: suffixIcon != null ? InkWell(
              splashColor: Colors.transparent,
              customBorder: CircleBorder(),
              onTap: suffixOnPressed,
              child: suffixIcon,
            ) : SizedBox(),
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: primaryGrey,
            ),
            fillColor: primaryWhite,
            contentPadding: contentPadding,
          ),
          textAlign: textAlign,
        ),
      ],
    );
  }
}

class SingleStatTextAndTextFormField extends StatelessWidget {
  const SingleStatTextAndTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.includeHeading = false,
    this.maxLength = 5,
    this.headingText,
    this.labelText
  });

  final String label;
  final TextEditingController controller;
  final bool includeHeading;
  final int maxLength;
  final String? headingText;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(!includeHeading) SizedBox(height: 0.5,),
              if(includeHeading) Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  labelText ?? 'Label',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Expanded(
          flex: isSmallScreen(context) ? 3 : 4,
          child: CustomTextFormField(
            title: includeHeading ? 'Stat' : null,
            includeAsterisk: includeHeading,
            controller: controller,
            maxLength: maxLength,
            showCounter: true,
            maxLines: 1,
            minLines: 1,
            validator: (value) => Validators.validateEmptyField(value),
          ),
        )
      ],
    );
  }
}

class InformaticsOrStatsTextFormFields extends StatelessWidget {
  const InformaticsOrStatsTextFormFields({
    super.key,
    required this.headingController,
    required this.subtitleController,
    this.includeTitle = false,
    this.onTap,
    this.includeButton = false,
    this.headingText,
    this.subtitleText,
    this.headingMaxLength,
    this.subtitleMaxLength,
    this.showHeadingCounter = false,
    this.showSubtitleCounter = false,
  });

  final bool includeButton;
  final VoidCallback? onTap;
  final bool includeTitle;
  final TextEditingController headingController;
  final TextEditingController subtitleController;
  final String? headingText;
  final String? subtitleText;
  final int? headingMaxLength;
  final int? subtitleMaxLength;
  final bool showHeadingCounter;
  final bool showSubtitleCounter;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 15,
      children: [
        Expanded(
          child: CustomTextFormField(
            title: includeTitle ? headingText ?? 'Heading' : null,
            controller: headingController,
            includeAsterisk: true,
            showCounter: showHeadingCounter,
            maxLength: headingMaxLength,
            validator: (value) => Validators.validateEmptyField(value),
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            title: includeTitle ? subtitleText ?? 'Subtitle' : null,
            controller: subtitleController,
            showCounter: showSubtitleCounter,
            maxLength: subtitleMaxLength,
            includeAsterisk: true,
            validator: (value) => Validators.validateEmptyField(value),
          ),
        ),
        if(includeButton) InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(top: includeTitle ? 25.0 : 0),
            child: Icon(
              Icons.remove_circle_outline_rounded,
              color: errorRed,
              size: 20,
            ),
          ),
        )
      ],
    );
  }
}