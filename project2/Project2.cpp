//===- Hello.cpp - Example code from "Writing an LLVM Pass" ---------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements two versions of the LLVM "Hello World" pass described
// in docs/WritingAnLLVMPass.html
//
//===----------------------------------------------------------------------===//

#define DEBUG_TYPE "hello"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/InstIterator.h"
#include "llvm/Support/CallSite.h"
#include <string>
#include <set>
#include <map>
#include <fstream>

using namespace std;
using namespace llvm;


namespace {
  // Hello - The first implementation, without getAnalysisUsage.
  struct Project2 : public ModulePass {
    static char ID; // Pass identification, replacement for typeid
    ofstream callGraph, controlFlowGraph;
    Project2() : ModulePass(ID) {
      callGraph.open("call_graph.dot");
      controlFlowGraph.open("control_flow_graph.dot");
    }

    virtual ~Project2() {
      callGraph.close();
      controlFlowGraph.close();
    }

    virtual bool runOnModule(Module &M) override {
      // only track control-flow-graph for main function
      Function* mainF;

      callGraph << "digraph call_graph {\n";

      for (Module::iterator fIter = M.begin(); fIter != M.end(); fIter++) {
        Function* f = dyn_cast<Function>(&*fIter);

        runOnFunction(*f);

        if (f->getName().str() == "main") {
          mainF = f;
        }
      }

      callGraph << "}\n";

      controlFlowGraph << "digraph control_flow_graph {\n";

      // control flow graph for main function
      for(Function::iterator bbIter = mainF->begin(); bbIter != mainF->end(); bbIter++) {
        BasicBlock* bb = dyn_cast<BasicBlock>(&*bbIter);

        TerminatorInst* termIns = bb->getTerminator();

        int sucNum = termIns->getNumSuccessors();

        for (int idx = 0; idx < sucNum; idx++) {
          BasicBlock* successor = termIns->getSuccessor(idx);
          controlFlowGraph << " \"" << bb->getName().str() << "\" -> \"" << successor->getName().str() << "\";\n";
        }
      }

      controlFlowGraph << "}\n";

      // print possible execution paths of main
      errs() << "passible paths:\n";
      set<BasicBlock*> path;
      findAllPaths(mainF->begin(), path);

      return false;
    }

    void findAllPaths(BasicBlock* bb, set<BasicBlock*> path) {
      TerminatorInst* termIns = bb->getTerminator();

      int sucNum = termIns->getNumSuccessors();

      // no further successors
      if (sucNum == 0) {
        printPath(bb, path);
      } else {
        for (int idx = 0; idx < sucNum; idx++) {
          BasicBlock* successor = termIns->getSuccessor(idx);

          // successor appears in path, a loop
          if (path.find(successor) != path.end()) {
            errs() << "[" << successor->getName() << "] to [" << bb->getName() << "] is a loop\n";

            printPath(bb, path);
          } else {
            path.insert(bb);
            findAllPaths(successor, path);
            path.erase(bb);
          }
        }
      }
    }

    void printPath(BasicBlock* bb, set<BasicBlock*> path) {
      set<BasicBlock*>::iterator pit;

      for(pit = path.begin(); pit != path.end(); pit++){
        errs() << "[" << (*pit)->getName() << "] -> ";
      }

      errs() << "[" << bb->getName() << "]\n\n";
    }

    virtual bool runOnFunction(Function &F) {
      set<string> callee;

      for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I) {
        CallSite cs(&*I) ;
        if (cs.getInstruction()){
          Value *called = cs.getCalledValue()->stripPointerCasts();
          Function *f = dyn_cast<Function>(called);
          if (f) {
            callee.insert(f->getName().str());
          }
        }
      }

      set<string>::iterator it;

      for(it = callee.begin(); it != callee.end(); it++){
        callGraph << " " << F.getName().str() << " -> " << *it << ";\n";
      }

      return false;
    }
  };
}

char Project2::ID = 0;
static RegisterPass<Project2> X("Project2", "Project2 Pass");
