import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';
import 'package:mak_flyer_ui_kit/src/routes/mf_route_data.dart';

typedef MFPageBuilder = Page Function(BuildContext, GoRouterState, String);

class MFRoute<T extends MFRouteData> extends GoRoute {
  MFRoute(
    this.data,
    this.buildPage, {
    super.builder,
    super.caseSensitive,
    super.onExit,
    super.parentNavigatorKey,
    super.redirect,
    super.routes,
  }) : super(
         path: data.path,
         name: data.name,
         pageBuilder: (context, state) => buildPage.call(context, state, data.name),
       );

  final T data;
  final MFPageBuilder buildPage;
}
