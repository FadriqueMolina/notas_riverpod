import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas_riverpod/business/models/note_model.dart';
import 'package:notas_riverpod/business/providers/authentication/supabase_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final notesListProvider = StreamProvider<List<Note>>((ref) {
  final supabase = ref.watch(supabaseProvider);
  final user = supabase.auth.currentUser;
  if (user == null) return const Stream.empty();

  return supabase
      .from("notes")
      .stream(primaryKey: ["id"])
      .eq("user_id", user.id)
      .order('last_edited', ascending: false)
      .map((data) => data.map(Note.fromJson).toList());
});

final noteStateProvider = StateNotifierProvider<NoteProvider, AsyncValue<void>>(
  (ref) => NoteProvider(ref.read(supabaseProvider)),
);

class NoteProvider extends StateNotifier<AsyncValue<void>> {
  final SupabaseClient supabase;
  NoteProvider(this.supabase) : super(const AsyncValue.data(null));

  Future<void> _mutateNotes(Future<void> Function() operation) async {
    state = const AsyncValue.loading();
    User? user = supabase.auth.currentUser;
    if (user == null) {
      throw Exception("Usuario no autenticado");
    }
    try {
      await operation();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> addNote(Note noteToAdd) => _mutateNotes(() async {
    await supabase.from("notes").insert(noteToAdd.toJson());
  });

  Future<void> deleteNote(String id) => _mutateNotes(() async {
    await supabase.from("notes").delete().eq("id", id);
  });
}
