package plda.prolog.disjoint

/**
 * Here we an example when syntax is defined completely independently of the data.
 */
case class Predicate(name: String, value: String)
case class Rule(head: Predicate, body: Seq[Predicate])

class DisjointSyntaxAndData {
  import PrologSyntax._

  def testPredicate() = {
    "wearsSuits" -> ("bunk")
  }

  def testRule() = {
    val head = "suitandTieMotherfucker" -> ("bunk")
    val body1 = "wearsSuits" -> ("bunk")
    val body2 = "wearsTies" -> ("bunk")
    head :- (body1 && body2 && body2)
  }
}

object PrologSyntax {
  implicit class RichPrologString(constString: String) {
    def ->(constant: String): Predicate =
      Predicate(constString, constant)
  }

  implicit class RichSeqPred(seq: Seq[Predicate]) {
    def &&(p: Predicate): Seq[Predicate] = ???
  }

  implicit class RichPredicate(p: Predicate) {
    def :-(body: Seq[Predicate]) = Rule(p, body)
    def &&(that: Predicate): Seq[Predicate] = Seq(p, that)
  }

  implicit def predToSeq(p: Predicate): Seq[Predicate] = Seq(p)
}