import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_be/models/users.dart';
import 'package:flutter_be/view_models/users.dart';
import 'package:flutter_be/views/widgets/user_form.dart';

class UserPage extends StatefulWidget {
  final String? username;
  const UserPage({super.key, this.username});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserViewModel viewModel;

  @override
  void initState() {
    super.initState();
    if (widget.username != null) {
      viewModel = UserViewModel(widget.username!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('${widget.username == null ? 'New' : 'Edit'} Freelancer',
                textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold))),
        actions: const [
          SizedBox(
            width: 48,
          )
        ],
      ),
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                  widget.username != null
                      ? FutureBuilder<User>(
                          future: viewModel.singleUser,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.active:
                              case ConnectionState.waiting:
                                return const Center(child: CupertinoActivityIndicator());
                              case ConnectionState.done:
                                if (snapshot.hasData) {
                                  var users = snapshot.data;
                                  return FormBuild(user: users);
                                } else if (snapshot.hasError) {}
                            }
                            return const SizedBox.shrink();
                          })
                      : const FormBuild()
                ]),
              ))),
    );
  }
}
