import 'package:dashboard/dashboard.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const <PageRouteInfo>[
        HomeRouter(),
        ShappngCardRouter(),
        OrderHistoryRouter(),
        SettingsRouter(),
      ],
      animationCurve: Curves.linearToEaseOut,
      bottomNavigationBuilder: (_, tabsRouter) {
        return Padding(
          padding: const EdgeInsets.all(
            ApplicationPadding.PADDING_10,
          ),
          child: ApplicationBottomAppBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            margin: const EdgeInsets.symmetric(
              horizontal: Dimensions.SIZE_20,
              vertical: Dimensions.SIZE_10,
            ),
            items: <AppBarItem>[
              AppBarItem(
                selectedColor: ApplicationColors.white,
                icon: AppIcons.home,
                title: const Text(
                  StringConstant.home,
                ),
              ),
              AppBarItem(
                selectedColor: ApplicationColors.white,
                icon: AppIcons.card,
                title: const Text(
                  StringConstant.card,
                ),
              ),
              AppBarItem(
                selectedColor: ApplicationColors.white,
                icon: AppIcons.order,
                title: const Text(
                  StringConstant.order,
                ),
              ),
              AppBarItem(
                selectedColor: ApplicationColors.white,
                icon: AppIcons.settings,
                title: const Text(
                  StringConstant.settings,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
