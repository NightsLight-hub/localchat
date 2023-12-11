part of 'strings.g.dart';

// Path: <root>
class _StringsEn implements BaseTranslations<AppLocale, _StringsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  );

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	String get locale => 'English';
	String get appName => 'LocalSend';
	late final _StringsGeneralEn general = _StringsGeneralEn._(_root);
	late final _StringsNetworkTabEn networkTab = _StringsNetworkTabEn._(_root);
	late final _StringsChatTabEn chatTab = _StringsChatTabEn._(_root);
	late final _StringsSettingsTabEn settingsTab = _StringsSettingsTabEn._(_root);
	late final _StringsTroubleshootPageEn troubleshootPage = _StringsTroubleshootPageEn._(_root);
}

// Path: general
class _StringsGeneralEn {
	_StringsGeneralEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get accept => 'Accept';
	String get accepted => 'Accepted';
	String get add => 'Add';
	String get advanced => 'Advanced';
	String get cancel => 'Cancel';
	String get close => 'Close';
	String get confirm => 'Confirm';
	String get continueStr => 'Continue';
	String get copy => 'Copy';
	String get copiedToClipboard => 'Copied to Clipboard';
	String get decline => 'Decline';
	String get done => 'Done';
	String get delete => 'Delete';
	String get edit => 'Edit';
	String get error => 'Error';
	String get example => 'Example';
	String get files => 'Files';
	String get finished => 'Finished';
	String get hide => 'Hide';
	String get off => 'Off';
	String get offline => 'Offline';
	String get on => 'On';
	String get online => 'Online';
	String get open => 'Open';
	String get queue => 'Queue';
	String get quickSave => 'Quick Save';
	String get renamed => 'Renamed';
	String get reset => 'Reset';
	String get restart => 'Restart';
	String get settings => 'Settings';
	String get skipped => 'Skipped';
	String get start => 'Start';
	String get stop => 'Stop';
	String get save => 'Save';
	String get unchanged => 'Unchanged';
	String get unknown => 'Unknown';
	String get noItemInClipboard => 'No item in Clipboard';
}

// Path: networkTab
class _StringsNetworkTabEn {
	_StringsNetworkTabEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Network';
}

// Path: chatTab
class _StringsChatTabEn {
	_StringsChatTabEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Chat';
}

// Path: settingsTab
class _StringsSettingsTabEn {
	_StringsSettingsTabEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Settings';
	late final _StringsSettingsTabGeneralEn general = _StringsSettingsTabGeneralEn._(_root);
	late final _StringsSettingsTabReceiveEn receive = _StringsSettingsTabReceiveEn._(_root);
	late final _StringsSettingsTabNetworkEn network = _StringsSettingsTabNetworkEn._(_root);
	String get advancedSettings => 'Advanced settings';
}

// Path: troubleshootPage
class _StringsTroubleshootPageEn {
	_StringsTroubleshootPageEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Troubleshoot';
	String get subTitle => 'This app does not work as expected? Here you can find common solutions.';
	String get solution => 'Solution:';
	String get fixButton => 'Fix automatically';
	late final _StringsTroubleshootPageFirewallEn firewall = _StringsTroubleshootPageFirewallEn._(_root);
	late final _StringsTroubleshootPageNoConnectionEn noConnection = _StringsTroubleshootPageNoConnectionEn._(_root);
}

// Path: settingsTab.general
class _StringsSettingsTabGeneralEn {
	_StringsSettingsTabGeneralEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'General';
	String get brightness => 'Theme';
	late final _StringsSettingsTabGeneralBrightnessOptionsEn brightnessOptions = _StringsSettingsTabGeneralBrightnessOptionsEn._(_root);
	String get color => 'Color';
	late final _StringsSettingsTabGeneralColorOptionsEn colorOptions = _StringsSettingsTabGeneralColorOptionsEn._(_root);
	String get language => 'Language';
	late final _StringsSettingsTabGeneralLanguageOptionsEn languageOptions = _StringsSettingsTabGeneralLanguageOptionsEn._(_root);
	String get saveWindowPlacement => 'Quit: Save window placement';
	String get minimizeToTray => 'Quit: Minimize to Tray/Menu Bar';
	String get launchAtStartup => 'Autostart after login';
	String get launchMinimized => 'Autostart: Start hidden';
	String get animations => 'Animations';
}

// Path: settingsTab.receive
class _StringsSettingsTabReceiveEn {
	_StringsSettingsTabReceiveEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Receive';
	String get quickSave => '${_root.general.quickSave}';
	String get destination => 'Destination';
	String get downloads => '(Downloads)';
	String get saveToGallery => 'Save media to gallery';
	String get saveToHistory => 'Save to history';
}

// Path: settingsTab.network
class _StringsSettingsTabNetworkEn {
	_StringsSettingsTabNetworkEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Network';
	String get needRestart => 'Restart the server to apply the settings!';
	String get server => 'Server';
	String get alias => 'Alias';
	String get deviceType => 'Device type';
	String get deviceModel => 'Device model';
	String get port => 'Port';
	String portWarning({required Object defaultPort}) => 'You might not be detected by other devices because you are using a custom port. (default: ${defaultPort})';
	String get encryption => 'Encryption';
	String get multicastGroup => 'Multicast';
	String multicastGroupWarning({required Object defaultMulticast}) => 'You might not be detected by other devices because you are using a custom multicast address. (default: ${defaultMulticast})';
}

// Path: troubleshootPage.firewall
class _StringsTroubleshootPageFirewallEn {
	_StringsTroubleshootPageFirewallEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get symptom => 'This app can send files to other devices but other devices cannot send files to this device.';
	String solution({required Object port}) => 'This is most likely a firewall issue. You can solve this by allowing incoming connections (UDP and TCP) on port ${port}.';
	String get openFirewall => 'Open Firewall';
}

// Path: troubleshootPage.noConnection
class _StringsTroubleshootPageNoConnectionEn {
	_StringsTroubleshootPageNoConnectionEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get symptom => 'Both devices cannot discover each other nor can they share files.';
	String get solution => 'The problem exists on both sides? Then you need to make sure that both devices are in the same wifi network and share the same configuration (port, multicast address, encryption). The wifi may not allow communication between participants. In this case, this option must be enabled on the router.';
}

// Path: settingsTab.general.brightnessOptions
class _StringsSettingsTabGeneralBrightnessOptionsEn {
	_StringsSettingsTabGeneralBrightnessOptionsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get system => 'System';
	String get dark => 'Dark';
	String get light => 'Light';
}

// Path: settingsTab.general.colorOptions
class _StringsSettingsTabGeneralColorOptionsEn {
	_StringsSettingsTabGeneralColorOptionsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get system => 'System';
	String get oled => 'OLED';
}

// Path: settingsTab.general.languageOptions
class _StringsSettingsTabGeneralLanguageOptionsEn {
	_StringsSettingsTabGeneralLanguageOptionsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get system => 'System';
}
