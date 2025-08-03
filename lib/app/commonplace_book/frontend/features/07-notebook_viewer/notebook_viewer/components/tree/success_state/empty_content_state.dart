part of 'package:commonplace_book/app/commonplace_book/frontend/features/07-notebook_viewer/notebook_viewer/components/tree/tree_view.dart';



// ---------- Estado de contenido vacio ---------- //
class _EmptyContentState extends StatelessWidget {
  const _EmptyContentState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No hay contenido en esta libreta',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}