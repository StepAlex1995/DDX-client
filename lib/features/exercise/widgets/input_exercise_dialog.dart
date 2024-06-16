import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../text/text.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/text_input.dart';

class InputExerciseDialog extends StatelessWidget {
  Function()? onPressed;

  InputExerciseDialog({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      child: SizedBox(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextInput(
                  maxLines: 2,
                  icon: Icons.description,
                  hint: AppTxt.addDescription,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  isPassword: false),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 32, right: 32),
              child: RoundedButton(
                bgrColor: theme.primaryColor,
                text: AppTxt.btnAdd,
                textStyle: theme.textTheme.labelMedium,
                onPressed: onPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
