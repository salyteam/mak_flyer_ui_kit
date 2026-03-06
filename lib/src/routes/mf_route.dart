import 'package:go_router/go_router.dart';
import 'package:mak_flyer_ui_kit/src/routes/mf_route_data.dart';

class MFRoute extends GoRoute {
  MFRoute(
    this.data, {
    super.pageBuilder,
    super.builder,
    super.caseSensitive,
    super.onExit,
    super.parentNavigatorKey,
    super.redirect,
    super.routes,
  }) : super(path: data.path, name: data.name);

  final MFRouteData data;
}
