package plda.prolog.cake

trait ClosingTrait {
  val answerToLife: Int
  def close(): Unit
}

trait ClosingTrait2 {
  val answerToLife: Int
  def close(): Unit
}

trait UsesA {
  def a(): Int = 42

  def c() = a()
}

class A {
  def a(): Int = 42
}
class B extends A {
//  override def a() = 42
  def b() = super.a()
}

class CanClose {
  def close(): Unit = {}
  val answerToLife = 42
}

object Test {
  def closeSomething(c: ClosingTrait): Unit = {
    c.close()
  }

  val temp = new CanClose() with ClosingTrait with ClosingTrait2
//  val a = new B() with UsesA
  closeSomething(temp)
}