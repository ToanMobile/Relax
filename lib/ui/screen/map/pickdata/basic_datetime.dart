import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relax/common/constant.dart';
import 'package:relax/generated/l10n.dart';
import 'package:relax/ui/widget/app_bar.dart';

class MyDateTimePage extends StatefulWidget {
  DateTime selectedTime;
  final Function(DateTime, bool) onSelected;
  final bool _isFromTime;

  MyDateTimePage(this.selectedTime, this.onSelected, this._isFromTime);

  @override
  MyDateTimePageState createState() => MyDateTimePageState();
}

class MyDateTimePageState extends State<MyDateTimePage> {
  final formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarIcon.back(
        title: S.of(context).pickup_datetime,
      ).build(context),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: <Widget>[
          buildDateTimeForm(),
        ],
      ),
    );
  }

  Widget buildDateTimeForm() => Form(
        key: formKey1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            buildDateTimeField(),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              SizedBox(height: 20),
              RaisedButton(
                child: Text(S.of(context).save),
                onPressed: () {
                  formKey1.currentState.save();
                  Navigator.of(context).pop();
                  widget.onSelected(widget.selectedTime, widget._isFromTime);
                },
              ),
              RaisedButton(
                child: Text(S.of(context).reset),
                onPressed: () => formKey1.currentState.reset(),
              ),
              RaisedButton(
                child: Text(S.of(context).validate),
                onPressed: () => formKey1.currentState.validate(),
              ),
            ]),
          ],
        ),
      );

  Widget buildDateTimeField() => DateTimeField(
        format: Constant.format,
        initialValue: widget.selectedTime != null ? widget.selectedTime : DateTime.now(),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(context: context, firstDate: DateTime(2020), initialDate: currentValue ?? DateTime.now(), lastDate: DateTime(2022));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            widget.selectedTime = DateTimeField.combine(date, time);
            return widget.selectedTime;
          } else {
            widget.selectedTime = currentValue;
            return widget.selectedTime;
          }
        },
      );
}
