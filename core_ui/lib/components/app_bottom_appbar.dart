import 'package:core_ui/core_ui.dart';

class ApplicationBottomAppBar extends StatelessWidget {
  final List<AppBarItem> items;
  final int currentIndex;
  final Function(int)? onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? selectedColorOpacity;
  final ShapeBorder itemShape;
  final EdgeInsets margin;
  final EdgeInsets itemPadding;
  final Duration duration;
  final Curve curve;

  const ApplicationBottomAppBar({
    Key? key,
    required this.items,
    this.backgroundColor,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(ApplicationPadding.PADDING_10),
    this.itemPadding = const EdgeInsets.symmetric(
      vertical: ApplicationPadding.PADDING_16,
      horizontal: ApplicationPadding.PADDING_16,
    ),
    this.duration = const Duration(
      milliseconds: 500,
    ),
    this.curve = Curves.easeOutQuint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: backgroundColor ?? ApplicationColors.primaryButtonColor,
      ),
      child: Row(
        mainAxisAlignment: items.length <= 2
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.spaceBetween,
        children: [
          for (final item in items)
            TweenAnimationBuilder<double>(
              tween: Tween(
                end: items.indexOf(item) == currentIndex
                    ? Dimensions.SIZE_1
                    : Dimensions.SIZE_0,
              ),
              curve: curve,
              duration: duration,
              builder: (context, t, _) {
                final selectedColor = item.selectedColor ??
                    selectedItemColor ??
                    theme.primaryColor;

                final unselectedColor = item.unselectedColor ??
                    unselectedItemColor ??
                    theme.iconTheme.color;

                return Material(
                  color: Color.lerp(
                      selectedColor.withOpacity(
                        Dimensions.SIZE_0,
                      ),
                      selectedColor.withOpacity(
                        selectedColorOpacity ?? Dimensions.SIZE_0_1,
                      ),
                      t),
                  shape: itemShape,
                  child: InkWell(
                    onTap: () => onTap?.call(items.indexOf(item)),
                    customBorder: itemShape,
                    focusColor: selectedColor.withOpacity(
                      Dimensions.SIZE_0_1,
                    ),
                    highlightColor: selectedColor.withOpacity(
                      Dimensions.SIZE_0_1,
                    ),
                    splashColor: selectedColor.withOpacity(
                      Dimensions.SIZE_0_1,
                    ),
                    hoverColor: selectedColor.withOpacity(
                      Dimensions.SIZE_0_1,
                    ),
                    child: Padding(
                      padding: itemPadding -
                          (Directionality.of(context) == TextDirection.ltr
                              ? EdgeInsets.only(right: itemPadding.right * t)
                              : EdgeInsets.only(left: itemPadding.left * t)),
                      child: Row(
                        children: [
                          IconTheme(
                            data: IconThemeData(
                              color: Color.lerp(
                                unselectedColor,
                                selectedColor,
                                t,
                              ),
                              size: Dimensions.SIZE_24,
                            ),
                            child: items.indexOf(item) == currentIndex
                                ? item.activeIcon ?? item.icon
                                : item.icon,
                          ),
                          ClipRect(
                            clipBehavior: Clip.antiAlias,
                            child: SizedBox(
                              height: Dimensions.SIZE_20,
                              child: Align(
                                alignment: const Alignment(
                                  Dimensions.SIZE_0_2,
                                  Dimensions.SIZE_0,
                                ),
                                widthFactor: t,
                                child: Padding(
                                  padding: Directionality.of(context) ==
                                          TextDirection.ltr
                                      ? EdgeInsets.only(
                                          left: itemPadding.left /
                                              Dimensions.SIZE_2,
                                          right: itemPadding.right)
                                      : EdgeInsets.only(
                                          left: itemPadding.left,
                                          right: itemPadding.right /
                                              Dimensions.SIZE_2,
                                        ),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      color: Color.lerp(
                                          selectedColor.withOpacity(
                                            Dimensions.SIZE_0,
                                          ),
                                          selectedColor,
                                          t),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    child: item.title,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class AppBarItem {
  final Widget icon;
  final Widget? activeIcon;
  final Widget title;
  final Color? selectedColor;
  final Color? unselectedColor;

  AppBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
  });
}