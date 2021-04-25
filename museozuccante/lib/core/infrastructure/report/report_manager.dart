import 'dart:io';

// import 'package:f_logs/model/flog/flog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:museo_zuccante/core/infrastructure/error/types/failures.dart';
import 'package:museo_zuccante/core/infrastructure/localization/app_localizations.dart';
import 'package:museo_zuccante/core/utils/mz_utils.dart';

import '../mz_preferences.dart';

mixin MZReportManager {
  static void sendEmail(
    BuildContext context, {
    Failure failure,
  }) async {
    // await FLog.exportLogs();
    var path = await _localPath;
    path = '$path/FLogs';

    final random = MZUtils.getRandomNumber();
    final subject = 'Bug report #$random - ${DateTime.now().toString()}';

    String userMessage = '';

    if (failure != null) {
      userMessage += failure.e.toString();
      userMessage += failure.localizedDescription(context);
    }

    final packageInfo = await PackageInfo.fromPlatform();
    userMessage +=
        "Versione app: ${packageInfo.version}+${packageInfo.buildNumber}";

    userMessage += "\nPiattaforma: ${Platform.operatingSystem}\n";
    userMessage +=
        '${AppLocalizations.of(context).translate("email_message")}\n  -';

    final Email reportEmail = Email(
      body: userMessage,
      subject: subject,
      recipients: [MZPreferences.email],
      attachmentPaths: ['$path/flog.txt'],
      isHTML: false,
    );
    await FlutterEmailSender.send(reportEmail);
  }

  static Future<String> get _localPath async {
    var directory;

    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getExternalStorageDirectory();
    }

    return directory.path;
  }
}
