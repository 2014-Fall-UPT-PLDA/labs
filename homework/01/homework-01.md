Homework 01 - Functional Expression Language Interpreter
===============================================================================

Don't forget to check everything else within this repository as a reference. The [cheat-sheet](../../haskell-cheat-sheet.md) is always a good thing to use.  


Homework submission guidelines and due date
-------------------------------------------------------------
You should show either the TA, or the Instructor a working implementation of the interpreter by **__23:59 October 21st 2014__**. This can be done either in person or via e-mail. Although, preferably, it should be done in person.

The submission is deemed correct *_iff_* the unmodified version of [interpreter-tests.hs](./interpreter-tests.hs) compiles, and all test cases pass. This implies that you can modify the `interpreter.hs` file in any way you find necessary, as long as you can compile and run the tests without their modification.  

*_If you think that you found an error in the test cases, or in the definitions of the data-types please don't hesitate to notify us, so that we can correct them asap! Thank you._*


The task at hand
-------------------------------------------------------------

Your task is to implement an interpreter for the programming language who's structure is dictated by the abstract-syntax-tree listed bellow; and who's semantics are described by the test cases found in the [interpreter-tests.hs](./interpreter-tests.hs) file.

```Haskell
data Val = IntVal Integer
         | StringVal String
         | BooleanVal Bool
         -- since we are implementing a Functional language, functions are
         -- first class citizens.
         | FunVal [String] Expr Env
     deriving (Show, Eq)

data Expr = Const Val
          -- represents a variable
          | Var String
          -- integer multiplication
          | Expr :*: Expr 
          -- integer addition and string concatenation
          | Expr :+: Expr 
          -- equality test. Defined for all Val except FunVal
          | Expr :==: Expr 
          -- semantically equivalent to a Haskell `if`
          | If Expr Expr Expr
          -- binds a Var (the first `Expr`) to a value (the second `Expr`), 
          -- and makes that binding available in the third expression
          | Let Expr Expr Expr
          -- creates an anonymous function with an arbitrary number of parameters
          | Lambda [Expr] Expr 
          -- calls a function with an arbitrary number values for parameters
          | Apply Expr [Expr]
     deriving (Show, Eq)

data Env = EmptyEnv
         | ExtendEnv String Val
     deriving (Show, Eq)
```


As you can see we define three data-types:
  * `Expr` - during the lab we called it `AST`. But `Expr`(Expression) is a bit more appropriate given the semantics of the language
  * `Val` - the values that can be expressed in our language
  * `Env` (environment) - this is a glorified key-value pair list, that, when used properly takes care of the scoping properties of our language.  



More on the `Env` data-type
-------------------------------------------------------------

To learn more about environments consult [Essentials of Programming Languages, Friedman et. al](http://truly-free.org/ebook.php?book=Friedman%2C%20Wand%2C%20Haynes%20-%20Essentials%20of%20Programming%20Languages&list=a&nr=449&cat=n) downloadable from the provided link. Specifically look at section `3.2.3`, which in turns points to section `2.2`. Also, chapter 3 discusses the implementation of an extremely similar interpreter, but it's written in Scheme :). It shouldn't be too hard to figure out. All the source code from the book can also be found in this [github repo](https://github.com/mwand/eopl3).  



General Tips
-------------------------------------------------------------

You will need to evaluate expressions in the appropriate environment (that's why the `evaluate` function takes an `Env` as a parameter). When evaluating a function in environment `env` you must evaluate its argument(s) in `env` but evaluate the function body (specifically, its free variables) in the environment of the function definition (this is why `FunVal` contains an `Env` value). Essentially, you are implementing the concept of `closures`.


Testing
-------------------------------------------------------------

You should load the `interpreter-tests.hs` file directly into `ghci` instead of `interpreter.hs`. The tests depend on the interpreter, so both of them will be loaded anyway.  You can then proceed to evaluate the *no-arg* function `> testAll` to run all test cases. Or, you can run each individual test.  

The tests aren't written with any of the standard Haskell unit testing libraries because that would have required explicit installation of these modules in the lab, which, at this point is a total pain.  

The test cases aren't exaustive. You should write some of your own.


Other references
-------------------------------------------------------------

Taken straight from [last year's description](http://bigfoot.cs.upt.ro/~marius/curs/plda/2013/hw1.html):

The [PLAI book](http://cs.brown.edu/~sk/Publications/Books/ProgLangs/) has an in-depth discussion (sec. II-IV) of building an interpreter. Here's an example of [an SML interpreter](http://www.cs.cornell.edu/courses/cs312/2005sp/lectures/lec17.asp) (with more features) from a course at Cornell.
