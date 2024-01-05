import 'package:qpp_example/go_router/router.dart';

extension GoRouterExtension on String {
  /// 是否為首頁
  bool get isHomePage =>
      this == QppGoRouter.home || this == QppGoRouter.home + QppGoRouter.app;
}
