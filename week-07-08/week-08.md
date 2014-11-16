# Week 8 - November 11th, 2014

We talked about how to implement an interpreter. It all boils down to essentially 3 things.

### Define your types as data.

We created the following algebraic data type:  
```haskell
data Type = IntT
          | StrT
          | BoolT
          | ConstT Type
          | FunT Type Type
          | TypeVar String
      deriving (Show, Eq)
```

It's fairly straightforward, but the more important types are the "arrow-type" (i.e. function type) `FunT Type Type`. At first we'll treat only one argument functions, later on you'll have to extend the language to support multi-argument functions.  

And then we have `TypeVar String`. This is a placeholder for (yet) unknown types, which will be determined as we go infer the types of the entire expression tree, and for [generic types](https://github.com/2014-Fall-UPT-PLDA/labs/blob/master/homework/02/homework-02.md#hints).

### Write the unification of substitutions

The way the inference will work is that we traverse the `Expr` tree in roughly the same way as we did for homework 1, and for each type of expression we describe its type constraints in the form of type-equations, referred to as `substitutions`.  

Now, this might sound a bit abstract but it's actually quite simple. Take for instance the identity function expressed in our language:  
```Haskell
-- equivalent to \x -> x
Lambda "x" (Var "x")
```

The type constraint for *any* lambda, is:  
* `"x"` (the parameter) has generic type `TypeVar "t1"`  
* `(Var "x")` has generic type `TypeVar "t2"`  
* the expression as a whole has type `FunType (TypeVar "t1") (TypeVar "t2")`  

Because a lambda is a composite expression (i.e. its "body" is also an expression), we can further refine the function type.  Therefore, we go and recursively try to infer the type of the body, `(Var "x")`.  

The type constraint for *any* variable (not to be confused with a type-variable) expression would then be:
* it is either an unknown type `TypeVar "uniqueName"`
* or, it has already been infered and its type is present in a `type environment`, analogous to the `environment` we used in homework 1.  

Now, that we've figured out the general type constraints for the two expressions it is time to put these two type constraint together. Now, since we know that the lambda expression has type `FunType (TypeVar "t1") (TypeVar "t2")` and that the body of the lambda, represented as `(TypeVar "t2")` should also be equal to `TypeVar "uniqueName"`, the process of unification yields essentially the same thing. A function type from a generic type, to an unknown type.  

#### Guide to implementing the above:

I suggest you model your equations as a [`Data.Map`](https://www.haskell.org/ghc/docs/latest/html/libraries/containers/Data-Map.html), where the keys are type variables (`String`), and the values are either `Type` or some intermediary form of your choosing.  

Then you have to implement a function called `unify` with *roughly* the following signature (modify as needed):  

```Haskell
-- this is a type alias, everywhere, within this module, where
-- we could have to use (Map String Type) we can just use Substitution
type Substitution = Map String Type

unify:: Type -> Type -> Substitution -> (Type, Substitution)
unify toReplace replacee substs = undefined
```

Where `subts` represents your your type equations. `unify`'s semantics can be informally described as being a function that takes two types and simplifies them, by saying that the two types it takes as parameters should be equal. The return value is a tuple consisting of the new, unified type, and your new, simplified, equations (depending on how you implement everything you might not need to return a tuple, just the new Substitution). 

The implementation of `unify` has to take into account the fact that there are, essentially, three major categories of types: the constant types (`IntT`, `BoolT`, `StringT`), the function-type (`FunT Type Type`) and the type variable (`TypeVar String`). So it will look something like this:

```Haskell
unify:: Type -> Type -> Map String Type -> (Type, Map String Type)
unify toReplace replacee substs =
  case (toReplace, replacee) of
    -- when you try to unify two constant types
    -- if they are equal, then you return that 
    -- type. Otherwise, it's an error.
    (ConstT t1, ConstT t2) -> undefined

    -- when you try to unify two type variables
    -- you simply go through your substitutions
    -- and replace all occurrences of `toReplace`
    -- with `replacee`
    (TypeVar x, TypeVar y) -> undefined
    
    -- if you try to unify with a constant type, I wrote only IntT
    -- for brevity. You have to treat all cases.
    -- if variable x is previously marked as being something else,
    -- then that's an error. Otherwise, you go ahead and replace 
    -- all occurrences of `toReplace` with `IntT`
    (TypeVar x, IntT) -> undefined

    -- when you try to unify a type variable with some arbitrarily
    -- complex type  then you first have to do the `occurs` check.
    -- if all is good, you return a new set of substitutions and the
    -- type variable
    (TypeVar x, t) -> undefined

    -- When you try to unify two arbitrarily complex types, 
    -- well, this is for you to figure out.  
    (t1, t2) -> undefined

```

### Last, write the type inference function.

We have a function `infer` (modify signature as needed):
```Haskell
-- again, a type alias for convenience.
type TypeEnvironment = Map String Type

infer:: Expr -> TypeEnvironment -> Substitution -> Type
infer expr tenv subst = undefined
```

In the lab we gave a rough outline of the implementation
```
infer expr tenv subst =
  case expr of
    Const v -> case v of
                  IntVal _ -> ConstT IntT
                  StringVal -> ConstT StrT
                  BoolT -> ConstT BoolT
    Apply lambda param -> 
      -- what's written in the comments is *roughly* what should
      -- happen, as it's written now it won't even compile.
      let typeOfLambda = undefined -- infer lambda subst
          typeOfParameter = undefined --infer param subst
      in undefined -- unify typeOfLambda typeOfParameter
```

The process is fairly straightforward. You let the recursive function deal with composite expressions like `Apply`, and then you simply unify the results.  


### Other things

You will have to generate new type variables. This can be done by either using the `State` monad, or you just add an extra `Int` parameter  to your infer function to act as a counter for type variables.  

*_Please write many helper functions. Don't cram all the logic into one place._* For instance, you can write a function `freshTypeVariable` that gives you a new type variable, and so on.



