
/*! @file
 *  This is an example of the PIN tool that demonstrates some basic PIN APIs
 *  and could serve as the starting point for developing your first PIN tool
 */

#include "pin.H"
#include <iostream>
#include <fstream>

/* ================================================================== */
// Global variables
/* ================================================================== */

UINT64 insCount = 0;        //number of dynamically executed instructions
UINT64 bblCount = 0;        //number of dynamically executed basic blocks
UINT64 threadCount = 0;     //total number of threads, including main thread

std::ostream * out = &cerr;

ADDRINT g_addrLow;
ADDRINT g_addrHigh;
BOOL g_bMainExecLoaded = FALSE;


/* ===================================================================== */
// Command line switches
/* ===================================================================== */
KNOB<string> KnobOutputFile(KNOB_MODE_WRITEONCE,  "pintool",
    "o", "", "specify file name for MyPinTool output");

KNOB<BOOL>   KnobCount(KNOB_MODE_WRITEONCE,  "pintool",
    "count", "1", "count instructions, basic blocks and threads in the application");


/* ===================================================================== */
// Utilities
/* ===================================================================== */

/*!
 *  Print out help message.
 */
INT32 Usage()
{
    cerr << "This tool prints out the number of dynamically executed " << endl <<
            "instructions, basic blocks and threads in the application." << endl << endl;

    cerr << KNOB_BASE::StringKnobSummary() << endl;

    return -1;
}

/* ===================================================================== */
// Analysis routines
/* ===================================================================== */

/*!
 * Increase counter of the executed basic blocks and instructions.
 * This function is called for every basic block when it is about to be executed.
 * @param[in]   numInstInBbl    number of instructions in the basic block
 * @note use atomic operations for multi-threaded applications
 */
VOID CountBbl(UINT32 numInstInBbl)
{
    bblCount++;
    insCount += numInstInBbl;
}

/* ===================================================================== */
// Instrumentation callbacks
/* ===================================================================== */

/*!
 * Insert call to the CountBbl() analysis routine before every basic block
 * of the trace.
 * This function is called every time a new trace is encountered.
 * @param[in]   trace    trace to be instrumented
 * @param[in]   v        value specified by the tool in the TRACE_AddInstrumentFunction
 *                       function call
 */
VOID Trace(TRACE trace, VOID *v)
{
    if( g_bMainExecLoaded ) {
        // Visit every basic block in the trace
        for (BBL bbl = TRACE_BblHead(trace); BBL_Valid(bbl); bbl = BBL_Next(bbl))
        {
            // Insert a call to CountBbl() before every basic bloc, passing the number of instructions
            BBL_InsertCall(bbl, IPOINT_BEFORE, (AFUNPTR)CountBbl, IARG_UINT32, BBL_NumIns(bbl), IARG_END);
        }
    }
}

/*!
 * Increase counter of threads in the application.
 * This function is called for every thread created by the application when it is
 * about to start running (including the root thread).
 * @param[in]   threadIndex     ID assigned by PIN to the new thread
 * @param[in]   ctxt            initial register state for the new thread
 * @param[in]   flags           thread creation flags (OS specific)
 * @param[in]   v               value specified by the tool in the
 *                              PIN_AddThreadStartFunction function call
 */
VOID ThreadStart(THREADID threadIndex, CONTEXT *ctxt, INT32 flags, VOID *v)
{
    threadCount++;
}

std::vector<std::string> insLogs;
int order = 0;

VOID addMemLog(char rw, ADDRINT addr, UINT32 size, UINT32 logIndex) {
    std::ostringstream detailStream;
    detailStream << "        [" << order++ << "] " << " -" << rw << "-> " << addr << " <" << size << ">" << endl;
    insLogs[logIndex] += detailStream.str();
}

VOID RecordMemRead(ADDRINT ip, ADDRINT addr, UINT32 size, UINT32 logIndex)
{
    addMemLog('r', addr, size, logIndex);
}

VOID RecordMemWrite(ADDRINT ip, ADDRINT addr, UINT32 size, UINT32 logIndex)
{
    addMemLog('w', addr, size, logIndex);
}


