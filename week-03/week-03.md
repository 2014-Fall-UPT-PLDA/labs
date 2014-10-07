Week 03 - Octoboer 7th, 2014
=======
Remember that you can check out your first [homework assignment](../homework/01/homework-01.md). Remember that you can just browse through all the code in the github repository! It's organized in a straightforward manner.

Creating our own data-types
------------------------------------------------------------------------------

In Haskell we can use the `data` keyword to define our own data-types:

```Haskell
data List = Nil
          | Cons Integer List
          deriving (Show) -- we derive Show so that the interpreter can print the value of type list
```
Here we simply state that our datatype `List` is either `Nil`(a name of our choosing) or it is `Cons` that requires two other pieces of data: an `Integer`(predefined type), and a `List`(the datatype that we are defining)

You can instantiate values of type `List` in the interpreter:
```Haskell
> Nil
Nil
-- a list with one element
> Cons 42 Nil
Cons 42 Nil
-- a list with two elements
> Cons 42 (Cons 1 Nil)
Cons 42 (Cons 1 Nil)
--the build in show method that the compiler implements for user defined data-types tends to output values looking constructor calls.
```  

An Java analogue of this would look something like this:
```Java
package com.list.my

interface List {
  //any operations like `map`, `fold` would go here
}

class Nil implements List {
  //implement methods, no constructor needed.
}

class Cons implements List {
  private final int head;
  private final List tail;
  public Cons(int head, List tail){
    this.head = head;
    this.tail = tail;
  }
}

//similar to what we wrote in Haskell to create a List data-type,
//in Java it would look like:
final class Lists {
  public static List fortyTwo() {
    return new Cons(42, new Nil());
  }
}
//Wow, that sure is a lot of boilerplate code.
```

Type classes
------------------------------------------------------------------------------
Read more on type classes in [learnyouahaskell.com, chapter 3](http://learnyouahaskell.com/types-and-typeclasses) and [chapter 8](http://learnyouahaskell.com/making-our-own-types-and-typeclasses#typeclasses-102). Also, please take some time to mull over this article on [OOP vs.Type classes](http://www.haskell.org/haskellwiki/OOP_vs_type_classes).


Basics of interpretation
---------------------------------------
Recall that we defined a very simple [`abstract-syntax-tree (AST)`](http://en.wikipedia.org/wiki/Abstract_syntax_tree) like this:
```Haskell
data AST = 
     IntC Integer
     | Add AST AST -- 3 + 1; (1 + 2) + (1 + 2)
     | PP AST -- equivalent of C/Java ++ operator
     deriving (Show, Eq)
```

This very simple AST is the representation of a language that can support arbitrarily complex additions.  

Starting from the data, we then wrote a simple function that expressed the **_semantics_** of this language:

```Haskell
evaluate :: AST -> Integer 
evaluate ast = case ast of
  IntC n -> n
  Add ast1 ast2 -> (evaluate ast1) + (evaluate ast2)
  PP e -> (evaluate e) + 1 

-- We test this function using:
> evaluate (IntC 1)
1

> evaluate Add (IntC 2) (IntC 2)
4

--the $ sign is used to modify the order of evaluation of functions, just like parentheses do.
> evaluate PP $ Add (IntC 2) (IntC 2)
5
-- And now we can nest these "ad-infinitum" (within practical limits)
```  

More information in the description of [homework 01](../homework/01/homework-01.md)

Difference between Object Oriented decomposition and Functional decomposition
------------------------------------------------------------------------------


