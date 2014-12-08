Scala
===========================================================

In these labs we looked at [Scala](http://www.scala-lang.org/).


Running the examples
-----------------------------------------------------------

The easiest way is to use the [Simple Build Tool](http://www.scala-sbt.org/). It's trivial to install and use. Crash course: `sbt` is a REPL, and if start it , it will load whatever build definitions can be found in any `.sbt` file in the current directory, and in the `project` subdirectory. If you run `sbt`, this will put you into a repl that takes `sbt` can execute a set of predefined tasks. Basic ones include `compile`, `run`, `test`, `clean`. If you do not wish to start the REPL then you can simply run `sbt taskName`, and sbt will execute the specified task and exit when it's done.  


Both projects have been configured so that when you run `sbt eclipse` in any of the folders it will create an [Scala IDE](http://scala-ide.org/download/milestone.html) project ready to be imported and run. Scala IDE is nothing but an eclipse plugin, so most of you should already be familiar with how to import a project.  



