part of 'strings.g.dart';

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  );

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final Translations _root = this; // ignore: unused_field

	// Translations
	String get locale => 'English';
	String get appName => 'LocalSend';
	late final _StringsGeneralEn general = _StringsGeneralEn._(_root);
	late final _StringsNetworkTabEn networkTab = _StringsNetworkTabEn._(_root);
	late final _StringsChatTabEn chatTab = _StringsChatTabEn._(_root);
	late final _StringsSettingsTabEn settingsTab = _StringsSettingsTabEn._(_root);
	late final _StringsConstantsEn constants = _StringsConstantsEn._(_root);
}

// Path: general
class _StringsGeneralEn {
	_StringsGeneralEn._(this._root);

	final Translations _root; // ignore: unused_field

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
	String get copiedAddressToClipboard => 'Copied Chat Address to Clipboard';
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

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Network';
}

// Path: chatTab
class _StringsChatTabEn {
	_StringsChatTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Chat';
	String get message => 'Message';
	String get sendFile => 'Send File';
	String get send => 'Send';
	String get qrToolTip => 'Left click to switch network, right click to copy chat room address';
}

// Path: settingsTab
class _StringsSettingsTabEn {
	_StringsSettingsTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Settings';
	late final _StringsSettingsTabGeneralEn general = _StringsSettingsTabGeneralEn._(_root);
}

// Path: constants
class _StringsConstantsEn {
	_StringsConstantsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get hostNickName => 'Compere';
}

// Path: settingsTab.general
class _StringsSettingsTabGeneralEn {
	_StringsSettingsTabGeneralEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'General';
	String get theme => 'Theme';
	late final _StringsSettingsTabGeneralThemeOptionsEn themeOptions = _StringsSettingsTabGeneralThemeOptionsEn._(_root);
	String get language => 'Language';
	late final _StringsSettingsTabGeneralLanguageOptionsEn languageOptions = _StringsSettingsTabGeneralLanguageOptionsEn._(_root);
	String get minimizeToTray => 'Quit: Minimize to Tray/Menu Bar';
}

// Path: settingsTab.general.themeOptions
class _StringsSettingsTabGeneralThemeOptionsEn {
	_StringsSettingsTabGeneralThemeOptionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get dark => 'Dark';
	String get light => 'Light';
}

// Path: settingsTab.general.languageOptions
class _StringsSettingsTabGeneralLanguageOptionsEn {
	_StringsSettingsTabGeneralLanguageOptionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get system => 'System';
}
