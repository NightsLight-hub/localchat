import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/pages/widget/custom_dropdown_button.dart';
import 'package:localchat/pages/widget/responsive_list_view.dart';
import 'package:localchat/state/settings_state.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var minimizeToTray = ref.watch(settingsStateNotifierProvider
        .select((it) => it.value?.minimizeToTray ?? false));
    return ResponsiveListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text('settings',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 30),
          _SettingsSection(
            title: 'general',
            padding: const EdgeInsets.only(bottom: 0),
            children: [
              _SettingsEntry(
                label: 'theme',
                child: CustomDropdownButton<String>(
                  value: Theme.of(context).brightness == Brightness.dark
                      ? 'dark'
                      : 'light',
                  items: ['dark', 'light'].map((theme) {
                    return DropdownMenuItem(
                      value: theme,
                      alignment: Alignment.center,
                      child: Text(theme),
                    );
                  }).toList(),
                  onChanged: (theme) async {
                    if (theme == 'dark') {
                      AdaptiveTheme.of(context).setDark();
                    } else {
                      AdaptiveTheme.of(context).setLight();
                    }
                  },
                ),
              ),
              _BooleanEntry(
                label: 'Quit: minimize to tray',
                value: minimizeToTray,
                onChanged: (b) async {
                  await ref
                      .read(settingsStateNotifierProvider.notifier)
                      .setMinimizeToTray(b);
                },
              ),
            ],
          ),
        ]);
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsets padding;

  const _SettingsSection({
    required this.title,
    required this.children,
    this.padding = const EdgeInsets.only(bottom: 15),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsEntry extends StatelessWidget {
  final String label;
  final Widget child;

  const _SettingsEntry({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: Text(label),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 150,
            child: child,
          ),
        ],
      ),
    );
  }
}

/// A specialized version of [_SettingsEntry].
class _BooleanEntry extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _BooleanEntry({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _SettingsEntry(
      label: label,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: theme.inputDecorationTheme.fillColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Switch(
                value: value,
                onChanged: onChanged,
                activeTrackColor: theme.colorScheme.primary,
                activeColor: theme.colorScheme.onPrimary,
                inactiveThumbColor: theme.colorScheme.outline,
                inactiveTrackColor: theme.colorScheme.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
