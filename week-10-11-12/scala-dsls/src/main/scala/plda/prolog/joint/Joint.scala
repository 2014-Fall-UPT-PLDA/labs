package plda.prolog.joint

/**
 * This is an example of when syntax for constructing objects is "shipped"
 * together with our data, i.e. as methods of the class Predicate
 */

case class Predicate(name: String, value: String) {
  def :-(body: Seq[Predicate]) = Rule(this, body)
  def &&(that: Predicate): Seq[Predicate] = Seq(this, that)
}

case class Rule(head: Predicate, body: Seq[Predicate])

object PrologSyntax {
  implicit class RichPrologString(constString: String) {
    def ->(constant: String): Predicate =
      Predicate(constString, constant)
  }
}

class WhenTheSyntaxIsDefinedTogetherWithTheClass {
  import PrologSyntax._

  val head = "suitAndTieMotherfucker" -> ("bunk")
  val body1 = "wearsSuits" -> ("bunk")
  val body2 = "wearsTies" -> ("bunk")
  head :- (body1 && body2)

}