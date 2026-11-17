import 'dart:async';
import 'dart:math' as math;

import 'package:clinical_edge/app/l10n/generated/app_localizations.dart';
import 'package:clinical_edge/app/routes.dart';
import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/clock.dart';
import 'package:clinical_edge/core/formatting.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:clinical_edge/core/widgets/widgets.dart';
import 'package:clinical_edge/features/certifications/data/certificate_file_picker.dart';
import 'package:clinical_edge/features/certifications/domain/upload_certificate.dart';
import 'package:clinical_edge/features/certifications/presentation/cert_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// `/certs/upload`: modal sheet to upload a certificate (CERT-3).
class UploadSheet extends ConsumerStatefulWidget {
  /// Creates the sheet.
  const new({super.key});

  @override
  ConsumerState<UploadSheet> createState() => _UploadSheetState();
}

class _UploadSheetState extends ConsumerState<UploadSheet> {
  final _name = TextEditingController();
  PickedFile? _file;
  DateTime? _issued;
  DateTime? _expires;
  Set<UploadError> _errors = const {};
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  DateTime get _today => ref.read(clockProvider).today();

  Future<void> _pickFile() async {
    final f = await ref.read(certificateFilePickerProvider).pick();
    if (f != null && mounted) setState(() => _file = f);
  }

  Future<void> _pickDate({required bool expiry}) async {
    final today = _today;
    final initial = expiry
        ? (_expires ?? DateTime.utc(today.year + 2, today.month, today.day))
        : (_issued ?? today);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.utc(today.year - 10),
      lastDate: DateTime.utc(today.year + 10),
    );
    if (picked == null || !mounted) return;
    final date = DateTime.utc(picked.year, picked.month, picked.day);
    setState(() {
      if (expiry) {
        _expires = date;
      } else {
        _issued = date;
      }
      if (_errors.isNotEmpty) _errors = _validate();
    });
  }

  Set<UploadError> _validate() => UploadCertificate.validate(
    name: _name.text,
    issuedOn: _issued ?? _today,
    expiresOn: _expires,
  );

  Future<void> _submit() async {
    final errors = _validate();
    setState(() => _errors = errors);
    if (errors.isNotEmpty) return;
    setState(() => _busy = true);
    final l = AppLocalizations.of(context);
    // The sheet closes on success, so show the snackbar on the root overlay.
    final overlay = Navigator.of(context, rootNavigator: true).overlay!.context;
    final router = GoRouter.of(context);
    final name = _name.text.trim();
    await ref.read(uploadCertificateProvider)(
      name: name,
      issuedOn: _issued ?? _today,
      expiresOn: _expires,
    );
    if (!mounted || !overlay.mounted) return;
    router.go(AppRoutes.certs);
    AppSnackBar.show(
      overlay,
      title: l.uploadDoneTitle,
      message: l.uploadDoneMessage(shortCertName(name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    String? dateError;
    if (_errors.contains(UploadError.expiryRequired)) {
      dateError = l.uploadErrorExpiry;
    } else if (_errors.contains(UploadError.expiryBeforeIssue)) {
      dateError = l.uploadErrorExpiryOrder;
    }
    return AppBottomSheet(
      title: l.titleUploadCert,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _DropZone(file: _file, onTap: () => unawaited(_pickFile())),
            const SizedBox(height: 16),
            TextField(
              key: const Key('upload.name'),
              controller: _name,
              textInputAction: TextInputAction.done,
              onChanged: (_) {
                if (_errors.isNotEmpty) setState(() => _errors = _validate());
              },
              decoration: InputDecoration(
                labelText: l.uploadNameLabel,
                hintText: l.uploadNameHint,
                errorText: _errors.contains(UploadError.nameRequired)
                    ? l.uploadErrorName
                    : null,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: _DateField(
                    key: const Key('upload.issued'),
                    label: l.uploadIssued,
                    value: Formats.date(_issued ?? _today, locale),
                    onTap: () => unawaited(_pickDate(expiry: false)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DateField(
                    key: const Key('upload.expires'),
                    label: l.uploadExpires,
                    value: _expires == null
                        ? null
                        : Formats.date(_expires!, locale),
                    placeholder: l.uploadPickDate,
                    errorText: dateError,
                    onTap: () => unawaited(_pickDate(expiry: true)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            PrimaryButton(
              key: const Key('upload.submit'),
              label: l.uploadSubmit,
              icon: Icons.verified_outlined,
              loading: _busy,
              onPressed: _busy ? null : () => unawaited(_submit()),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropZone extends StatelessWidget {
  const new({required this.file, required this.onTap});

  final PickedFile? file;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.colors;
    final f = file;
    return DashedBorder(
      color: c.brand.withValues(alpha: 0.55),
      child: Material(
        color: c.brandSoft.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: InkWell(
          key: const Key('upload.dropZone'),
          borderRadius: BorderRadius.circular(AppRadii.card),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
            child: Column(
              children: <Widget>[
                if (f == null)
                  const _FloatingIcon()
                else
                  Icon(Icons.description_outlined, size: 32, color: c.brand),
                const SizedBox(height: 10),
                Text(
                  f == null ? l.uploadDropZone : f.name,
                  key: const Key('upload.fileLabel'),
                  textAlign: TextAlign.center,
                  style: context.body.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  f == null
                      ? l.uploadDropHint
                      : l.uploadFileSize(
                          Formats.integer((f.sizeBytes / 1024).round()),
                        ),
                  style: context.caption.copyWith(color: c.muted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Upload icon that gently floats up and down (static with reduced motion).
class _FloatingIcon extends StatefulWidget {
  const new();

  @override
  State<_FloatingIcon> createState() => _FloatingIconState();
}

class _FloatingIconState extends State<_FloatingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: Motion.pulse,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Motion.enabled(context)) {
      if (!_c.isAnimating) _c.repeat();
    } else {
      _c.stop();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, -4 * math.sin(_c.value * 2 * math.pi)),
        child: child,
      ),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(color: c.surface, shape: BoxShape.circle),
        child: Icon(Icons.cloud_upload_outlined, color: c.brand),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const new({
    required this.label,
    required this.value,
    required this.onTap,
    this.placeholder,
    this.errorText,
    super.key,
  });

  final String label;
  final String? value;
  final String? placeholder;
  final String? errorText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.field),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
          errorMaxLines: 2,
          suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
        ),
        child: value == null
            ? Text(
                placeholder ?? '',
                style: context.body.copyWith(color: c.muted),
              )
            : Text(value!, style: context.body),
      ),
    );
  }
}
