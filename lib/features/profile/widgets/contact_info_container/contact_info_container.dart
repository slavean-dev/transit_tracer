import 'package:flutter/material.dart';
import 'package:transit_tracer/features/user/models/user_data/user_data.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/generated/l10n.dart';

class ContactInfoContainer extends StatelessWidget {
  const ContactInfoContainer({
    super.key,
    required this.theme,
    required this.userData,
  });

  final ThemeData theme;
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      theme: theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              S.of(context).contactCont.toUpperCase(),
              style: theme.textTheme.bodySmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).email,
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 8),
                    Text(
                      S.of(context).phone,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userData.email, style: theme.textTheme.bodyMedium),
                    SizedBox(height: 8),
                    Text(
                      userData.phoneNumber,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
