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
	@override late final _StringsTroubleshootPageZhCn troubleshootPage = _StringsTroubleshootPageZhCn._(_root);
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
}

// Path: settingsTab
class _StringsSettingsTabZhCn extends _StringsSettingsTabEn {
	_StringsSettingsTabZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '设置';
	@override late final _StringsSettingsTabGeneralZhCn general = _StringsSettingsTabGeneralZhCn._(_root);
	@override late final _StringsSettingsTabReceiveZhCn receive = _StringsSettingsTabReceiveZhCn._(_root);
	@override late final _StringsSettingsTabNetworkZhCn network = _StringsSettingsTabNetworkZhCn._(_root);
	@override String get advancedSettings => '高级设置';
}

// Path: troubleshootPage
class _StringsTroubleshootPageZhCn extends _StringsTroubleshootPageEn {
	_StringsTroubleshootPageZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '故障排除';
	@override String get subTitle => '应用没有按预期工作？您可以在这里找到常用解决方案。';
	@override String get solution => '解决方案：';
	@override String get fixButton => '自动修复';
	@override late final _StringsTroubleshootPageFirewallZhCn firewall = _StringsTroubleshootPageFirewallZhCn._(_root);
	@override late final _StringsTroubleshootPageNoConnectionZhCn noConnection = _StringsTroubleshootPageNoConnectionZhCn._(_root);
}

// Path: settingsTab.general
class _StringsSettingsTabGeneralZhCn extends _StringsSettingsTabGeneralEn {
	_StringsSettingsTabGeneralZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '通用';
	@override String get brightness => '亮度';
	@override late final _StringsSettingsTabGeneralBrightnessOptionsZhCn brightnessOptions = _StringsSettingsTabGeneralBrightnessOptionsZhCn._(_root);
	@override String get color => '颜色';
	@override late final _StringsSettingsTabGeneralColorOptionsZhCn colorOptions = _StringsSettingsTabGeneralColorOptionsZhCn._(_root);
	@override String get language => '语言';
	@override late final _StringsSettingsTabGeneralLanguageOptionsZhCn languageOptions = _StringsSettingsTabGeneralLanguageOptionsZhCn._(_root);
	@override String get saveWindowPlacement => '关闭时：保存窗口位置';
	@override String get minimizeToTray => '关闭时：最小化到系统托盘';
	@override String get launchAtStartup => '登录系统后自动启动程序';
	@override String get launchMinimized => '静默自启：只启动托盘服务';
	@override String get animations => '动画效果';
}

// Path: settingsTab.receive
class _StringsSettingsTabReceiveZhCn extends _StringsSettingsTabReceiveEn {
	_StringsSettingsTabReceiveZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '接收';
	@override String get quickSave => '${_root.general.quickSave}';
	@override String get destination => '保存目录';
	@override String get downloads => '(下载)';
	@override String get saveToGallery => '保存到相册';
	@override String get saveToHistory => '保存到历史记录';
}

// Path: settingsTab.network
class _StringsSettingsTabNetworkZhCn extends _StringsSettingsTabNetworkEn {
	_StringsSettingsTabNetworkZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '网络';
	@override String get needRestart => '重启服务器生效！';
	@override String get server => '服务器';
	@override String get alias => '别名';
	@override String get deviceType => '设备类型';
	@override String get deviceModel => '设备型号';
	@override String get port => '端口';
	@override String portWarning({required Object defaultPort}) => '由于正在使用自定义端口，你可能不会被其他设备检测到。（默认端口：${defaultPort}）';
	@override String get encryption => '加密';
	@override String get multicastGroup => '多播';
	@override String multicastGroupWarning({required Object defaultMulticast}) => '由于正在使用自定义多播地址，你可能不会被其他设备检测到。（默认地址：${defaultMulticast}）';
}

// Path: troubleshootPage.firewall
class _StringsTroubleshootPageFirewallZhCn extends _StringsTroubleshootPageFirewallEn {
	_StringsTroubleshootPageFirewallZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get symptom => '此设备可以发送文件至其他设备，但其它设备无法发送文件到此设备。';
	@override String solution({required Object port}) => '这最可能是由防火墙引起的。你可以通过在端口 ${port} 上允许（UDP 和 TCP）的传入请求来解决这个问题。';
	@override String get openFirewall => '打开防火墙';
}

// Path: troubleshootPage.noConnection
class _StringsTroubleshootPageNoConnectionZhCn extends _StringsTroubleshootPageNoConnectionEn {
	_StringsTroubleshootPageNoConnectionZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get symptom => '双方设备均无法发现对方或者分享文件。';
	@override String get solution => '当问题发生在双方设备上时，请先确认双方设备处于同一 Wi‑Fi 网络内，且有相同的网络（端口、多播地址、加密选项）配置。若因 Wi‑Fi 不允许参与者间通信，那么请在路由器中关闭这个（如：AP 隔离）选项。';
}

// Path: settingsTab.general.brightnessOptions
class _StringsSettingsTabGeneralBrightnessOptionsZhCn extends _StringsSettingsTabGeneralBrightnessOptionsEn {
	_StringsSettingsTabGeneralBrightnessOptionsZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get system => '跟随系统';
	@override String get dark => '暗色';
	@override String get light => '亮色';
}

// Path: settingsTab.general.colorOptions
class _StringsSettingsTabGeneralColorOptionsZhCn extends _StringsSettingsTabGeneralColorOptionsEn {
	_StringsSettingsTabGeneralColorOptionsZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get system => '跟随系统';
	@override String get oled => 'OLED';
}

// Path: settingsTab.general.languageOptions
class _StringsSettingsTabGeneralLanguageOptionsZhCn extends _StringsSettingsTabGeneralLanguageOptionsEn {
	_StringsSettingsTabGeneralLanguageOptionsZhCn._(_StringsZhCn root) : this._root = root, super._(root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get system => '跟随系统';
}
