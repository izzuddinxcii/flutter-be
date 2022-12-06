import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_be/models/users.dart';
import 'package:flutter_be/view_models/users.dart';
import 'package:flutter_be/views/widgets/big_icon.dart';
import 'package:flutter_be/views/widgets/list_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchViewModel viewModel;
  String searchParam = '';

  @override
  void initState() {
    super.initState();
    viewModel = SearchViewModel(searchParam);
  }

  Future<void> _refreshScreen() async {
    setState(() {
      viewModel = SearchViewModel(searchParam);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text('Search Freelancer',
                  textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close_rounded)),
          actions: const [
            SizedBox(
              width: 48,
            )
          ],
        ),
        body: RefreshIndicator(
            onRefresh: _refreshScreen,
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            searchParam = value;
                            if (value.length > 3) {
                              _refreshScreen();
                            }
                          });
                        },
                        decoration: const InputDecoration(
                          helperText: 'Type more than 3 characters to search',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      searchParam.length > 3
                          ? FutureBuilder<List<User>>(
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
                                            isError: true,
                                            errorText: 'Sorry no data found',
                                            icon: Icons.no_accounts_rounded);
                                      }
                                    } else if (snapshot.hasError) {}
                                }
                                return const SizedBox.shrink();
                              },
                            )
                          : const BigIcon(
                              isError: false, errorText: 'Type to make a search', icon: Icons.search_rounded)
                    ])))));
  }
}
