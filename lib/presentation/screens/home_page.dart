import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas_riverpod/business/providers/authentication/auth_provider.dart';
import 'package:notas_riverpod/business/providers/note_provider.dart';
import 'package:notas_riverpod/presentation/widgets/custom_card.dart';

class HomePage extends ConsumerWidget {
  final String? email;
  const HomePage({super.key, this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido a homepage $email"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).signOut(),
          ),
        ],
      ),
      body: notesAsync.when(
        data:
            (notes) => ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return CustomCard(
                  title: note.title,
                  content: note.content,
                  date: note.lastEdited.toString(),
                  onDeleteNote: () {
                    ref.read(noteStateProvider.notifier).deleteNote(note.id);
                  },
                );
              },
            ),
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
