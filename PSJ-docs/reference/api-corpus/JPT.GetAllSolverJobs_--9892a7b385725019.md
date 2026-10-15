# JPT.GetAllSolverJobs()

JPT.GetAllSolverJobs()

説明​

ソルバージョブのすべての情報を取得します（ジョブ名、ステップ、ジョブの説明）。

構文​

JPT.GetAllSolverJobs()

入力​

このユーティリティ関数には入力値は必要ありません。

戻り値​

すべてのジョブの情報を含む SolverJobVector オブジェクトまたは List of DSolverJob オブジェクト。

サンプルコード​

# モデルの準備
samplePath = JPT.GetProgramPath() + "SampleData\\PSJ\\PSJ-Utility\\JtdbSample\\Get_Infor_Part_Sample.jtdb"
FileMenu.LoadJTDB(strFileName=samplePath)
JPT.ViewFitToModel()

# すべてのソルバージョブの情報を取得
listJobs = JPT.GetAllSolverJobs()
JPT.Debugger(listJobs) #size = 3

# ジョブ変数を宣言
ADVC_Job = listJobs[0]
Abaqus_Job = listJobs[1]
Nastran_Job = listJobs[2]

# ADVCジョブの名前/ステップ/説明にアクセス
JPT.Debugger(ADVC_Job)
JPT.Debugger(ADVC_Job.name)
JPT.Debugger(ADVC_Job.jobDescription)
for step in ADVC_Job.jobSteps:
    JPT.Debugger(step)

# Abaqusジョブの名前/ステップ/説明にアクセス
JPT.Debugger(Abaqus_Job)
JPT.Debugger(Abaqus_Job.name)
JPT.Debugger(Abaqus_Job.jobDescription)
for step in Abaqus_Job.jobSteps:
    JPT.Debugger(step)

# Nastranジョブの名前/ステップ/説明にアクセス
JPT.Debugger(Nastran_Job)
JPT.Debugger(Nastran_Job.name)
JPT.Debugger(Nastran_Job.jobSteps) #size = 0, Nastranにはステップがありません
JPT.Debugger(Nastran_Job.jobDescription)
