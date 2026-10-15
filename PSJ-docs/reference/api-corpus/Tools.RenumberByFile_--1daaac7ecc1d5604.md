# Tools.RenumberByFile()

Tools.RenumberByFile()

Description​

Renumber the model by a CSV file. The renumber targets are Nodes, 2D Elements, 3D Elements.

Syntax​

Tools.RenumberByFile(...)

Ribbon: Tools » RenumberByFile

Inputs​

strCSVPath​

A String specifying the path of CSV file. The CSV file must correspond correctly with the model, can not use a different CSV for a different model.

This is a required input.

iConflictStrategy​

An Integer specifying the conflict strategy. This parameter is used to apply to Share Face/Node case, by choosing the method that assigning ID of Share Face/Nodes would belong to which part.

If iConflictStrategy=0: Less ID(<) method, when the Share Face/Nodes existing in model, the ID of them when renumber will belong to the Part has smaller ID.

If iConflictStrategy=1: Great ID(<) method, when the Share Face/Nodes existing in model, the ID of them when renumber will belong to the Part has larger ID.

The default value is 0.

bNeedToUpdateCount​

A Boolean specifying the option to activate the counter update of each model for each component(Nodes, 2D, 3D). The counter is a value that represents the total amount of each component.

If True: The counter will update

If False: The counter will not update

The default value is False.

Return Code​

A Boolean specifying whether the process is executed successfully or not:

True: The process is executed successfully.

False: Cannot execute the function.

Sample Code​

jpt_path = JPT.GetAppPathInfo((JPT.PathType.PROGRAM_PATH))

sample_model = jpt_path + 'SampleData\\PSJ\\PSJ-Utility\\JtdbSample\\RenumberByFile.jth5'
sample_csv = jpt_path + 'SampleData\\PSJ\\PSJ-Utility\\Utils\\RenumberByFile.csv'

#import model
FileMenu.LoadJTH5(sample_model)
JPT.ViewFitToModel()

result = Tools.RenumberByFile(strCSVPath = sample_csv)
JPT.Debugger(result)
