import 'package:flutter/material.dart';
import 'package:hydrogen_complian/models/complain_model.dart';
import 'package:hydrogen_complian/repo/http_repo.dart';
import 'package:hydrogen_complian/utils/constants.dart';
import 'package:hydrogen_complian/widgets/appbar_row.dart';
import 'package:hydrogen_complian/widgets/custom_botton.dart';
import 'package:hydrogen_complian/widgets/text_with_title.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/complain_provider.dart';
import '../widgets/text_field_widget.dart';

class SubmitComplainPage extends StatefulWidget {
  const SubmitComplainPage({super.key});

  @override
  State<SubmitComplainPage> createState() => _SubmitComplainPageState();
}

class _SubmitComplainPageState extends State<SubmitComplainPage> {
  bool isLoading = false;
  String selectedItem = "Low";
  TextEditingController titleController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppBarRow(),
            const SizedBox(
              height: 40,
            ),
            TextWithTitle(
                controller: titleController,
                extendTextField: false,
                title: "Title",
                labelText: "Enter Title"),
            TextWithTitle(
                controller: summaryController,
                extendTextField: true,
                title: "Summary",
                labelText: "Voice Your Complains"),
            DropdownButton(
                elevation: 10,
                value: selectedItem,
                items: AppConstants.complainLevels.map((complainLevel) {
                  return DropdownMenuItem<String>(
                      value: complainLevel,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Text(
                          complainLevel,
                        )),
                      ));
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedItem = value!;
                  });
                }),
            CustomButton(
              isLoading: isLoading,
              onTap: () async {
                final pref = await SharedPreferences.getInstance();

                await GeneralHttpRequest().postComplain(
                  context,
                  token: pref.getString('token'),
                  api: '/submitComplaint',
                  complain: ComplainModel(
                    summary: summaryController.text,
                    title: titleController.text,
                    rating: AppConstants.complainLevels.indexOf(selectedItem),
                  ),
                );

                summaryController.clear();
                titleController.clear();

                await Provider.of<ComplainProvider>(context, listen: false)
                    .getComplainList();

                Navigator.pop(context);
              },
              text: "Submit",
              icon: Icons.upload_rounded,
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}
