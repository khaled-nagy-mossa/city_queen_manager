import 'package:branch_manager/util/app_localization.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_imports.dart';

String locale;

///after replace category module
Future<void> main() async {
  AppService.turnOnEnhancedProtection(turnOn: false);

  Bloc.observer = AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseCoreHelper.initial();

  await AppService.setupSystemChrome();

  FCM.setupBackgroundMessages();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locale = sharedPreferences.getString("LANG") ?? 'en';

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final _navigatorKey = GlobalKey<NavigatorState>();

  // use to change application language

  @override
  void initState() {
    super.initState();
    //use future and duration zero to use context --> don't use didChangeDependencies plz
    Future<void>.delayed(Duration.zero).then((value) {
      LocalNotificationService.initial(context
          // _navigatorKey.currentState.overlay.context,
          );
      FCM.setupListener();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (context) {
            final userData = AuthCubit.get(context)?.user?.data;
            return ChatCubit(
              chatUser: ChatUser(
                name: userData?.name,
                id: userData?.id?.toString(),
                avatar: API.imageUrl(userData?.avatar),
              ),
            );
          },
        ),
        BlocProvider<AccountCubit>(
          create: (context) => AccountCubit(authCubit: AuthCubit.get(context)),
        ),
      ],
      child: GetMaterialApp(
        navigatorKey: _navigatorKey,
        title: AppData.appName,
        debugShowCheckedModeBanner: false,
        translations: Messages(),
        locale: Locale(locale),
        home: CheckInternetScreen(
          child: AccountBlocConsumer(
            child: AuthBlocConsumer(
              navigatorKey: _navigatorKey,
              child: const HomeView(),
            ),
          ),
        ),
        builder: (context, widget) {
          return Builder(
            builder: (context) {
              if (Platform.isAndroid || Platform.isIOS) {
                return InternetConnectionListener(widget: widget);
              } else {
                return widget;
              }
            },
          );
        },
        theme: AppTheme.light(),
      ),
    );
  }
}

// keytool -genkey -v -keystore c:\Users\Shehab\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
// Is CN=shehab, OU=shehab, O=shehab, L=shehab, ST=shehab, C=sh correct?
// password: Shehab*123
