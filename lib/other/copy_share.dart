import 'package:clipboard/clipboard.dart';
// import 'package:share_plus/share_plus.dart';
import 'toast.dart';

toolscopyText(context,
        {required String text, String payam = 'متن با موفقیت کپی شد'}) =>
    FlutterClipboard.copy(text).then((value) => toast(payam, context));

// toolssharePost(String text, {String payam = 'text copied to clipboard'}) =>
//     Share.share('check out the post $text');
