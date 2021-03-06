### The Backstory ###
For a programming languages class, we had been developing an interpreter for a
custom parenthesized language. For one assignment, we were randomly assigned a
different language, typically completely different from our normal host
language, and told to rewrite as much of our interpreters as we could in that
new language. The idea being that we'd struggle or fail, thereby demonstrating
how some languages are better suited as hosts than others. I was assigned bash.
The problem: bash only has one data structure, one-dimensional associative
arrays. The solution?



**BashFileList** leverages bash's file system manipulation powers to create a
linked list out of _files_, where each file is a node, and the first line in
each file is the name of the file representing the next node. This project is
an expansion of the simple print and get functions I initially needed.



### Use ###
`./fl.sh` will run some example operations using the files included in the demo
folder. BashFileList has functions for getting an element at an index, adding
and removing from the head of the list, adding and removing from an index, 
getting the (name of the) node at an index, and printing the list. 
BashFileLists can be nested by using the name of a file as the element of a 
node, though you'll have to make multiple function calls to access the nested 
lists; none of the functions will recursively traverse them.

```
# Print the list.
printList $(head -n 1 list1)

# Get an element at index 1.
get $(head -n 1 list1) 1

# Get the name of the node at index 1.
getNode "list1" 1

# Add to the beginning of the list.
add "list1" "hello"

# Add '327' at index 2.
addAtIdx "list1" 2 327

# Remove from beginning of the list.
remove "list1"

# Remove from index 1.
removeAtIdx "list1" 1
```
