import 'package:flutter/material.dart';
import 'package:hydrogen_complian/models/complain_model.dart';
import 'package:hydrogen_complian/pages/submit_complain.dart';
import 'package:hydrogen_complian/providers/complain_provider.dart';
import 'package:hydrogen_complian/repo/http_repo.dart';
import 'package:hydrogen_complian/utils/constants.dart';
import 'package:hydrogen_complian/widgets/custom_botton.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<void> reload() async {
    await Provider.of<ComplainProvider>(context, listen: false)
        .getComplainList();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ComplainProvider>(context, listen: false).getComplainList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await reload();
        },
        child: SingleChildScrollView(
          child: Consumer<ComplainProvider>(
            builder: (context, ComplainProvider complainProvider, child) {
              if (complainProvider.state == EnumState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (complainProvider.state == EnumState.error) {
                return GestureDetector(
                  onTap: () => reload(),
                  child: const Text('Tap ToRetry'),
                );
              }

              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: complainProvider.complains.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    color: AppConstants
                        .icons[complainProvider.complains[index].rating],
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        complainProvider.complains[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(complainProvider.complains[index].summary),
                      trailing: Text(
                        DateFormat('KK:mm:ss a dd-MM-yyyy ')
                            .format(
                              complainProvider.complains[index].createdAt ??
                                  DateTime.now(),
                            )
                            .toString(),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        autofocus: true,
        tooltip: "Complain",
        child: const Icon(Icons.add, size: 30),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const SubmitComplainPage();
              },
            ),
          );
        },
      ),
    );
  }
}
