# CreateSubAssembly

CreateSubAssembly CreateSubAssembly Description Create a new sub assembly under the indicated parent sub assembly. Syntax CreateSubAssembly(std::string name, DItemW parent) Inputs string create sub assembly name DItemW parent assembly tree item Return Code Python Output DItemW Create Tree Item Sample Code Input: JPT.CreateSubAssembly('CreateSubAsm',JPT.DItem()) SubAsm=JPT.GetSubAssemblyById(1) JPT.CreateSubAssembly('AddSubAsm',SubAsm) Output:
