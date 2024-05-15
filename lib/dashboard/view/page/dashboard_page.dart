import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myrepo/dashboard/cubit/dashboard_cubit.dart';
import 'package:myrepo/dashboard/modules/done/view/page/done_page.dart';
import 'package:myrepo/dashboard/modules/task/view/page/task_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          DashboardCubit cubit = context.read<DashboardCubit>();
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'new_task');
                    },
                    icon: const Icon(CupertinoIcons.plus))
              ],
            ),
            body: PageView(
              controller: cubit.pageController,
              onPageChanged: cubit.onChangeTab,
              children: const [
                TaskPage(),
                DonePage(),
                Text('suspended'),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.green,
              currentIndex: cubit.currentIndex,
              onTap: cubit.onChangeTab,
              items: const [
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.collections), label: 'task'),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.check_mark_circled), label: 'done'),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.stop_circle), label: 'suspended')
              ],
            ),
          );
        },
      ),
    );
  }
}
