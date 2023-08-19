
import 'package:supabase/supabase.dart';

class SupabaseCredentials{
  static const String APIKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRqZGZuenJudGlxaml0aWl0ZWRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTA0ODYwNDYsImV4cCI6MjAwNjA2MjA0Nn0.MCG56xF7wUj_IoJUqxxiEsnrWXd1LqlKTFo8IQ4LtEM";
  static const String APIurl = "https://tjdfnzrntiqjitiitede.supabase.co";

  static SupabaseClient supabaseClient = SupabaseClient(APIurl, APIKey);

}