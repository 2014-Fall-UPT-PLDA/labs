package plda.prolog.cake.ast.api

import plda.prolog.cake.ast.impl.ParserImpl
import plda.prolog.cake.ast.impl.SymbolTable

trait ParserIngedient {
  private lazy val symbolTable = new SymbolTable

  def config: Map[String, String]

  lazy val parser: Parser = new ParserImpl(symbolTable, config)
}