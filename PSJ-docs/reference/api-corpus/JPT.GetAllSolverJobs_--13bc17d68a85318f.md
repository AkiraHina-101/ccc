# JPT.GetAllSolverJobs()

JPT.GetAllSolverJobs()

Description​

Get all the information of solver jobs (job name, steps, job description).

Syntax​

JPT.GetAllSolverJobs()

Inputs​

This utility function does not require any input value.

Return Code​

A SolverJobVector object or List of DSolverJob objects containing all the information of all the jobs.

Sample Code​

# Prepare model
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\JtdbSample\\Get_Infor_Part_Sample.jtdb"
FileMenu.LoadJTDB(strFileName=samplePath)
JPT.ViewFitToModel()

# Get the information of all solver jobs
listJobs = JPT.GetAllSolverJobs()
JPT.Debugger(listJobs) #size = 3

# Declare job variables
ADVC_Job = listJobs[0]
Abaqus_Job = listJobs[1]
Nastran_Job = listJobs[2]

# Access Name/Step/Description of ADVC Job
JPT.Debugger(ADVC_Job)
JPT.Debugger(ADVC_Job.name)
JPT.Debugger(ADVC_Job.jobDescription)
for step in ADVC_Job.jobSteps:
    JPT.Debugger(step)

# Access Name/Step/Description of Abaqus Job
JPT.Debugger(Abaqus_Job)
JPT.Debugger(Abaqus_Job.name)
JPT.Debugger(Abaqus_Job.jobDescription)
for step in Abaqus_Job.jobSteps:
    JPT.Debugger(step)

# Access Name/Step/Description of Nastran Job
JPT.Debugger(Nastran_Job)
JPT.Debugger(Nastran_Job.name)
JPT.Debugger(Nastran_Job.jobSteps) #size = 0, Nastran does not have steps
JPT.Debugger(Nastran_Job.jobDescription)
