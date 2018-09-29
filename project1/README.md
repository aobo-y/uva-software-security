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

#### 5. Log Memories

For each of the logged instructions, with the help of Pin API (`INS_MemoryOperandCount`, `INS_MemoryOperandIsRead` and `INS_MemoryOperandIsWritten`), the tool checks if the instruction need to access any memories and if it does, check its operation type: read/write. Then through `INS_InsertCall` it inserts three kinds of callback for Instructions with different memory requirements, which are read memory, write memory and no memory. These callback functions records the order index of the executing instruction, and the memory address and size if any.

#### 6. Output Logs

The tool adopts a key-value map to store all the information mentioned above. The key is the unqiue instruction address. The value is the log message which consists of the address, instruction name, register operations, and the details of the memory access of each time the instruction is executed. The details of the memory access of each execution keep being appended to the original message.

After the target program ends, the tool will sort the log by its instruction address in ascending order so that the output aligns with how the instructions are stored in memory in reality. Then it prints the messages following this order.
