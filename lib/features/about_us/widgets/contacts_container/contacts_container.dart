import 'package:flutter/material.dart';
import 'package:transit_tracer/core/constants/sup_email.dart';
import 'package:transit_tracer/core/widgets/base_container.dart';
import 'package:transit_tracer/generated/l10n.dart';
import 'package:transit_tracer/core/services/app_info/app_info.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsContainer extends StatelessWidget {
  const ContactsContainer({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
      child: BaseContainer(
        theme: theme,
        child: Column(
          children: [
            Center(
              child: Text(
                S.of(context).contactsTitle,
                style: theme.textTheme.titleLarge,
              ),
            ),
            Divider(color: theme.colorScheme.inverseSurface),
            SizedBox(height: 8),
            Row(
              children: [
                Text('• '),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final Uri uri = Uri(
                        scheme: 'mailto',
                        path: SupEmail.supEmail,
                      );

                      await launchUrl(uri);
                    },
                    child: Text(
                      SupEmail.supEmail,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('• '),
                Expanded(child: Text(S.of(context).version(AppInfo.version))),
              ],
            ),
            Row(
              children: [
                Text('• '),
                Expanded(child: Text(S.of(context).contactsRegions)),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
