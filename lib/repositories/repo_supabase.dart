import 'package:supabase/supabase.dart';

class RepoSupabase {
  SupabaseClient getClient() {
    // const supabaseUrl = 'https://apgympehmiyuzhosrpeu.supabase.co';
    // const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoic2VydmljZV9yb2xlIiwiaWF0IjoxNjI5OTIxNTU2LCJleHAiOjE5NDU0OTc1NTZ9._1E8_wvxmGPWsx5sWR_q1tt3d9xGMgx3Qif00WRUc1Q';

    const supabaseUrl = 'https://dnudtbqukjycetwktbvf.supabase.co';
    const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoic2VydmljZV9yb2xlIiwiaWF0IjoxNjQxNTU3Njg1LCJleHAiOjE5NTcxMzM2ODV9.pRsVH6a3OSFMdjqbp4K2-76kqCBd6QQatv2GUtUoB4U';
    return SupabaseClient(supabaseUrl, supabaseKey);
  }
}
