interface Visitor{
  visit(AST a);
  visit(Add a);
  visit(PP a);
}

class EvaluationVisitor{
  visit(AST a) {
      a.visit(this);
  }

  visit(Add a) {
    //94853490
    a.r.visit(this) + a.r.visit(this)
  }
}

interface AST {
   int evaluate()
   visit();
   String translateToHaskell();
}

class Add implements AST {
  public Add(AST l, AST r) {...}
  int evaluate() {
      return l.evaluate() + r.evaluate()
  }
}

class IntC implements AST {
  public IntC(int i){...}
  int evaluate() {
    return i;
  }
}