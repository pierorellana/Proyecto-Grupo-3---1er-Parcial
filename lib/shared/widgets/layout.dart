import 'package:ecommerce/shared/widgets/alert_modal.dart';
import 'package:ecommerce/shared/widgets/badge_cart_widget.dart';
import 'package:flutter/material.dart';

import '../../env/theme/app_theme.dart';
import 'drawer_widget.dart';

class LayoutWidget extends StatefulWidget {
  const LayoutWidget({super.key, required this.child, required this.onRefresh});
  final Widget child;
  final Future<void> Function() onRefresh;

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      backgroundColor: AppTheme.blueGrey,
      body: Stack(
        children: [
          RefreshIndicator(
            backgroundColor: AppTheme.white,
            color: AppTheme.blueDark,
            onRefresh: () => widget.onRefresh(),
            child: CustomScrollView(
              //shrinkWrap : true,
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  actions: const [BadgeCartWidget()],
                  backgroundColor: AppTheme.blueGrey,
                  title: const Text('Ecommerce'),
                  leading: Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.sort),
                      onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                    ),
                  ),
                ),
                WillPopScope(
                  onWillPop: () async {
                    // if (Navigator.of(context).canPop()) {
                    //   Navigator.of(context).pop();
                    //   return false;
                    // }
                    return false;
                  },
                  child: SliverToBoxAdapter(
                    child: widget.child,
                  ),
                )
              ],
            ),
          ),
          const AlertModal()
        ],
      ),
    );
  }
}
