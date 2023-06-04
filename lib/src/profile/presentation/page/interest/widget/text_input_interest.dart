import 'package:flutter/material.dart';

import '../../../bloc/interest/interest_bloc.dart';
import '../../../bloc/interest/interest_event.dart';

class TextInputInterest extends StatelessWidget {
  const TextInputInterest({
    super.key,
    required this.interestBloc,
  });

  final InterestBloc interestBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextField(
        focusNode: interestBloc.unfocus,
        autocorrect: false,
        controller: interestBloc.interestTextController,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            interestBloc.add(AddInterest(value.trim()));
          }
        },
        decoration: const InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
        ),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
