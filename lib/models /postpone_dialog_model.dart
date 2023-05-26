
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_dialogs_model.dart';

class PostponeDialog extends StatefulWidget {
  final List<DropdownMenuItem> reasons;
  final int invoiceId;
  const PostponeDialog({Key? key, required this.reasons, required this.invoiceId}) : super(key: key);

  @override
  PostponeDialogState createState() => PostponeDialogState();
}

class PostponeDialogState extends State<PostponeDialog> {
  var val = 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: CustomAlertDialog(
        title: 'Выберите причину',
        content: Padding(
          padding: REdgeInsets.only(top: 8.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              value: val,
              isExpanded: true,
              buttonStyleData: ButtonStyleData(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                padding: REdgeInsets.all(8),
              ),
              items: widget.reasons,
              onChanged: (value) {
                setState(() {
                  val = value;
                });
              },
            ),
          ),
        ),
        actions: [
          CustomDialogAction(
            text: 'Отмена',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CustomDialogAction(
            text: 'Подтвердить',
            onPressed: () {
              Navigator.of(context).pop(val);
            },
          ),
        ],
      ),
    );
  }
}