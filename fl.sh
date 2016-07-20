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
# $1 - the head of the list to add to
# $2 - the element to add
function add {
   oldHead=$(head -n 1 $1)
   let size=$(tail -n 1 $1)+1 

   printf "%s\n%s" $oldHead $2 > node$size
   printf "%s\n%s" node$size $size > $1
}

# Removes an element from the head of the list.
# $1 - the head of the list to add to
function remove {
   oldHead=$(head -n 1 $1)
   oldVal=$(tail -n 1 $oldHead)
   let size=$(tail -n 1 $1)-1
   newHead=$(head -n 1 $oldHead)
   
   printf "%s\n%s" $newHead $size > $1
   rm $oldHead
   echo $oldVal
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
cd ..
