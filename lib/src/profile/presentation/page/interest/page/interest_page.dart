import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../../core/styles/colors.dart';

import '../../../bloc/interest/interest_bloc.dart';
import '../../../bloc/interest/interest_event.dart';
import '../../../bloc/interest/interest_state.dart';

import '../widget/text_input_interest.dart';
import '../widget/appbar_interest.dart';
import '../widget/header_interest.dart';

class InterestPage extends StatelessWidget {
  const InterestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final interestBloc = BlocProvider.of<InterestBloc>(context);

    return GestureDetector(
        onTap: () {
          context.read<InterestBloc>().unfocus;
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(65),
              child: AppBarInterest(),
            ),
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topRight,
                      radius: 1.5173,
                      colors: YouAppColors.greenGradient,
                      stops: [0, 0.5618, 1],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: Get.height / 5),
                      const HeaderInterest(),
                      _buildBodyInput(context, interestBloc),
                    ],
                  ),
                ),
              ],
            )));
  }

  GestureDetector _buildBodyInput(
    BuildContext context,
    InterestBloc interestBloc,
  ) {
    return GestureDetector(
      onTap: () {
        context.read<InterestBloc>().unfocus;
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(22, 35, 22, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
          child: Wrap(
            children: [
              _chipData(interestBloc),
              TextInputInterest(interestBloc: interestBloc),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<InterestBloc, InterestState> _chipData(
    InterestBloc interestBloc,
  ) {
    return BlocBuilder<InterestBloc, InterestState>(
      builder: (context, state) {
        if (state is InterestUpdated) {
          return Wrap(
            spacing: 7.0,
            children: state.interests.map((interest) {
              return Chip(
                side: BorderSide.none,
                backgroundColor:
                    const Color.fromARGB(255, 137, 232, 243).withOpacity(0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                label: Text(
                  interest.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onDeleted: () => interestBloc.add(RemoveInterest(interest)),
                deleteIcon: const Icon(
                  Icons.close,
                  size: 18,
                ),
              );
            }).toList(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
