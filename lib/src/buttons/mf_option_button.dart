import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

class MFOptionButton extends StatelessWidget {
  factory MFOptionButton.link({required String title, required VoidCallback onTap, Key? key}) =>
      MFOptionButton._(title: title, onTap: onTap, type: .link, key: key);

  factory MFOptionButton.switcher({
    required String title,
    required bool value,
    required ValueChanged<bool> onChange,
    Key? key,
  }) => MFOptionButton._(
    title: title,
    onTap: () => onChange(!value),
    type: .switcher,
    switchValue: value,
    onSwitchChange: onChange,
    key: key,
  );

  const MFOptionButton._({
    required this.title,
    required this.onTap,
    bool? switchValue,
    required MFOptionButtonType type,
    ValueChanged<bool>? onSwitchChange,
    super.key,
  }) : _type = type,
       _switchValue = switchValue,
       _onSwitchChange = onSwitchChange,
       assert(
         type != .switcher || (switchValue != null && onSwitchChange != null),
         'switchValue and onSwitchChange are required when type is switcher',
       );

  final VoidCallback onTap;
  final String title;
  final bool? _switchValue;
  final ValueChanged<bool>? _onSwitchChange;
  final MFOptionButtonType _type;

  BorderRadius get _borderRadius => .circular(12);

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: _type == .link ? onTap : null,
      borderRadius: _borderRadius,
      child: Ink(
        decoration: BoxDecoration(
          color: context.colors.neutralPrimaryS1,
          border: .all(color: context.colors.neutralSecondaryS3),
          borderRadius: _borderRadius,
        ),
        child: Padding(
          padding: const .fromLTRB(24, 14, 16, 14),
          child: Row(
            spacing: 14,
            children: [
              Expanded(child: Text(title, style: context.fonts.body)),
              _buildTrailing(context),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _buildTrailing(BuildContext context) => switch (_type) {
    .link => MFAssets.icons.arrowRight.svg(colorFilter: .mode(context.colors.neutralSecondaryS4, .srcIn)),
    .switcher => MFSwitcher(value: _switchValue!, onChange: _onSwitchChange!),
  };
}
