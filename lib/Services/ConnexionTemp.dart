class Connexiontemp {

  static final Map<String, String> logs = {
    "cariste" : "conduit",
    "cariste2": "conduit2"
  };

  static bool checkLogs(String login, String mdp){
    bool res = false;
    logs.forEach((key, value) {
      if (login == key && mdp == value){
        res = true;
        return;
      }
    });
    return res;
  }

  static bool checkLogin(String login){
    bool res = false;
    logs.forEach((key, value){
      if (login == key){
        res = true;
        return;
      }
    });
    return res;
  }

  static bool checkPassword(String pwd){
    bool res = false;
    logs.forEach((key, value){
      if (pwd == value){
        res = true;
        return;
      }
    });
    return res;
  }

}