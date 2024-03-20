import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maraphons/bloc/app_bloc_bloc.dart';
import 'package:maraphons/bloc/rating_bloc/rating_bloc.dart';
import 'package:maraphons/model/word.dart';
import 'package:maraphons/widgets/app_bar_title.dart';
import 'package:maraphons/widgets/button_widget.dart';
import 'package:maraphons/widgets/input_field.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final linkController = TextEditingController();
  final nameController = TextEditingController();
  final dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime dateTime = DateTime.now();

  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        dateController.text = getDate();
      });
    }
    return selectedDate;
  }

  String getDate() {
    // ignore: unnecessary_null_comparison
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTitle(
        titleText: Word.settings,
        size: 22,
        height: MediaQuery.of(context).size.height,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(border: Border.all()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(Word.linkTitle),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 3,
                      child: InputField(
                        textEditingController: linkController,
                        icon: Icons.dataset_linked_outlined,
                        text: context.read<AppBlocBloc>().state.urlTable,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Button(
                            onTap: () {
                              _showSnackbar(linkController.text);
                              context.read<RatingBloc>().add(
                                  ChangeUrl(updateLink: linkController.text));
                            },
                            text: Word.linkSave),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(Word.eventTitle),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 3,
                      child: InputField(
                        textEditingController: nameController,
                        icon: Icons.text_snippet_outlined,
                        text: context.read<AppBlocBloc>().state.nameEvent,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Button(
                            onTap: () {
                              _showSnackbar(nameController.text);
                              context
                                  .read<AppBlocBloc>()
                                  .add(EditNameChanged(nameController.text));
                            },
                            text: Word.eventSave),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(Word.dateTitle),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        onTap: () => _selectDate(context),
                        controller: dateController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: context
                              .read<AppBlocBloc>()
                              .state
                              .endsEvent
                              .toString(),
                          prefixIcon: const Icon(Icons.calendar_month),
                          suffixIcon: IconButton(
                            onPressed: dateController.clear,
                            icon: const Icon(Icons.clear),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Button(
                            onTap: () {
                              context.read<AppBlocBloc>().add(EditDateChanged(
                                  DateTime.parse(dateController.text)));
                              _showSnackbar(dateController.text);
                            },
                            text: Word.dateSave),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
