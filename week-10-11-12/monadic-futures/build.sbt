name := "Monadic future examples"

scalaVersion := "2.11.4"

libraryDependencies += "org.scalatest" % "scalatest_2.11" % "2.2.1" % "test" withSources()

libraryDependencies +=
  "com.typesafe.akka" %% "akka-actor" % "2.3.7" withSources()

EclipseKeys.createSrc := EclipseCreateSrc.Default + EclipseCreateSrc.Resource

EclipseKeys.withSource := true

EclipseKeys.useProjectId := true