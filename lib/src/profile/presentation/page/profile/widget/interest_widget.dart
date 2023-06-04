import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../bloc/interest/interest_bloc.dart';
import '../../../bloc/interest/interest_state.dart';
import '../../interest/page/interest_page.dart';

class InterestWidget extends StatelessWidget {
  const InterestWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(14, 25, 31, 1),
        border: Border.all(
          color: const Color.fromRGBO(14, 25, 31, 1),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Interest",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const InterestPage(),
                          duration: const Duration(milliseconds: 0));
                    },
                    child: SvgPicture.asset(
                      'assets/icon/edit-2.svg',
                      width: 17,
                      height: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 7),
          BlocBuilder<InterestBloc, InterestState>(
            builder: (context, state) {
              if (state is InterestInitial ||
                  (state is InterestUpdated && state.interests.isEmpty)) {
                return const Padding(
                  padding: EdgeInsets.only(
                    bottom: 23,
                    left: 15,
                    right: 57,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Add your interests to help others know you better",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.52),
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              } else if (state is InterestUpdated) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 23,
                    left: 15,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: List.generate(
                        state.interests.length,
                        (index) {
                          final value = state.interests[index].toString();
                          return Container(
                            height: 31,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
