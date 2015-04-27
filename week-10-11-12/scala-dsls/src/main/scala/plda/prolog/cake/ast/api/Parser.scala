package plda.prolog.cake.ast.api

trait Parser {
  def parse(text: String): AST
}