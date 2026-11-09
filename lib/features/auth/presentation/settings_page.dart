import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/app/locale/app_locale.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_repository.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/user_account.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/language_sheet.dart';
import 'package:madivizion_jdonuts_app/features/auth/presentation/session_bloc.dart';
import 'package:madivizion_jdonuts_app/features/catalog/presentation/catalog_image.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/catalog_repository.dart';
import 'package:madivizion_jdonuts_app/features/home/domain/home_feed.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// Home-style name block, with the phone and member level, plus Log out.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _name = '';
  String _phone = '';
  String _tier = '';
  String _photo = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final accountResult = await injector<AuthRepository>().signedInAccount();
    final feed = await injector<CatalogRepository>().loadHome();
    if (!mounted) {
      return;
    }
    final member = switch (feed.member) {
      Success<MemberProfile>(:final value) => value,
      Failure<MemberProfile>() => null,
    };
    setState(() {
      if (accountResult case Success<UserAccount?>(value: final account?)) {
        _name = accountDisplayName(account);
        _phone = account.phoneE164;
      }
      _tier = member?.tier ?? '';
      _photo = member?.photoUrl ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: Column(
        children: [
          _NameBlock(name: _name, phone: _phone, tier: _tier, photo: _photo),
          _LanguageRow(languages: injector<AppLocale>()),

          _LogOutRow(
            label: l10n.logOut,
            onPressed: () {
              context.read<SessionBloc>().add(const SessionLoggedOut());
            },
          ),
        ],
      ),
    );
  }
}

class _NameBlock extends StatelessWidget {
  const _NameBlock({
    required this.name,
    required this.phone,
    required this.tier,
    required this.photo,
  });

  final String name;
  final String phone;
  final String tier;
  final String photo;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      height: AppSpacing.xxl * 4,
      decoration: const BoxDecoration(color: AppColors.primaryDisabled),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.xxl,
            AppSpacing.md,
            AppSpacing.md,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Photo(url: photo),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: _name(context)),
                    if (phone.isNotEmpty) Text(phone, style: _caption(context)),
                    if (tier.isNotEmpty)
                      Text(
                        l10n.homeTierMember(_tierLabel(tier)),
                        style: _caption(context),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle? _name(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: AppTextSize.subtitle,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle? _caption(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
      fontSize: AppTextSize.caption,
      fontWeight: FontWeight.w500,
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox.square(
        dimension: 56,
        child: url.isEmpty
            ? const ColoredBox(color: AppColors.surface)
            : CatalogImage(url: url),
      ),
    );
  }
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({required this.languages});

  final AppLocale languages;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: languages,
      builder: (context, _) {
        final value = languages.isMyanmar
            ? l10n.settingsLanguageMyanmarValue
            : l10n.settingsLanguageEnglishValue;
        return _SettingLine(
          onTap: () => showLanguageSheet(context, languages),
          icon: const Icon(
            Icons.translate,
            color: AppColors.textSecondary,
            size: _SettingLine.glyph,
          ),
          label: l10n.settingsLanguage,
          detail: value,
        );
      },
    );
  }
}

class _LogOutRow extends StatelessWidget {
  const _LogOutRow({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return _SettingLine(
      onTap: onPressed,
      icon: const DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: SizedBox.square(
          dimension: _SettingLine.slot,
          child: Icon(
            Icons.logout,
            color: AppColors.onPrimary,
            size: _SettingLine.glyph,
          ),
        ),
      ),
      label: label,
    );
  }
}

/// One settings row. The icon slot is the same width on every row.
class _SettingLine extends StatelessWidget {
  const _SettingLine({
    required this.icon,
    required this.label,
    required this.onTap,
    this.detail,
  });

  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final String? detail;

  static const double slot = 40;
  static const double glyph = 22;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            SizedBox(
              width: slot,
              height: slot,
              child: Align(alignment: Alignment.centerLeft, child: icon),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Text(label, style: _label(context))),
            if (detail != null) Text(detail!, style: _detail(context)),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  TextStyle? _label(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700);
  }

  TextStyle? _detail(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w600,
    );
  }
}

String _tierLabel(String tier) {
  if (tier.isEmpty) {
    return tier;
  }
  return '${tier[0].toUpperCase()}${tier.substring(1)}';
}
