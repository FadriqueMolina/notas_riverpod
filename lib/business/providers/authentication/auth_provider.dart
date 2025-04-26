import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notas_riverpod/business/providers/authentication/supabase_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthNotificer extends StateNotifier<AsyncValue<void>> {
  final SupabaseClient supabase;
  AuthNotificer(this.supabase) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await supabase.auth.signUp(email: email, password: password);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await supabase.auth.signOut();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotificer, AsyncValue<void>>(
  (ref) => AuthNotificer(ref.read(supabaseProvider)),
);

final currentUserProvider = StreamProvider<User?>((ref) {
  return ref
      .watch(supabaseProvider)
      .auth
      .onAuthStateChange
      .map((event) => event.session?.user);
});
