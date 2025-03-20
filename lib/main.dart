import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzenalphatech/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:newzenalphatech/bloc/auth_state_bloc/bloc/auth_state_bloc.dart';
import 'package:newzenalphatech/bloc/category_bloc/bloc/category_bloc.dart';
import 'package:newzenalphatech/bloc/database_bloc/bloc/database_bloc.dart';
import 'package:newzenalphatech/bloc/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:newzenalphatech/constant/constants.dart';
import 'package:newzenalphatech/core/route/route.dart';
import 'package:newzenalphatech/core/theme/themedata.dart';
import 'package:newzenalphatech/model/category.dart';
import 'package:newzenalphatech/model/transaction.dart';
import 'package:newzenalphatech/presentation/home/screen/home.dart';
import 'package:newzenalphatech/repository/category/category_repo.dart';
import 'package:newzenalphatech/repository/transaction/transaction_repo.dart';
import 'package:newzenalphatech/secrets/firebase_options.dart';
import 'package:newzenalphatech/network/auth/auth_network.dart';
import 'package:newzenalphatech/network/database/database_network.dart';
import 'package:newzenalphatech/presentation/auth/screen/signin.dart';
import 'package:newzenalphatech/repository/auth/auth_repo.dart';
import 'package:newzenalphatech/repository/database/database_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newzenalphatech/model/transaction.dart' as tt;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(CategoryAdapter());

  await Hive.openBox<tt.Transaction>(transactionBox);
  await Hive.openBox<Category>(categoryBox);

  final firebaseAuthInstance = FirebaseAuth.instance;
  final firebaseFireStore = FirebaseFirestore.instance;

  runApp(MyApp(
    firebaseAuthInstance: firebaseAuthInstance,
    firebaseFireStore: firebaseFireStore,
  ));
}

class MyApp extends StatelessWidget {
  final FirebaseAuth firebaseAuthInstance;
  final FirebaseFirestore firebaseFireStore;

  const MyApp(
      {super.key,
      required this.firebaseAuthInstance,
      required this.firebaseFireStore});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepo(
            authNetwork: AuthNetwork(firebaseAuth: firebaseAuthInstance),
          ),
        ),
        RepositoryProvider(
          create: (context) => DatabaseRepo(
            databaseNetwork: DatabaseNetwork(
                firestoreInstance: firebaseFireStore,
                userId: firebaseAuthInstance.currentUser!.uid),
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepo>()),
          ),
          BlocProvider(
              create: (context) => AuthStateBloc(firebaseAuthInstance)),
          BlocProvider(
            create: (context) => DatabaseBloc(context.read<DatabaseRepo>()),
          ),
          BlocProvider(
            create: (_) => TransactionBloc(TransactionRepository(
                Hive.box<tt.Transaction>(transactionBox))),
          ),
          BlocProvider(
            create: (context) => CategoryBloc(
                CategoryRepository(Hive.box<Category>(categoryBox))),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(context),
          routes: routes,
          home: BlocSelector<AuthStateBloc, AuthStateState, bool>(
            selector: (state) {
              return state is LoggedInState;
            },
            builder: (context, isloggedIn) {
              if (isloggedIn) {
                return const Home();
              } else {
                return const Signin();
              }
            },
          ),
        ),
      ),
    );
  }
}
