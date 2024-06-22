import 'package:ddx_trainer/features/widgets/rounded_button.dart';
import 'package:ddx_trainer/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../../text/text.dart';

class ErrorInfo extends StatelessWidget {
  const ErrorInfo(
      {super.key,
      this.textTitle,
      this.textDescription,
      this.textBtn,
      this.btnAction});

  final String? textTitle;
  final String? textDescription;
  final String? textBtn;
  final Function()? btnAction;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Center(
      child: Column(
        children: [
          Text(
            textTitle ?? AppTxt.errTextTitleDefault,
            style: theme.textTheme.headlineMedium
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Text(
            textAlign: TextAlign.center,
            textDescription ?? AppTxt.errTextDescriptionDefault,
            style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
          ),
          const SizedBox(
            height: 30,
          ),
          Builder(builder: (context) {
            if (btnAction != null) {
              return Padding(
                padding: const EdgeInsets.all(64.0),
                child: RoundedButton(
                  bgrColor: AppColor.secondaryAccentColor,
                  text: textBtn ?? AppTxt.errBtnTextDefault,
                  textStyle: theme.textTheme.labelMedium,
                  onPressed: () {
                    btnAction!();
                  },
                ),
              );
            } else {
              return Container();
            }
          })
        ],
      ),
    );
  }
}
