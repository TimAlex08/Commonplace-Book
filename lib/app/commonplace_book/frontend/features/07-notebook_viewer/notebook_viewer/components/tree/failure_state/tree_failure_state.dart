part of '../tree_view.dart';



class _TreeFailureState extends StatelessWidget {
  const _TreeFailureState({
    required this.state,
    required this.notebookId,
  });

  final StructureState state;
  final String notebookId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
          const SizedBox(height: 16),
          
          Text(
            state.userMessage?.message ?? 'Error al cargar la estructura',
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          ElevatedButton(
            onPressed: () {
              context.read<StructureBloc>().add(LoadNotebookStructure(notebookId),);
            },
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}