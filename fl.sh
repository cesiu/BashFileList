#!/bin/bash

# Represents a linked list using files as nodes.
# author: Christopher (cesiu)

# Gets the nth element in a linked list of files.
# $1 - the current node
# $2 - n
function get {
   current=$(tail -n 1 $1)
   rest=$(head -n 1 $1)
   let restlen=$2-1

   if [ "$2" -eq "0" ]; then
      echo "$current"
   else
      get $rest $restlen
   fi
}

# Adds an element to the head of the list.
# $1 - the element
function add {
   oldHead=$(head -n 1 head)
   let size=$(tail -n 1 head)+1

   printf "%s\n%s" $oldHead $1 > node$size
   printf "%s\n%s" node$size $size > head
}

# Prints out an entire linked list of files (non-nested)
# $1 - the current node
function printList {
   current=$(tail -n 1 $1)
   rest=$(head -n 1 $1)
   echo $current
  
   if [ "$rest" != "none" ]; then
      printList $rest
   fi
}

# Example usage:
cd demo

# Print the list.
head=$(head -n 1 head)
echo "Printing list..."
printList $head

# Add to the list.
echo "Adding foobar..."
add "foobar"

# Print the list.
head=$(head -n 1 head)
printList $head

# Get an element.
echo "Getting the element at index 1..."
get $head 1

# Reset the example.
rm node4
printf "node1\n3" > head
cd ..
