library tools;

// export 'copy_share.dart';
// export 'data.dart';
// export 'image.dart';
// export 'navigator.dart';
// export 'open_url.dart';
// export 'shared_pref.dart';
// export 'size.dart';
// export 'toast.dart';
// export 'ui.dart';
// export 'colors.dart';

import 'package:url_strategy/url_strategy.dart';

toolsMain(kIsWeb) {
  if (kIsWeb) {
    setPathUrlStrategy();
  }
}
