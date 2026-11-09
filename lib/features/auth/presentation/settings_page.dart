import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/auth_repository.dart';
import 'package:madivizion_jdonuts_app/features/auth/domain/user_account.dart';
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
          SizedBox(height: AppSpacing.sm,),
          _NameBlock(name: _name, phone: _phone, tier: _tier, photo: _photo),
        
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: FilledButton(
              onPressed: () {
                context.read<SessionBloc>().add(const SessionLoggedOut());
              },
              child: Text(l10n.logOut),
            ),
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
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.headerWash,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppRadius.lg),
          bottomRight: Radius.circular(AppRadius.lg),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.md,
          ),
          child: Row(
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

String _tierLabel(String tier) {
  if (tier.isEmpty) {
    return tier;
  }
  return '${tier[0].toUpperCase()}${tier.substring(1)}';
}
