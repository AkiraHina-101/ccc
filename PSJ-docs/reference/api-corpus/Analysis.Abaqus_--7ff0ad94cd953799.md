# Analysis.Abaqus()

Analysis.Abaqus()

説明​

Abaqus ジョブを作成します。

構文​

Analysis.Abaqus(...)

マクロ：CreateAbaqusJob

リボン：Analysis » Abaqus

入力​

strName​

Abaqus ジョブ名を指定する String です。

この入力は必須です。

abaqusAnalysis​

Abaqus 解析入力パラメータを指定する JOB_ABAQUS_DATA です。

デフォルト値は JOB_ABAQUS_DATA です。

crlStepSequence​

シーケンスに定義された Abaqus ステップのリストを指定する Cursor リストです。

デフォルト値は [] です。

crEdit​

既存の Abaqus ジョブを指定する Cursor です。

このパラメータを使用すると、指定したジョブが変更されます。

None のままにすると、新しいジョブが作成されます。

デフォルト値は None です。

戻り値​

作成されたジョブを指定する Cursor です。

サンプルコード​

Geometry.Part.Cube(iPartColor=5619133)
Meshing.SolidMeshing(crlParts=[Part(1)],
                     bTet10=True, 
                     dGradingFactor=1.05, 
                     dStretchLimit=0.1, 
                     iSpeedVsQual=1, 
                     iRegion=1, 
                     bSafeMode=False, 
                     iParallel=12, 
                     bInternalMeshOnly=False, 
                     iPartColor=65280)

Properties.Material.Add("Concrete", 
                        [Density([(DENSITY, 2.3e-09)]), 
                        Elastic([(YOUNGS_MODULUS, 30000.0), 
                                 (POISSONS_RATIO, 0.18)])])

Properties.Solid(crlTargets=[Part(1)], 
                 strName="Solid Property 1", 
                 iPropertyColor=12275404, 
                 crMaterial=Material(1), 
                 iCordM=-2, 
                 dDynaRemeshVal1=DFLT_DBL,
                 dDynaRemeshVal2=DFLT_DBL, 
                 dDispHG=DFLT_DBL, 
                 iFLG=-1)

created_job = Analysis.Abaqus("Job_1", 
                              abaqusAnalysis=JOB_ABAQUS_DATA(iUnit=1))

JPT.Debugger(created_job)
