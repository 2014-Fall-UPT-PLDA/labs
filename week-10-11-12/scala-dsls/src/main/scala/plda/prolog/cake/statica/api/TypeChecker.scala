package plda.prolog.cake.statica.api

import plda.prolog.cake.ast.api.AST

trait TypeChecker {
  def typeCheck(ast: AST): Boolean
}