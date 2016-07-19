#!/bin/bash

# Represents a linked list using files as nodes.
# author: Christopher (cesiu)

# Gets the nth thing in a linked list of files.
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

# Prints out an entire linked list of files (non-nested)
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
printList "node1"
cd ..
