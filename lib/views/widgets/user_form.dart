// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_be/view_models/users.dart';
import 'dart:convert';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_be/models/users.dart';

class FormBuild extends StatefulWidget {
  final User? user;
  const FormBuild({super.key, this.user});

  @override
  State<FormBuild> createState() => _FormBuildState();
}

class _FormBuildState extends State<FormBuild> {
  @override
  void initState() {
    super.initState();
  }

  void _showAlertDialog(BuildContext context, String message, bool backToList) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Status'),
        content: Text(message),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              if (backToList) {
                Navigator.pop(context);
              }
            },
            child: const Text('Dissmiss'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    //print(widget.user!.toJson());
    return SizedBox(
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(
            height: 20,
          ),
          widget.user != null
              ? CircleAvatar(
                  radius: 46.0,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                      'https://www.gravatar.com/avatar/${md5.convert(utf8.encode((widget.user!.email).toString())).toString()}?d=https%3A%2F%2Fui-avatars.com%2Fapi%2F/${widget.user!.username}}/200'),
                )
              : const Text(
                  'Enter all field below to add new Freelancer.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
          const SizedBox(
            height: 20,
          ),
          FormBuilder(
              key: formKey,
              //autovalidateMode: AutovalidateMode.disabled,
              initialValue: widget.user != null ? widget.user!.toJson() : {},
              skipDisabled: true,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'username',
                  enabled: widget.user != null ? false : true,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                ),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'email',
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
                FormBuilderPhoneField(
                  name: 'phoneNumber',
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  defaultSelectedCountryIsoCode: 'MY',
                  priorityListByIsoCode: const ['MY'],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.required(),
                  ]),
                  keyboardType: TextInputType.phone,
                ),
                FormBuilderTextField(
                  initialValue: null,
                  name: 'password',
                  decoration: InputDecoration(
                    labelText: widget.user != null ? 'Set New Password' : 'Password',
                  ),
                  validator: widget.user != null
                      ? null
                      : FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                FormBuilderFilterChip<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'My programming skill sets'),
                  name: 'skillSets',
                  initialValue: widget.user != null ? widget.user!.skillSets.map((e) => e as String).toList() : null,
                  selectedColor: Theme.of(context).primaryColor,
                  options: const [
                    FormBuilderChipOption(
                      value: 'Dart',
                      avatar: CircleAvatar(child: Text('D')),
                    ),
                    FormBuilderChipOption(
                      value: 'Kotlin',
                      avatar: CircleAvatar(child: Text('K')),
                    ),
                    FormBuilderChipOption(
                      value: 'Java',
                      avatar: CircleAvatar(child: Text('J')),
                    ),
                    FormBuilderChipOption(
                      value: 'Swift',
                      avatar: CircleAvatar(child: Text('S')),
                    ),
                    FormBuilderChipOption(
                      value: 'Objective-C',
                      avatar: CircleAvatar(child: Text('O')),
                    ),
                  ],
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.minLength(1),
                    FormBuilderValidators.maxLength(3),
                  ]),
                ),
                FormBuilderTextField(
                  maxLines: null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'hobby',
                  initialValue: widget.user != null ? widget.user!.hobby.join('\n') : null,
                  decoration: const InputDecoration(labelText: 'Hobby', helperText: 'One hobby per line'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  valueTransformer: (value) {
                    return value!.toUpperCase().split('\n').toList();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () async {
                    if (formKey.currentState?.saveAndValidate() ?? false) {
                      if (widget.user != null) {
                        final UpdateUserModel message =
                            UpdateUserModel(widget.user!.username, widget.user!, formKey.currentState!.value);
                        _showAlertDialog(context, await message.singleUser, true);
                      } else {
                        final CreateUserModel message = CreateUserModel(formKey.currentState!.value);
                        _showAlertDialog(context, await message.singleUser,
                            await message.singleUser == 'User Created' ? true : false);
                      }
                    }
                  },
                  child: Text(
                    widget.user != null ? 'Update Freelancer' : 'Create New Freelancer',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ]))
        ]));
  }
}
