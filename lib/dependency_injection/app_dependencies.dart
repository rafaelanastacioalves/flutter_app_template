import 'package:flutter/cupertino.dart';
import 'package:flutter_app_template/repository/Repository.dart';

class AppDependencies extends InheritedWidget {
  final AppRepository appRepository;

  AppDependencies(
      {@required dAO, @required webClient, @required Widget child})
      : this.appRepository = AppRepository(dAO: dAO, httpClient: webClient),
        super(child: child);

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return oldWidget.appRepository != appRepository;
  }
}
