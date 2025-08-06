part of '../notebook_viewer_page.dart';



// ---------- NotebookViewerDrawer ---------- //
class NotebookViewerDrawer extends StatelessWidget {
  const NotebookViewerDrawer({super.key, required this.notebook});
  final NotebookUiModel notebook;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[300],
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TreeView(
                notebook: notebook,
              )
            )
          ],
        )
      ),
    );
  }
}
