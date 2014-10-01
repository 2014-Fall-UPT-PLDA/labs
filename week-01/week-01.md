# Week 1 - September 23rd, 2014

A few suggestions on how to read through this text. You should read through everything linear, shallow fashion, at first; then re-start and follow the hyperlinks in the text. You can find most references enumerated at the bottom as well. Good luck, and have fun!  

## Getting started

I advise that everyone should install the [Haskell Platform](https://www.haskell.org/platform/) on their own computers. It comes with the Haskell interpreter `ghci`.  

After installation you can launch the interpreter with the command `ghci` from a terminal, this will start a REPL (read, evaluate, print loop). Then you can proceed to loading the `sets.hs` file simply by running `:l sets.hs` or `:l $PathToFile/sets.hs` within the REPL. This will compile the file and load any definitions we have in there. Then, you can test it out by running, for example: `:t singletonSet`.  If you edit a file that you have loaded you can reload it with the `:r` command.

## Haskell basics

Taken straight from the Haskell [introduction page](http://www.haskell.org/haskellwiki/Introduction): *"Haskell is a computer programming language. In particular, it is a polymorphically statically typed, lazy, purely functional language."*  

Now, we're covered the [purely functional](http://www.haskell.org/haskellwiki/Functional_programming) part, with the implementation of functional sets.  We delved a little bit into the [statically typed](http://www.haskell.org/haskellwiki/Typing) bit. And the rest is to follow.

### Basic types

Alright, now that you have a working interpreter up and running, go ahead and play around with the language. A very good resource to help you start out is [learnyouahaskell.com](http://learnyouahaskell.com/starting-out). This will cover basic types, and, it also goes into lists (which we haven't really talked about), we'll get into that next week!  
Also, go ahead and check out the next chapter about [types and typeclasses](http://learnyouahaskell.com/types-and-typeclasses) as well, since we already ran into them. Remember, `:t` or `:type` is your friend, it tells you the type of any arbitrarily complex expression.

### Functions as first-class citizens

The term of a [first-class citizen](http://en.wikipedia.org/wiki/First-class_citizen) is widely used in programming languages. Essentially it means that entities that are privy to this "high-society" club can be passed as parameters, stored in variables, etc.  

Now, most introductory material seems defer this topic of this section to the third or fourth installment. We've taken a different route, mostly because functions are *the most* important type of value in a language! Why? Because they can be used to express *everything* we can in modern programming languages. And yes, they could replace variables altogether. Think about this for a while, any local variable could be just as easily replaced with a function call that returns that value or a parameter. Of course, it's easier to structure programs if we use variables, but we don't *have* to.  Just mull over this for a while and we'll talk about it more next week.  

*_Important Note:_* When you see the `>` character in a block of code that means that we evaluate the subsequent expression in the Haskell interpreter, and the line beneath will represent the output of the interpreter. When you see larger chunks of code, specifically function definitions, those were put in a separate `.hs` file and loaded into the interpreter via the `:l` command.  

Back to more concrete examples. Take for instance the following Haskell example:
```Haskell
> mod 10 2
0
-- I can also write 2 argument function in-fix by enclosing it in backticks:
> 10 `mod` 3
1
```
Straight-forward, from the looks of it, `mod` is a simple function. Ok, but we can define the following:
```Haskell
modAlias = mod
```
What I do in the above expression is that I assign the value representing the `mod` function to a new "variable", `modAlias`. Now, if we interpret:
```Haskell
> modAlias 10 2
0
> 10 `modAlias` 3
1
```
Exactly the same results! Not very surprising, and this is just the most basic thing that higher-order procedures have to offer.

#### Anonymous (lambda) functions

The following segment of the lesson requires us to introduce the notion of an [*anonymous function*](http://www.haskell.org/haskellwiki/Anonymous_function). For instance:
```Haskell
> (\x -> x + 1) 2
3
```
What we have here is a long-winded way of me adding 1 and 2 together. What happens is that the expression `\x -> x + 1` creates a function with one parameter `x`, that, when evaluated, will add `1` to that `x`.

#### Closures

Now, the usefulness of anonymous functions is really evident once we introduce the notion of a [closure](http://www.haskell.org/haskellwiki/Closure). Basically, a closure is the state (all variable assignments, known symbols, etc.) of your program as it was *when the function was defined*. For instance, take the definition:
```Haskell
addN n = \x -> x + n 
--(addN 42) returns a function that we assign to the variable add42.
-- what happens here is that now, that anonymous function carries with it a *closure*
-- that has the information n=42
add42 = addN 42
--
> add42 1
43
```

We can also define:
```Haskell
add1 = addN 1
add2 = addN 2
--...
```

Notice how the behavior of that anonymous function depends on the parameter `n` in the `addN` function. Now, if we make an analogy to OOP:
  * the type of the lambda function `\x -> x + n` is the *class*: `Num a => a -> a`
  * `addN` is the *constructor*
  * `add42`, `add1`, `add2` are *instances* of the class (i.e. objects)
  * `n` is a *field* in each of these instances

Of course, this analogy ends here, and I'll let you think about the differences and implications of these differences until next week!  


#### Currying

Well, let's start with etymology: both the language *Haskell* and the the concept of *currying* are the namesake of [Haskell Curry](http://en.wikipedia.org/wiki/Haskell_Curry), a logician who put the basis of combinatorial logic (which we unknowingly use while we write Haskell programs).  

What about the meaning of currying? Well, we already made use of the concept when we discussed closures. Straight from [wikipedia](http://en.wikipedia.org/wiki/Currying): *"currying is the technique of translating the evaluation of a function that takes multiple arguments (or a tuple of arguments) into evaluating a sequence of functions, each with a single argument (partial application)"*.  

And if you look at the type signature of one of our `addN` function:
```Haskell
> :t addN
addN :: Num a => a -> a -> a
```
You will notice that even the notation that is used to denote types hints towards the fact that `addN` is this "sequence of functions, each with a single argument".

### Functional sets

This example was taken from the [Functional Programming Principles in Scala](https://www.coursera.org/course/progfun) class on `coursera.org`, which I highly recommend that you take!. You can find the implementation that we wrote during the lab in the [sets.hs](./sets.hs) file.

We will describe sets in terms of a characteristic function that we define as follows:
  * this function is enough to represent the notion of a set
  * it takes one parameter and returns `True` if the parameter is contained in the set, `False` otherwise

First, we start out with defining a "constructor" for our set datatype, similar to `addN`:
```Haskell
singletonSet :: (Integral a, Eq a) => a -> (a -> Bool)
singletonSet x = \y -> y == x

set1 = singletonSet 1
--
> set1 1
True
> set1 2
False
```

At this point, if you're having trouble understanding the types, you should probably go back to first part of this lab and read some of the references.  

Now, we need another function that can combine at least two sets, for that we define that standard `union` operator:
```Haskell
-- remember this? it was another layer of indirection, because we wanted to combine two sets more naturally in the
-- definition of the union function
or' :: (Integral a, Eq a) => (a -> Bool) -> (a -> Bool) -> (a -> Bool)
or' s1 s2 = \y -> (s1 y) || (s2 y)

union :: (Integral a, Eq a) => (a -> Bool) -> (a -> Bool) -> (a -> Bool)
union s1 s2 = s1 `or'` s2
```

I think that this implementation is quite nice and elegant, and doesn't really warrant much more explanation. But, if you are having trouble understanding it please don't hesitate to contact us.  

As you might notice, we didn't really make use of some other underlying data structure like an array, or a list, we didn't even use local variables! All the data we needed was represented by the functions themselves. I recommend that you read the section [What is meant by data?](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-14.html#%_sec_2.1.3) from [Structure And Interpretation of Computer Programs](https://mitpress.mit.edu/sicp/full-text/book/book.html), it illustrates this concept much more elegantly than I ever could.

To top everything off, let's look at the example your colleague [Andrei](https://github.com/andreiavramescu) suggested:
```Haskell
evenNumbersSet :: (Integral a, Eq a) => (a -> Bool)
evenNumbersSet = \y -> (y `mod` 2) == 0
```  

Compared to our `singletonSet`, and according to our description of a set, this set will contain _*all*_ even numbers, an infinity of values; and we didn't even use one local variable! Now that's something you should ponder.  

### Referential transparency and immutability

Recall the Java program we used as an example in class:
```Java
class Foo {
	public int value = 42

	public getValue() {
		return this.value;
	}

	public static void main(String[] args) {
		Foo x = factoryMethod()
		//... some code here
		println(x.value)
		println(x.getValue())
	}

	public Foo factoryMethod() {
		return new Foo();
	}
}
```
There are basically three ways in which, at the end of the program, you don't wind up with `42` being printed twice:
  * mutate the field `value`
  * reassign the parameter `x`
  * override the `factoryMethod()` to return an anonymous subtype of `Foo`

Now, although all these problems can be fixed, they require one thing: *the programmer being careful*. This, unfortunately, will inevitably fail from time to time.  

Haskell, in its purely functional form will not allow such things to happen in the first place! (Although we must account for some semantic differences, but we will get to that later). In a quasi-equivalent Haskell program, we will *always* know that 42 will be printed twice at the end. This discussion will continue over the course of the semester, but if you are eager to learn more then check out this article on [FP vs. OOP](http://www.haskell.org/haskellwiki/The_Monad.Reader/Issue3/Functional_Programming_vs_Object_Oriented_Programming).

### Final remarks

These functions that we wrote, that return other functions, and/or take them as parameters are referred to as [higer-order function](http://www.haskell.org/haskellwiki/Higher_order_function). Well, understanding this concept is the first step towards becoming a higher-order programmer (wow, this has to be the cheesiest thing I've ever said!).

## References:
* [Haskell Platform](https://www.haskell.org/platform/)

### Learning Haskell:
  * [learnyouahaskell.com - chapter 2 - starting out](http://learnyouahaskell.com/starting-out)
  * [learnyouahaskell.com - chapter 3 - types and typeclasses](http://learnyouahaskell.com/types-and-typeclasses)
  * [anonymous functions](http://www.haskell.org/haskellwiki/Anonymous_function)

### On functional programming
  * [What is meant by data?](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-14.html#%_sec_2.1.3)
  * [Structure And Interpretation of Computer Programs](https://mitpress.mit.edu/sicp/full-text/book/book.html)
  * [Functional Programming Principles in Scala](https://www.coursera.org/course/progfun)
  * [FP vs. OOP](http://www.haskell.org/haskellwiki/The_Monad.Reader/Issue3/Functional_Programming_vs_Object_Oriented_Programming)






