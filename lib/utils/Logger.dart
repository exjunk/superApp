
class Logger{
  static const bool IS_LOGS_ENABLED = true;
  static printLogs(dynamic logs){
    if(IS_LOGS_ENABLED) {
      print(logs);
    }
  }
}