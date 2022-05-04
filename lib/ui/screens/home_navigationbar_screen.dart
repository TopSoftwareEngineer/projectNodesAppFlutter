import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:projectx/bloc/bloc.dart';
import 'package:projectx/config/colors.dart';
import 'package:projectx/ui/screens/dashboard/dashboard.dart';
import 'package:projectx/ui/screens/home/cubit/home_cubit.dart';
import 'package:projectx/ui/screens/home/home_screen.dart';
import 'package:projectx/ui/screens/swap/swap_screen.dart';
import 'package:projectx/ui/widgets/loading_window.dart';
=======
import 'package:projectx/config/colors.dart';
import 'package:projectx/ui/screens/home/cubit/home_cubit.dart';
import 'package:projectx/ui/screens/home/home_screen.dart';
import 'package:projectx/ui/screens/swap/swap_screen.dart';
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3

import 'candlesticks/candlesticks_screen.dart';

class HomeBottomNavigationBarScreen extends StatefulWidget {
  const HomeBottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<HomeBottomNavigationBarScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeBottomNavigationBarScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = [
<<<<<<< HEAD
      const DashboardScreen(),
=======
      BlocProvider(
        create: (context) => HomeCubit()..getInitialData(),
        child: const HomeScreen(),
      ),
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
      const CandlesticksScreen(),
      const SwapScreen(),
    ];
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
<<<<<<< HEAD
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoadingState) {
            return const LoadingWidget();
          } else {
            return Scaffold(
              backgroundColor: _selectedIndex == 1 || _selectedIndex == 2
                  ? kBluebackground
                  : const Color(0xfffafafa),
              bottomNavigationBar: BottomNavigationBar(
                iconSize: 30,
                elevation: 10.0,
                selectedFontSize: 0,
                items: const [
                  BottomNavigationBarItem(
                    label: '',
                    icon: Icon(
                      Icons.home,
                      color: kBlack,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: '',
                    icon: Icon(
                      Icons.trending_up,
                      color: kBlack,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: '',
                    icon: Icon(
                      Icons.payment,
                      color: kBlack,
                    ),
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
              body: _widgetOptions.elementAt(_selectedIndex),
            );
          }
        },
=======
      child: Scaffold(
        backgroundColor: _selectedIndex == 1 || _selectedIndex == 2
            ? kBluebackground
            : const Color(0xfffafafa),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          elevation: 10.0,
          selectedFontSize: 0,
          items: const [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.home,
                color: kBlack,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.trending_up,
                color: kBlack,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.payment,
                color: kBlack,
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
>>>>>>> beb34eb28dea0270a3f133004d37114ce9cd13f3
      ),
    );
  }
}
