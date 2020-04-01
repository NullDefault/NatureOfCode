class Rule{
  char a;
  String b;
  
  Rule(char pre, String suc){
    a = pre;
    b = suc;
  }
  
  char getA(){
    return a;
  }
  String getB(){
    return b;
  }
}
