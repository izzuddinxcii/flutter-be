import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:flutter_be/models/users.dart';
import 'package:flutter_be/view_models/users.dart';
import 'package:flutter_be/views/user_page.dart';

class ListCard extends StatelessWidget {
  final List<User>? users;
  final Function? inheritFunction;
  const ListCard({super.key, this.users, this.inheritFunction});

  void _showAlertDialog(BuildContext context, String username) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Confirm?'),
        content: const Text('Proceed to delete this freelancer?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              DeleteUserModel(username);
              inheritFunction!();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users!.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (_, int index) {
        var user = users!.elementAt(index);
        return Column(mainAxisSize: MainAxisSize.min, children: [
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserPage(
                            username: user.username,
                          )),
                );
              },
              child: Card(
                  child: Stack(children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_rounded,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () async {
                      _showAlertDialog(context, user.username);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                      width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 26.0,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  'https://www.gravatar.com/avatar/${md5.convert(utf8.encode((user.email).toString())).toString()}?d=https%3A%2F%2Fui-avatars.com%2Fapi%2F/${user.username}}/104'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              user.username,
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              const Icon(
                                Icons.email_rounded,
                                color: Colors.black26,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                user.email,
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 14.0),
                              )
                            ]),
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              const Icon(
                                Icons.call_rounded,
                                color: Colors.black26,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                user.phoneNumber,
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 14.0),
                              )
                            ]),
                            const SizedBox(
                              height: 10,
                            ),
                            displayTag(user.skillSets, Colors.white, Theme.of(context).primaryColor),
                            const SizedBox(
                              height: 3,
                            ),
                            displayTag(user.hobby, Colors.black, Theme.of(context).dividerColor)
                          ])),
                )
              ])))
        ]);
      },
    );
  }

  Widget displayTag(List<dynamic> strings, Color fgColor, Color bgColor) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: strings
            .map((item) => Padding(
                padding: const EdgeInsets.all(1.6),
                child: DecoratedBox(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: bgColor),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        child: Text(
                          item.toString(),
                          style: TextStyle(fontSize: 13, color: fgColor),
                        )))))
            .toList());
  }
}
