import 'package:flutter/material.dart';

import '../../../../../../core/common/converter.dart';
import '../../../../../../core/components/logout_dialog.dart';

class AppBarProfile extends StatelessWidget {
  const AppBarProfile({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppBar(
        backgroundColor: const Color.fromRGBO(9, 20, 26, 1),
        elevation: 0,
        leadingWidth: 84,
        leading: _buildLeading(context),
        actions: _buildActions(context),
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            '@${removeEmailDomain(email)}',
            // '@$email',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        centerTitle: true,
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      GestureDetector(
        onTap: () => logoutDialog(context),
        child: const Padding(
          padding: EdgeInsets.only(right: 20.0, top: 10),
          child: Text(
            'Logout',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    ];
  }

  Widget _buildLeading(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20.0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 24,
          ),
          Text(
            'Back',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
