package plda.prolog.cake.statica.api

import plda.prolog.cake.statica.impl.TypeCheckerImpl

trait TypeCheckerIngredient {
  lazy val typeChecker: TypeChecker = new TypeCheckerImpl
}