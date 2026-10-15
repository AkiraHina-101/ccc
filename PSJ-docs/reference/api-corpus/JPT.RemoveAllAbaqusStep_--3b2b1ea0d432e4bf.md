# JPT.RemoveAllAbaqusStep()

JPT.RemoveAllAbaqusStep()

Description​

Remove all the existing Abaqus steps.

Syntax​

JPT.RemoveAllAbaqusStep()

Inputs​

This utility function does not require any input value.

Return Code​

This utility function does not have output value.

Sample Code​

# Creating jobs with steps
JPT.Exec('AbaqusStaticStep("Step1", "", 1, 100, 1, 1e-05, \
          1, 0, 0, 0, 8, 1, 30, 0, 0.0002, 1, 0.05, 0, 1, 0, \
          0, 1, 1, 0, 0, 0, 0, [""], [], 0:0)')
JPT.Exec('AbaqusStaticStep("Step2", "", 1, 100, 1, 1e-05, \
          1, 0, 0, 0, 8, 1, 30, 0, 0.0002, 1, 0.05, 0, 1, 0, \
          0, 1, 1, 0, 0, 0, 0, [""], [], 0:0)')
JPT.Exec('AbaqusStaticStep("Step3", "", 1, 100, 1, 1e-05, \
          1, 0, 0, 0, 8, 1, 30, 0, 0.0002, 1, 0.05, 0, 1, 0, \
          0, 1, 1, 0, 0, 0, 0, [""], [], 0:0)')
JPT.Exec('AbaqusStaticStep("Step4", "", 1, 100, 1, 1e-05, \
          1, 0, 0, 0, 8, 1, 30, 0, 0.0002, 1, 0.05, 0, 1, 0, \
          0, 1, 1, 0, 0, 0, 0, [""], [], 0:0)')
JPT.Exec('AbaqusStaticStep("Step5", "", 1, 100, 1, 1e-05, \
          1, 0, 0, 0, 8, 1, 30, 0, 0.0002, 1, 0.05, 0, 1, 0, \
          0, 1, 1, 0, 0, 0, 0, [""], [], 0:0)')
JPT.Exec('AbaqusStaticStep("Step6", "", 1, 100, 1, 1e-05, \
          1, 0, 0, 0, 8, 1, 30, 0, 0.0002, 1, 0.05, 0, 1, 0, \
          0, 1, 1, 0, 0, 0, 0, [""], [], 0:0)')
JPT.Exec('CreateAbaqusJob("Job_1", 0, 0, 0, 0, 1, 0, "", \
          [134:1, 134:2, 134:3, 134:4, 134:5, 134:6], 0:0, \
          [], 0, 0, 0, 0, 1, 0:0, 1)')
JPT.Exec('AbaqusStaticStep("Step7", "", 1, 100, 1, 1e-05, \
          1, 0, 0, 0, 8, 1, 30, 0, 0.0002, 1, 0.05, 0, 1, 0, \
          0, 1, 1, 0, 0, 0, 0, [""], [], 0:0)')
JPT.Exec('AbaqusStaticStep("Step8", "", 1, 100, 1, 1e-05, \
          1, 0, 0, 0, 8, 1, 30, 0, 0.0002, 1, 0.05, 0, 1, 0, \
          0, 1, 1, 0, 0, 0, 0, [""], [], 0:0)')
JPT.Exec('CreateAbaqusJob("Job_2", 0, 0, 0, 0, 1, 0, "", \
          [134:1, 134:2, 134:3, 134:4, 134:5, 134:6, 134:7, 134:8], 0:0, \
          [], 0, 0, 0, 0, 1, 0:0, 1)')

# Remove all the created steps for both created jobs
JPT.RemoveAllAbaqusStep()
