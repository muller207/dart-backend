import '../../apis/news_api.dart';
import '../../apis/login_api.dart';
import '../../apis/user_api.dart';
import '../../dao/news_dao.dart';
import '../../dao/user_dao.dart';
import '../../models/news_model.dart';
import '../../services/generic_service.dart';
import '../../services/login_service.dart';
import '../../services/news_service.dart';
import '../../services/user_service.dart';
import '../database/db_configuration.dart';
import '../database/mysql_db_configuration.dart';
import '../security/security_server.dart';
import '../security/sercurity_server_imp.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<DBConfiguration>(() => MySqlDBConfiguration());

    di.register<SecurityService>(() => SecurityServerImp());

    di.register<NewsDAO>(() => NewsDAO(di<DBConfiguration>()));
    di.register<GenericService<NewsModel>>(() => NewsService(di<NewsDAO>()));
    di.register<NewsApi>(() => NewsApi(di<GenericService<NewsModel>>()));

    di.register<UserDAO>(() => UserDAO(di<DBConfiguration>()));
    di.register<UserService>(() => UserService(di<UserDAO>()));
    di.register<UserApi>(() => UserApi(di<UserService>()));

    di.register<LoginService>(() => LoginService(di<UserService>()));
    di.register<LoginApi>(
        () => LoginApi(di<SecurityService>(), di<LoginService>()));

    return di;
  }
}
