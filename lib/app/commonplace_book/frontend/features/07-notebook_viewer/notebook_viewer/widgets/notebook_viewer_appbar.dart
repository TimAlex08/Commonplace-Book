part of '../notebook_viewer_page.dart';



class NotebookViewerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NotebookViewerAppBar({
    super.key,
    required this.notebookName,
  });
  
  final String notebookName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(notebookName),
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.mainScreen,
              (route) => false,
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}