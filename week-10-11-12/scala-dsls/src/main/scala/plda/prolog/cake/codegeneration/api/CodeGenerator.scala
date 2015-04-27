package plda.prolog.cake.codegeneration.api

import plda.prolog.cake.ast.api.AST

trait CodeGenerator {
  def generateCode(a: AST): String
}