# llvm-static-analysis

The program is a LLVM pass to staticly analyze a given llvm bitcode to generate control flow graph and call graph.

## Implementation

### Control Flow Graph

The program loops all the `BasicBlock` of a given `Function`. For each `BasicBlock`, the program gets its `TerminatorInstruction` which can provides the successors of the block. Then we know which successor `BasicBlock` are lead by the given block.

The program uses the same method to print all the possible execution paths, but instead of looping all `BasicBlock`, it only trace from the `entry`. It applys DFS (Depth First Search) to keep tracing all possible paths from the `entry` and uses an ordered set to store the blocks in the current path. When the program reaches the ending block which has no successor, it prints the current path. The program can detect a loop by finding a successor existing in the current path. It then prints the current path with the description of the loop and stop tracing with this successor.

Below are the sample outputs.

1. When the path reaches end
```
[entry] -> [if.end] -> [for.cond] -> [for.end]
```

2. When the path finds a loop
```
[for.cond] to [for.inc] is a loop
[entry] -> [if.end] -> [for.cond] -> [for.body] -> [for.inc]
```

### Call Graph

The program uses `llvm` `ModulePass` instead of `FunctionPass` to group the relationships of all the functions in a given module. It loops the functions and for each function, it loops its instructions. If it has an instruction calling another function,  we know the current function is the caller of the other one which is the calleee then.
