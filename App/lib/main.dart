import 'package:famealy/screens/Family/abooutFamily.dart';
import 'package:famealy/screens/Family/createFamily.dart';
import 'package:famealy/screens/Family/joinFamily.dart';
import 'package:famealy/screens/Meal/CreateMeal.dart';
import 'package:famealy/screens/Meal/DailyMealPlan.dart';
import 'package:famealy/screens/Meal/GenerateMealPlan.dart';
import 'package:famealy/screens/Meal/MealPlans.dart';
import 'package:famealy/screens/Meal/ShoppingList.dart';
import 'package:famealy/screens/Meal/SelectDay.dart';
import 'package:famealy/screens/login/login_screen.dart';
import 'package:famealy/screens/profile/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Provider(
    create: (context) => AuthBloc(),
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/profile': (context) => Profile(),
        '/aboutFamily' : (context) => aboutFamily(),
        '/createFamily': (context) => createFamily(),
        '/joinFamily' : (context) => joinFamily(),
        '/mealPlan' : (context) => MealPlans(),
        '/shoppinglist':(context)=>ShoppingList(),
        '/selectDay' : (context) => selectDay(),
        '/dailyMealPlan' : (context) => dailyMealPlan(),
        '/generateMealPlan' : (context) => generateMealPlan(),
        '/createMeal' : (context) => createMeal(),
      },
    ),
  ));
}
