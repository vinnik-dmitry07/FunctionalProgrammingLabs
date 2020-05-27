# FunсLogProgrammingLabs
## Lab1 "Lists" (Haskell, Prolog)
1. Find the minimum element and the position of all its entries in the list.
2. Calculate the statistics of the entries in the list.
## Lab2 "Lists (Additional tasks)" (Haskell)
Divide a given list into several lists, writing down in the first list values less than 1!, in the second - less than 2! but not on the previous list, in the third - less than 3! but did not get to the previous two lists, the fourth is less than 4! but not in the previous lists, etc.
## Lab2 "Lists (Additional tasks)" (Prolog)
Find all the "top peaks" of the list and their positions. A list item is an upper peak if it is larger than its existing neighbors. Consider that the list consists of different items. For example, in the list `[5, 4, 2, 8, 3, 1, 6, 9, 5]` the upper peaks and their positions are: `(5,1), (8,4), (9,8)`.
## Lab3 "Finite-state automata" (Haskell)
For given words v and w, determine if the finite state machine admits at least one word that can be represented as _vywy_ for some word _y_. If yes, give an example of the corresponding word _vywy_.
## Lab4 "Context-free grammars" (Haskell)
For each non-terminal A find:
```
minLengthR(A) = min{length (w) | A =>+ Aw, w is a word in the terminal alphabet}
```
and
```
wordsMinLenR(A) = {x | A =>* Ax, x is a word in the terminal alphabet, length(x) = minLengthR(A)}
```
## Lab5 "Expert systems" (SWI-Prolog)
Develop a simple expert system with more than 8 entities, generalizing terms, and properties that have multiple alternatives.
## Lab6 "Monads" (Haskell)
1) Program and test three unary Maybe-functions to calculate the given three formulas.
2) Using monad operations, program and test the Maybe-function to calculate the superposition of the above three functions:
    1. Submit the desired function using do-notation.
    2. (Optional). Submit the desired function without using do-notation.
3) (Optional). Program and test the binary Maybe-function to calculate the last of the three given formulas (here n is considered a real number).
4) (Optional). Using monad operations, program and test the Maybe-function to calculate such a superposition, when the above-mentioned binary function is replaced by the first function from point 1 instead of its first argument, and the second instead of the second argument:
    1. Submit the desired function using do-notation.
    2. Submit the desired function without using do-notation.
