######The Backstory######
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



######Use######
Really, you want to use this?

`./fl.sh` will run some example operations using the files included in the demo
folder. BashFileList has functions for getting an element at an index, adding
and removing from the head of the list, and printing the list. BashFileLists
can be nested by using the name of a file as the element of a node, though 
you'll have to make multiple function calls to access the nested lists; none of 
the functions will recursively traverse them.

`# Example usage:
cd demo

# Print the list.
node1=$(head -n 1 list1)
echo "Printing list..."
printList $node1

# Add to the list.
printf "\nAdding hello...\n"
add "list1" "hello"

# Print the list.
node1=$(head -n 1 list1)
printList $node1

# Add to the list.
printf "\nAdding world...\n"
add "list1" "world"

# Print the list.
node1=$(head -n 1 list1)
printList $node1

# Get an element.
printf "\nGetting the element at index 1...\n"
get $node1 1

# Remove from the list.
printf "\nRemoved %s...\n" $(remove "list1")

# Print the list.
node1=$(head -n 1 list1)
printList $node1

# Reset the example.
rm node4
printf "node1\n3" > list1
cd ..`
