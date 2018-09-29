# A Pin Tool for Memory Tracing

This Pin tool can instrument the main image by dynamically tracing every executing instruction and the corresponding registers and memory access.

## Code

The source code of this Pin plugin is all in `project1.cpp`.

### How it works

#### 1. Detect Main Image

The tool instruments all Images at first with a callback function, which checks if the current Image is the Main Executable. If it is, the tool will record the High and Low boundaries of this image. Meanwhile, also marks the flag to indicate the Main has been loaded. Otherwise, the image will be ignored.

#### 2. Detect Instructions within Main

The tool instrument every Instruction with a callback function to check if it is Main Instruction. It verifies the Main Loaded flag from the above step at first. The Instructions executed before the Main Loaded are ignored. Secondly, it checks if the address of the the current instruction (`INS_Address`) is within the Main boundaries. It ignores the unqualified instructions.

#### 3. Log Instructions & Registers

For each of the above qualified instructions, the tool uses Pin API `INS_Mnemonic` to get its meaningful name. This name and the address are logged at first.

Then is uses `INS_MaxNumRRegs`, `INS_MaxNumWRegs` and `INS_RegR` to separately get which Read and Write registers it will access. Then through `REG_StringShort`, it logs the registers' name respectively. Furthermore, it also conducts an additional check for the floating register and logs the this information as well.

(However, I found some instruction will be instrumented more than once, so need to avoid overwrite or duplicate log here, but the following call needs re-insertion)

#### 4. Log Execution & Memories

For each of the logged instructions, with the help of Pin API (`INS_MemoryOperandCount`, `INS_MemoryOperandIsRead` and `INS_MemoryOperandIsWritten`), the tool checks if the instruction need to access any memories and if it does, check its operation type: read/write. Then through `INS_InsertCall` it inserts three kinds of callback for Instructions with different memory requirements, which are read memory, write memory and no memory. These callback functions records the order index of the executing instruction, and the memory address and size if any.

#### 5. Output Logs

The tool adopts a key-value map to store all the information mentioned above. The key is the unqiue instruction address. The value is the log message which consists of the address, instruction name, register operations, and the details of the memory access of each time the instruction is executed. The details of the memory access of each execution keep being appended to the original message.

After the target program ends, the tool will sort the log by its instruction address in ascending order so that the output aligns with how the instructions are stored in memory in reality. Then it prints the messages following this order.


### Results

The output logs are grouped by instructions and ordered by instruction address in ascending order, not the order of being instrumented. Reading the instruction address order grant the convenience to refer the source code. Below is a sample snippet
```
10ddc8cd0 MOV -w-> al
10ddc8cdb MOVZX -r-> dl -w-> edi
        [14]  no mem access
10ddc8cde MOV -r-> rbp edi
        [15]  -w-> 7ffee1e374f8 <4>
10ddc8ce4 MOV -r-> rbp
        [16]  -w-> 7ffee1e374f4 <4>
10ddc8cee CMP -r-> rbp -w-> rflags
        [17]  -r-> 7ffee1e374f4 <4>
        [40]  -r-> 7ffee1e374f4 <4>
```
Each instruction is in the format of
```
{address} {name} -{read}-> {register}... -{write}-> {registers}...
```
An instruction can read or write multiple registers. They are grouped by the symbol `-r->` and `-w->`. Since the logs has been grouped by instructions, each instruction only appears once. However, existing such record does not mean it must has been executed. It only means the instruction is been loaded into memory and been instrumented by Pin, such as `10ddc8cd0` in the example.

Execution logs has two formats. If the instruction need to access memory, the format is
```
        [{order index}] -{read/write}-> {memory address} <{size}>
```
If it has no memory access, the format is
```
        [{order index}] no mem access
```
These detailed execution logs are appended to the instruction logs in new line with obvious indentation. The `order index` is an increasing integer to track the order of the execution so that we can easily follow jumps and notice loops like `10ddc8cee`.
