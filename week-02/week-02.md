# Week 2 - September 30th, 2014

As a reminder, don't forget that you can consult the Haskell [cheat-sheet](../haskell-cheat-sheet.md) for quick reminders about various things.

# Important!

Work hard, the learning curve for the class will become even more steep. Feel free to contact us with any questions.

### Lambda calculus

Recall that we implemented the `if` expression in terms of functions, following the tradition of lambda calculus. You can find the implementation in the [if-lambda.hs](./if-lambda.hs)  file.

### List combinators

Generally, you can find the `map`, `fold`, and `filter` operations in any functional language you look at! They are extraordinarily simple, yet they give quite a lot of expressive power. We've worked a bit with them, and I encourage you to work more by yourselves; this exercise isn't just limited to Haskell, when you sit down and write code in your language of choice try and think if whatever you are writing could be expressed in terms of these!  

Check out the reference re-implementation that we started this lab, found in the file [list-combinators.hs](./list-combinators.hs). We also introduced several different ways of implementing. Check out the [cheat-sheet](../haskell-cheat-sheet.md) mentioned previously.

### Laziness

We briefly discussed this, please read more about [lazy and strict functions](http://en.wikibooks.org/wiki/Haskell/Laziness#Lazy_and_strict_functions).

### Recursion

Take a look at the quasi-quicksort implementation in [recursion.hs](./recursion.hs).It's easier to read than pseudo-code! Also take a look as to why this isn't really a true [quicksort implementation](http://www.haskell.org/haskellwiki/Introduction#Quicksort_in_Haskell).

## Exercises

Ok, so there are plenty of things to read but nothing makes you understand things better than a hard work. Therefore, I propose that you do the following:
  * finish re-implementing `fold(r/l)`, `map`, `filter`; yes, yes. I know, I have already provided the implementations; do it anyway.
  * implement `merge-sort`

## Reading for week 3

Next week we will go into algebraic, recursive data-types. Using these we will lay the groundwork for the implementation of our first interpreter. Please do some independent study on [defining our own types](http://www.haskell.org/haskellwiki/Algebraic_data_type), and about [type-classes](http://learnyouahaskell.com/types-and-typeclasses).
