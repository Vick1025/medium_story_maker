import 'package:get_it/get_it.dart';

//We use get_it for dependency injection.
//So we don't need to write all of this when we create a new bloc in main.dart

final serviceLocator = GetIt.instance;

Future<void> setupDependencies() async {
  _initCountryModule();
}

//All the country bloc dependencies registration here
void _initCountryModule() {}
