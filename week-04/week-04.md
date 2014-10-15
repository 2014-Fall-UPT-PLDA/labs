Week 04 - Octoboer 14th, 2014
=======

Remember that you [first homework assignment](../homework/01/homework-01.md) is due in one week. In this lab we've covered some basics that you need in order to implement the interpreter for the FELI language.  

**_Please note that I have updated the source files for your homework since last week. Only improvements, I promise! I added some debugging capabilities and a bit more code to get you started._**   

I suggest you go and read your first assignment and browse through the code provided before continuing. Even better, keep the code from [Interpreter.hs](../homework/01/Interpreter.hs) and this description side by side.  


Basics of evaluation
--------
Let's start out by looking at the [`evaluate`](../homework/01/Interpreter.hs#L47) function from your homework:
```Haskell
evaluate:: Expr -> Env -> Val
```  

Now, what does the type signature tell us? Well, loosely, it gives tahe hint that _we are evaluating an expression, in the given environment, to a value._ So, whenever you call evaluate, you know that from an abstract representation of your program (i.e. addition, function application/call) you will get back an actual [value](../homework/01/Interpreter.hs#L5), as defined by us!.

### Common pitfalls:

Remember that our goal here is to define the semantics (i.e. meaning) of the language FELI, described with the use of the data-type `Expr`, in a _different_ language called Haskell.
  
  * always make sure you are clear in which language you are operating! For instance `:+:` is the addition of the FELI language, while `+` is a rough Haskell equivalent. Therefore, you cannot expect the operations: `(IntVal 42) + 42` or `(IntVal 42) :+: 42` to work! 
  * a corollary from the above is that `(IntVal 42)` and `42` are completely different. In order to achieve anything useful, you have to convert one to the other. For instance, you can convert the `IntVal 42` with the helper function [`valToInteger`](../homework/01/Interpreter.hs#L63) 
```haskell
valToInteger:: Val -> Integer
valToInteger (IntVal n) = n
valToInteger v = valError "IntVal" v
```
  * `Expr` and `Val` are data-types defined by us. We could have named them anything we wanted to!

### Back to business

The basic idea behind the implementation of the `evaluate` function is very simple:
  1. we take an `Expr` and an `Env`
  2. we do `pattern-matching` (refer to the haskell cheat-sheet), over the `Expr` and see how it looks like
  3. based on what it looks like, we do some computation.
  4. looking at the definition of the `Expr` data-type, we know that it comes in 9 shapes: `Const`, `Var`, `:*:`, `:+:`, `:==:`, `If`, `Let`, `Lambda`, `Apply`. Each with its own unique representation; `Const` is composed of a String, while `If` is composed of three other `Expr`.

Ok, so looking at the starting implementation:
```haskell
evaluate:: Expr -> Env -> Val
evaluate expr env = -- step 1, check
  trace("expr= " ++ (show expr) ++ "\n env= " ++ (show env)) $
  case expr of -- step 2, check
  Const v -> v -- step 3, part 1. If we have a `Const`, then we just return its value.
  lhs :+: rhs -> -- step 3, part2. If we have `:+`:, then we do more complicated things
    let valLhs = evaluate lhs env
        valRhs = evaluate rhs env
    in (IntVal $ (valToInteger valRhs) + (valToInteger valLhs))
  -- step 4, in progress...
  _ -> error $ "unimplemented expression: " ++ (show expr)
```

If you are having trouble understanding the _*syntax*_, then please refer to the Haskell [cheat-sheet](../haskell-cheat-sheet.md) or [google](www.google.com). If you are having trouble understanding the meaning of the function, don't fret, I'm going to explain it now :).  

Q: What does this `lhs :+: rhs` do?  
A: Well, look at the definition of the `:+:` data-type: `Expr :+: Expr`. The "plus", is composed of two expressions. The pattern `lhs :+: rhs`, binds those to expressions to the variables `lhs`(left-hand-side) and `rhs`(right-hand-side) respectively. So, if the plus would be something like: `(Const (IntVal 1)) :+: (Const (IntVal 2))`, then `lhs = (Const (IntVal 1))` and `rhs = (Const (IntVal 2))`.  

Q: What about `valLhs = evaluate lhs env`?  
A: Remember when I said earlier that in evaluate "_we are evaluating an expression, in the given environment, to a value."_? Well, that is what we are doing, in order to actually do some computation, we need to get hold of a `Val` from the `Expr` in `lhs`. The easiest way to do that is to call `evaluate`!
Then, once we have the `Val`, which are values in the FELI language, we convert those to `Integer` which are values in the Haskell language so that we can add them together, then we convert the resulting Haskell value back into a FELI `Val`. All this done in here: (IntVal $ (valToInteger valRhs) + (valToInteger valLhs))






