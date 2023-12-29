part of 'strings.g.dart';

// Path: <root>
class _StringsZhCn extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsZhCn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zhCn,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <zh-CN>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	@override late final _StringsZhCn _root = this; // ignore: unused_field

	// Translations
	@override String get locale => '简体中文';
	@override String get appName => 'LocalSend';
	@override late final _StringsGeneralZhCn general = _StringsGeneralZhCn._(_root);
	@override late final _StringsNetworkTabZhCn networkTab = _StringsNetworkTabZhCn._(_root);
	@override late final _StringsChatTabZhCn chatTab = _StringsChatTabZhCn._(_root);
	@override late final _StringsSettingsTabZhCn settingsTab = _StringsSettingsTabZhCn._(_root);
	@override late final _StringsConstantsZhCn constants = _StringsConstantsZhCn._(_root);
}

// Path: general
class _StringsGeneralZhCn extends _StringsGeneralEn {
	_StringsGeneralZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get accept => '接受';
	@override String get accepted => '已接受';
	@override String get add => '添加';
	@override String get advanced => '高级';
	@override String get cancel => '取消';
	@override String get close => '关闭';
	@override String get confirm => '确认';
	@override String get continueStr => '继续';
	@override String get copy => '复制';
	@override String get copiedToClipboard => '已复制到剪贴板';
	@override String get copiedAddressToClipboard => '已复制聊天室地址';
	@override String get decline => '拒绝';
	@override String get done => '完成';
	@override String get edit => '编辑';
	@override String get error => '错误';
	@override String get example => '示例';
	@override String get files => '文件';
	@override String get finished => '已完成';
	@override String get hide => '隐藏';
	@override String get off => '关';
	@override String get offline => '离线';
	@override String get on => '开';
	@override String get online => '在线';
	@override String get open => '打开';
	@override String get queue => '队列';
	@override String get quickSave => '快速保存';
	@override String get renamed => '已重命名';
	@override String get reset => '重置';
	@override String get restart => '重启';
	@override String get settings => '设置';
	@override String get skipped => '已跳过';
	@override String get start => '开始';
	@override String get stop => '停止';
	@override String get save => '保存';
	@override String get unchanged => '未更改';
	@override String get unknown => '未知';
	@override String get noItemInClipboard => '剪贴板中没有项目';
	@override String get delete => '删除';
}

// Path: networkTab
class _StringsNetworkTabZhCn extends _StringsNetworkTabEn {
	_StringsNetworkTabZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '网络连接';
}

// Path: chatTab
class _StringsChatTabZhCn extends _StringsChatTabEn {
	_StringsChatTabZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '聊天';
	@override String get message => '消息';
	@override String get sendFile => '发送文件';
	@override String get send => '发送';
	@override String get qrToolTip => '左键单击切换网络，右键单击复制聊天室地址';
}

// Path: settingsTab
class _StringsSettingsTabZhCn extends _StringsSettingsTabEn {
	_StringsSettingsTabZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '设置';
	@override late final _StringsSettingsTabGeneralZhCn general = _StringsSettingsTabGeneralZhCn._(_root);
}

// Path: constants
class _StringsConstantsZhCn extends _StringsConstantsEn {
	_StringsConstantsZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get hostNickName => '主持人';
}

// Path: settingsTab.general
class _StringsSettingsTabGeneralZhCn extends _StringsSettingsTabGeneralEn {
	_StringsSettingsTabGeneralZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '通用';
	@override String get theme => '主题';
	@override late final _StringsSettingsTabGeneralThemeOptionsZhCn themeOptions = _StringsSettingsTabGeneralThemeOptionsZhCn._(_root);
	@override String get language => '语言';
	@override late final _StringsSettingsTabGeneralLanguageOptionsZhCn languageOptions = _StringsSettingsTabGeneralLanguageOptionsZhCn._(_root);
	@override String get minimizeToTray => '关闭时：最小化到系统托盘';
}

// Path: settingsTab.general.themeOptions
class _StringsSettingsTabGeneralThemeOptionsZhCn extends _StringsSettingsTabGeneralThemeOptionsEn {
	_StringsSettingsTabGeneralThemeOptionsZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get dark => '暗黑';
	@override String get light => '明亮';
}

// Path: settingsTab.general.languageOptions
class _StringsSettingsTabGeneralLanguageOptionsZhCn extends _StringsSettingsTabGeneralLanguageOptionsEn {
	_StringsSettingsTabGeneralLanguageOptionsZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get system => '跟随系统';
}
