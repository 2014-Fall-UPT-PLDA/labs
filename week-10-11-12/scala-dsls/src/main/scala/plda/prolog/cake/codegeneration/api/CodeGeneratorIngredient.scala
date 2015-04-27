package plda.prolog.cake.codegeneration.api

import plda.prolog.cake.codegeneration.impl.CodeGenerationImpl

trait CodeGeneratorIngredient {
  lazy val codeGenerator: CodeGenerator = new CodeGenerationImpl()
}