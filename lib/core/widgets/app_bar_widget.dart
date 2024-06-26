import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    required this.appBarTitle,
    super.key,
  });

  final String appBarTitle;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final canPop = ModalRoute.of(context)?.canPop ?? false;

    return AppBar(
      leading: canPop
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: Text(
        appBarTitle,
        style: textTheme.headlineMedium,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }
}
