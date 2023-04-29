// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outshade_assignment/models/enums.dart';

import '../providers/user.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _key = GlobalKey<FormState>();
  Gender _gender = Gender.prefer_not_to_say;
  int? _age;

  String? validator(String? value) {
    if (_age == null) {
      return "Age can't be empty.";
    }

    if (_age?.isNegative ?? true) {
      return "Invalid age.";
    }
    return null;
  }

  void signInHandler() async {
    final isValid = _key.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    if (_age == null) {
      return;
    }

    await widget.user.signIn(
      age: _age!,
      gender: _gender,
    );
    Navigator.of(context).pop();
    return;
  }

  void changeHandler(String? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _age = int.parse(value);
    });
    _key.currentState?.validate();
  }

  DropdownMenuItem<Gender> _buildTile({required Gender gender}) {
    final title = gender.title;

    return DropdownMenuItem(
      value: gender,
      child: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Enter your age"),
              Form(
                key: _key,
                child: TextFormField(
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: const InputDecoration(
                    hintText: "Enter age",
                    labelText: "Enter age",
                  ),
                  validator: validator,
                  maxLength: 2,
                  onChanged: changeHandler,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Select your gender"),
                  const SizedBox(width: 20),
                  DropdownButton(
                    items: Gender.values
                        .map(
                          (gender) => _buildTile(gender: gender),
                        )
                        .toList(),
                    onChanged: (gender) {
                      setState(
                        () {
                          _gender = gender ?? Gender.prefer_not_to_say;
                        },
                      );
                    },
                    hint: const Text("Pick your gender"),
                    value: _gender,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: signInHandler,
                child: const Text("Sign In"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
