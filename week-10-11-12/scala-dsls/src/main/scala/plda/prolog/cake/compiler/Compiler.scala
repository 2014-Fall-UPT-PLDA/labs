package plda.prolog.cake.compiler

import plda.prolog.cake.statica.api.TypeChecker
import plda.prolog.cake.ast.api.ParserIngedient
import plda.prolog.cake.statica.api.TypeCheckerIngredient
import plda.prolog.cake.codegeneration.api.CodeGeneratorIngredient

class Compiler extends ParserIngedient
  with TypeCheckerIngredient
  with CodeGeneratorIngredient {
  
  def config = {
      println("")    
		  Map("" -> "") 
  }
  
}