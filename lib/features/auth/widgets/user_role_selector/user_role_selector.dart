import 'package:flutter/material.dart';
import 'package:transit_tracer/features/user/models/user_role/user_role.dart';
import 'package:transit_tracer/features/auth/widgets/role_button/role_button.dart';
import 'package:transit_tracer/generated/l10n.dart';

class UserRoleSelector extends StatelessWidget {
  const UserRoleSelector({
    super.key,
    required this.selected,
    required this.onChange,
    required this.theme,
  });

  final UserRole selected;
  final ValueChanged<UserRole> onChange;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          RoleButton(
            theme: theme,
            lable: S.of(context).clientTab,
            isSelected: selected == UserRole.client,
            onTap: () => onChange(UserRole.client),
          ),
          SizedBox(width: 8),
          RoleButton(
            theme: theme,
            lable: S.of(context).driverTab,
            isSelected: selected == UserRole.driver,
            onTap: () => onChange(UserRole.driver),
          ),
        ],
      ),
    );
  }
}
