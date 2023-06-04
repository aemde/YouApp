import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/container.dart';
import '../../../bloc/profile/profil_bloc.dart';

class HoroscopeWiget extends StatelessWidget {
  const HoroscopeWiget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Horoscope:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.white.withOpacity(0.33),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 202, height: 36),
          child: containerAbout(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: BlocBuilder<ProfileBloc, ProfilState>(
                builder: (context, state) {
                  if (state.loop > 0) {
                    return Text(
                      state.zodiac,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    );
                  }
                  return Text(
                    "--",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
