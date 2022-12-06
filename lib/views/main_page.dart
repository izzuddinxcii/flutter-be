import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_be/view_models/users.dart';
import 'package:flutter_be/models/users.dart';
import 'package:flutter_be/views/search_page.dart';
import 'package:flutter_be/views/user_page.dart';
import 'package:flutter_be/views/widgets/big_icon.dart';
import 'package:flutter_be/views/widgets/list_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late UsersViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = UsersViewModel();
  }

  Future<void> _refreshScreen() async {
    setState(() {
      viewModel = UsersViewModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text('Freelancer', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                },
                icon: const Icon(Icons.search_rounded)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserPage()),
            );
          },
          child: const Icon(Icons.person_add_alt_1_rounded),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
        body: RefreshIndicator(
            onRefresh: _refreshScreen,
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FutureBuilder<List<User>>(
                      future: viewModel.usersList,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return const Center(child: CupertinoActivityIndicator());
                          case ConnectionState.done:
                            if (snapshot.hasData) {
                              if (snapshot.data!.isNotEmpty) {
                                return ListCard(
                                  users: snapshot.data,
                                  inheritFunction: _refreshScreen,
                                );
                              } else {
                                return const BigIcon(
                                    isError: true, errorText: 'Sorry no data found', icon: Icons.no_accounts_rounded);
                              }
                            } else if (snapshot.hasError) {}
                        }
                        return const SizedBox.shrink();
                      },
                    )))));
  }
}