VOID Instruction(INS ins, VOID *v)
{
    //https://software.intel.com/sites/landingpage/pintool/docs/97619/Pin/html/group__INS__BASIC__API__GEN__IA32.html
    string strInst = INS_Mnemonic(ins);
    ADDRINT addr = INS_Address(ins);

    // BOOL isCall = INS_IsCall(ins);
    // BOOL isRet = INS_IsRet(ins);

    if( g_bMainExecLoaded ) { // if the main module is not loaded, we don’t need to trace any.
        if( g_addrLow <= addr && addr <= g_addrHigh ) {
            std::ostringstream detailStream;
            detailStream << addr << " " << strInst;


            UINT32 memOperands = INS_MemoryOperandCount(ins);
            UINT32 memRRegs = INS_MaxNumWRegs(ins);
            UINT32 memWRegs = INS_MaxNumRRegs(ins);

            if (memRRegs > 0) {
                detailStream << " -r->";
                for( UINT32 i=0; i < memRRegs; i++ ) {
                    REG reg = INS_RegR(ins, i);
                    detailStream << " " << REG_StringShort(reg);
                    if ( REG_is_fr( reg ) ) {
                        detailStream << " (float)";
                    }
                }
            }
            if (memWRegs > 0) {
                detailStream << " -w->";
                for( UINT32 i=0; i < memWRegs; i++ ) {
                    REG reg = INS_RegR(ins, i);
                    detailStream << " " << REG_StringShort(reg);
                    if ( REG_is_fr( reg ) ) {
                        detailStream << " (float)";
                    }
                }
            }

            detailStream << endl;
            insLogs.push_back(detailStream.str());

            // Iterate over each memory operand of the instruction.
            for (UINT32 memOp = 0; memOp < memOperands; memOp++) {
                if (INS_MemoryOperandIsRead(ins, memOp)) {
                    INS_InsertCall(
                        ins, IPOINT_BEFORE,
                        (AFUNPTR)RecordMemRead,
                        IARG_INST_PTR,
                        IARG_MEMORYOP_EA, memOp,
                        IARG_MEMORYREAD_SIZE,
                        IARG_UINT32, insLogs.size() - 1,
                        IARG_END
                    );
                } else if (INS_MemoryOperandIsWritten(ins, memOp)) {
                    INS_InsertCall(
                        ins, IPOINT_BEFORE,
                        (AFUNPTR)RecordMemWrite,
                        IARG_INST_PTR,
                        IARG_MEMORYOP_EA, memOp,
                        IARG_MEMORYWRITE_SIZE,
                        IARG_UINT32, insLogs.size() - 1,
                        IARG_END
                    );
                }

            }
        } else {
            // printf("[2] %llx %s\n", addr, strInst.c_str());
        }
    } else {
        printf("[3] %llx %s\n", addr, strInst.c_str());
    }
}

VOID ImageLoad(IMG img, VOID *v)
{
    if( IMG_IsMainExecutable(img) ) {
        //printf("%p - %p\n", (void*)IMG_LowAddress(img), (void*)IMG_HighAddress(img));
        g_addrLow = IMG_LowAddress(img);
        g_addrHigh = IMG_HighAddress(img);

        // Use the above addresses to prune out non-interesting instructions.
        g_bMainExecLoaded = TRUE;
    }
}

/*!
 * Print out analysis results.
 * This function is called when the application exits.
 * @param[in]   code            exit code of the application
 * @param[in]   v               value specified by the tool in the
 *                              PIN_AddFiniFunction function call
 */
VOID Fini(INT32 code, VOID *v)
{
    *out <<  "===============================================" << endl;
    *out <<  "MyPinTool analysis results: " << endl;
    *out <<  "Number of instructions: " << insCount  << endl;
    *out <<  "Number of basic blocks: " << bblCount  << endl;
    *out <<  "Number of threads: " << threadCount  << endl;
    *out <<  "===============================================" << endl;


    for(size_t i = 0; i < insLogs.size(); i++)
    {
        *out << insLogs[i];
    }
}

/*!
 * The main procedure of the tool.
 * This function is called when the application image is loaded but not yet started.
 * @param[in]   argc            total number of elements in the argv array
 * @param[in]   argv            array of command line arguments,
 *                              including pin -t <toolname> -- ...
 */
int main(int argc, char *argv[])
{
    // Initialize PIN library. Print help message if -h(elp) is specified
    // in the command line or the command line is invalid
    if( PIN_Init(argc,argv) )
    {
        return Usage();
    }

    string fileName = KnobOutputFile.Value();

    if (!fileName.empty()) { out = new std::ofstream(fileName.c_str());}

    if (KnobCount)
    {
        // On OS X*, you must initially do PIN_InitSymbols() if you want to use IMG_AddInstrumentFunction()
        PIN_InitSymbols();

        // Register ImageLoad to be called when an image is loaded
        IMG_AddInstrumentFunction(ImageLoad, 0);

        // Register Instruction to be called to instrument instructions
        INS_AddInstrumentFunction(Instruction, 0);

        // Register function to be called to instrument traces
        TRACE_AddInstrumentFunction(Trace, 0);

        // Register function to be called for every thread before it starts running
        PIN_AddThreadStartFunction(ThreadStart, 0);

        // Register function to be called when the application exits
        PIN_AddFiniFunction(Fini, 0);
    }

    cerr <<  "===============================================" << endl;
    cerr <<  "This application is instrumented by MyPinTool" << endl;
    if (!KnobOutputFile.Value().empty())
    {
        cerr << "See file " << KnobOutputFile.Value() << " for analysis results" << endl;
    }
    cerr <<  "===============================================" << endl;

    // Start the program, never returns
    PIN_StartProgram();

    return 0;
}

/* ===================================================================== */
/* eof */
/* ===================================================================== */
