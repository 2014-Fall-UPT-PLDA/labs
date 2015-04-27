package plda.prolog.cake.ast.impl

import plda.prolog.cake.ast.api.Parser
import plda.prolog.cake.ast.api.AST

private[ast] class SymbolTable() {}
private[ast] class ParserImpl(s: SymbolTable, c: Map[String, String]) extends Parser {
  def parse(text: String): AST = {
    ???
  }
}