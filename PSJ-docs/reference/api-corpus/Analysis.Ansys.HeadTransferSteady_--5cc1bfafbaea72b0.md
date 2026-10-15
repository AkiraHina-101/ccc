# Analysis.Ansys.HeadTransferSteady()

Analysis.Ansys.HeadTransferSteady()

Description​

Export the Ansys Heat Transfer solver file

Syntax​

Analysis.Ansys.HeadTransferSteady(...)

Macro: CreateAnsysJob

Ribbon: Analysis » Ansys » HeadTransferSteady

Inputs​

strName​

A String specifying the name.

This is a required input.

iJobdataAnatype​

An Integer specifying the job data analysis type.

The default value is 0.

iJobdataSoltype​

An Integer specifying the job data solution type.

The default value is 0.

strJobdataJobname​

A String specifying the job data job name.

The default value is "Job1".

strJobdataJobdescription​

A String specifying the job data job description.

The default value is "".

bBasicdataBoutputdisplacements​

A Boolean specifying the basic data output displacements.

The default value is False.

bBasicdataBoutputreactionload​

A Boolean specifying the basic data output reaction oad.

The default value is False.

bBasicdataBoutputstrain​

A Boolean specifying the basic data output strain.

The default value is False.

bBasicdataBoutputstress​

A Boolean specifying the basic data output stress.

The default value is False.

iBasicdataIanalysisopt​

An Integer specifying the basic data analysis option.

The default value is 0.

bBasicdataBcalPressEffects​

A Boolean specifying the basic data caculation press effects.

The default value is False.

dBasicdataFunitem​

A Double specifying the basic data unit temperature.

The default value is 0.0.

dBasicdataFreftemp​

A Double specifying the basic data reference temperature.

The default value is 0.0.

dBasicdataFendloadtime​

A Double specifying the basic data end load time.

The default value is 0.0.

iBasicdataItimestep​

An Integer specifying the basic data time step.

The default value is 0.

iBasicdataIstepchosen​

An Integer specifying the basic data step chosen.

The default value is 0.

iBasicdataIsubstepnum​

An Integer specifying the basic data sub step number.

The default value is 0.

iBasicdataImaxsubstep​

An Integer specifying the basic data maximum sub step.

The default value is 0.

iBasicdataIminstepnum​

An Integer specifying the basic data minimum sub step.

The default value is 0.

dBasicdataFtimestepsize​

A Double specifying the basic data time step size.

The default value is 0.0.

dBasicdataFmintimestep​

A Double specifying the basic data minimum sub step.

The default value is 0.0.

dBasicdataFmaxtimestep​

A Double specifying the basic data maximum sub step.

The default value is 0.0.

iBasicdataIwritereslutfre​

An Integer specifying the basic data write result frequency.

The default value is 1.

iBasicdataIn​

An Integer specifying the basic data in.

The default value is 1.

bRunAPDL​

A Boolean specifying the run Ansys APDL.

The default value is False.

bWriteResultDB​

A Boolean specifying the write result d .

The default value is False.

dFEndFreq​

A Double specifying the end frequence.

The default value is DFLT_DBL.

dFStartFreq​

A Double specifying the start frequence.

The default value is DFLT_DBL.

iFulltransdataIsolutionoption​

An Integer specifying the full translation data solution option.

The default value is 0.

dFulltransdataFpropchange​

A Double specifying the full translation data property change.

The default value is 0.05.

iFulltransdataIpointnum​

An Integer specifying the full translation data point number.

The default value is 64.

dFulltransdataFmintemp​

A Double specifying the full translation data minimum temperature.

The default value is 0.0.

dFulltransdataFmaxtemp​

A Double specifying the full translation data maximum temperature.

The default value is 0.0.

iFulltransdataIequationsolv​

An Integer specifying the full translation data equation solve.

The default value is 0.

dFulltransdataFtollevel​

A Double specifying the full translation data tolerance level.

The default value is 0.0.

dFulltransdataFmultiplier​

A Double specifying the full translation data multiplier.

The default value is 0.0.

bFulltransdataBsignleprecision​

A Boolean specifying the full translation data single precision.

The default value is False.

bFulltransdataBmemorysave​

A Boolean specifying the full translation data memory save.

The default value is False.

dFulltransdataFtempdiff​

A Double specifying the full translation data temperature difference.

The default value is 1.1.

dHarmonicdataFstartfreq​

A Double specifying the harmonic data start frequence.

The default value is 0.0.

dHarmonicdataFendfreq​

A Double specifying the harmonic data end frequence.

The default value is 1.0.

iHarmonicdataNsubsteps​

An Integer specifying the harmonic data sub steps.

The default value is 0.

dHarmonicdataFalphad​

A Double specifying the harmonic data alpha.

The default value is 0.0.

dHarmonicdataFbetad​

A Double specifying the harmonic data beta.

The default value is 0.0.

dHarmonicdataFdmprat​

A Double specifying the harmonic data DMP ratio.

The default value is 0.0.

bHarmonicdataBoutputdisplacements​

A Boolean specifying the harmonic data output displacements.

The default value is False.

bHarmonicdataBoutputstrain​

A Boolean specifying the harmonic data output strain.

The default value is False.

bHarmonicdataBoutputstress​

A Boolean specifying the harmonic data output stress.

The default value is False.

iLCId​

An Integer specifying the LC ID.

The default value is 0.

iModeShape​

An Integer specifying the mode shape.

The default value is 0.

iModaldataImodemethod​

An Integer specifying the modal data mode method.

The default value is 0.

iModaldataIextractnum​

An Integer specifying the modal data extract number.

The default value is 1.

bModaldataBexpandshape​

A Boolean specifying the modal data expand shape.

The default value is True.

iModaldataIexpandnum​

An Integer specifying the modal data expand number.

The default value is 0.

bModaldataBuseapprox​

A Boolean specifying the modal data use approximately.

The default value is False.

bModaldataBinclprsseff​

A Boolean specifying the modal data include prsseff.

The default value is False.

bModaldataBmemorysave​

A Boolean specifying the modal data memory save.

The default value is False.

bModaldataBrsvec​

A Boolean specifying the modal data resource vector.

The default value is False.

bModaldataBoutputdisplacements​

A Boolean specifying the modal data output displacements.

The default value is False.

bModaldataBoutputstrain​

A Boolean specifying the modal data output strain.

The default value is False.

bModaldataBoutputstress​

A Boolean specifying the modal data output stress.

The default value is False.

iReduceddataIprintnum​

An Integer specifying the reduceddata print number.

The default value is 0.

bSsdataBmemorysave​

A Boolean specifying the ssdata memory save.

The default value is False.

bSsdataBoutputheatflux​

A Boolean specifying the ssdata output heat flux.

The default value is False.

bSsdataBoutputtemperature​

A Boolean specifying the ssdata output temperature.

The default value is False.

bSsdataBpivotscheck​

A Boolean specifying the ssdata pivots check.

The default value is True.

bSsdataBsignleprecision​

A Boolean specifying the ssdata single precision.

The default value is False.

dSsdataFmultiplier​

A Double specifying the ssdata multiplier.

The default value is 0.0.

dSsdataFtempdiff​

A Double specifying the ssdata temperature difference.

The default value is 0.0.

dSsdataFtollevel​

A Double specifying the ssdata tolerance level.

The default value is 0.0.

iSsdataIadaptivedes​

An Integer specifying the ssdata adaptive destination.

The default value is 0.

iSsdataIequationsolv​

An Integer specifying the ssdata equation solve.

The default value is 0.

iSsdataInpoption​

An Integer specifying the ssdata inpoption.

The default value is 0.

strAnsysVersion​

A String specifying the ansys version.

The default value is "".

strCommandLineOption​

A String specifying the command line option.

The default value is "".

bOutputSOLVE​

A Boolean specifying the output solve.

The default value is False.

iSubspacedataIrigidmode​

An Integer specifying the subspace data rigid mode.

The default value is 0.

iSubspacedataIworksize​

An Integer specifying the subspace data work size.

The default value is 8.

iSubspacedataInpadnum​

An Integer specifying the subspace data inpad number.

The default value is 4.

iSubspacedataIblocknum​

An Integer specifying the subspace data block number.

The default value is 5.

iSubspacedataImaxiteratcnt​

An Integer specifying the subspace data maximum iterator number.

The default value is 0.

iSubspacedataIminnshift​

An Integer specifying the subspace data iminnshift.

The default value is 0.

iSubspacedataIseqcheck​

An Integer specifying the subspace data iseqcheck.

The default value is 0.

bTransientdataBtraneffect​

A Boolean specifying the transient data effection.

The default value is True.

iTransientdataIloadingtype​

An Integer specifying the transient data loading type.

The default value is 0.

dTransientdataFmassmatrixmult​

A Double specifying the transient data mass matrix multiple.

The default value is 0.0.

dTransientdataFstiffmatrixmult​

A Double specifying the transient data stiff matrix multiple.

The default value is 0.0.

bTransientdataBmidstep​

A Boolean specifying the transient data midle step.

The default value is False.

dTransientdataFtolerancebisection​

A Double specifying the transient data tolerance binary section.

The default value is 0.0.

dTransientdataFtolerancetimestep​

A Double specifying the transient data tolerance time step.

The default value is 0.0.

iTransientdataItimeinteralgor​

An Integer specifying the transient data time inter algorithm.

The default value is 0.

iTransientdataItimeinter​

An Integer specifying the transient data time inter.

The default value is 0.

dTransientdataFgamma​

A Double specifying the transient data gamma.

The default value is 0.005.

dTransientdataFalpha​

A Double specifying the transient data alpha.

The default value is 0.25250625.

dTransientdataFdelta​

A Double specifying the transient data delta.

The default value is 0.505.

dTransientdataFalphaf​

A Double specifying the transient data alpha f.

The default value is 0.005.

dTransientdataFalpham​

A Double specifying the transient data alpha m.

The default value is 0.0.

bTransientdataBoutputtemperature​

A Boolean specifying the transient data output temperature.

The default value is False.

bTransientdataBoutputheatflux​

A Boolean specifying the transient data output heat flux.

The default value is False.

crEdit​

A Cursor specifying the edit.

The default value is None.

Return Code​

A String of 1 if success, or 0 if fail.

Sample Code​

Analysis.Ansys.HeatTransferSteady(strName="", iJobdataAnatype=0, iJobdataSoltype=0, strJobdataJobname="Job1", strJobdataJobdescription="", bBasicdataBoutputdisplacements=False, bBasicdataBoutputreactionload=False, bBasicdataBoutputstrain=False, bBasicdataBoutputstress=False, iBasicdataIanalysisopt=0, bBasicdataBcalPressEffects=False, dBasicdataFunitem=0.0, dBasicdataFreftemp=0.0, dBasicdataFendloadtime=0.0, iBasicdataItimestep=0, iBasicdataIstepchosen=0, iBasicdataIsubstepnum=0, iBasicdataImaxsubstep=0, iBasicdataIminstepnum=0, dBasicdataFtimestepsize=0.0, dBasicdataFmintimestep=0.0, dBasicdataFmaxtimestep=0.0, iBasicdataIwritereslutfre=1, iBasicdataIn=1, bRunAPDL=False, bWriteResultDB=False, dFEndFreq=DFLT_DBL, dFStartFreq=DFLT_DBL, iFulltransdataIsolutionoption=0, dFulltransdataFpropchange=0.05, iFulltransdataIpointnum=64, dFulltransdataFmintemp=0.0, dFulltransdataFmaxtemp=0.0, iFulltransdataIequationsolv=0, dFulltransdataFtollevel=0.0, dFulltransdataFmultiplier=0.0, bFulltransdataBsignleprecision=False, bFulltransdataBmemorysave=False, dFulltransdataFtempdiff=1.1, dHarmonicdataFstartfreq=0.0, dHarmonicdataFendfreq=1.0, iHarmonicdataNsubsteps=0, dHarmonicdataFalphad=0.0, dHarmonicdataFbetad=0.0, dHarmonicdataFdmprat=0.0, bHarmonicdataBoutputdisplacements=False, bHarmonicdataBoutputstrain=False, bHarmonicdataBoutputstress=False, iLCId=0, iModeShape=0, iModaldataImodemethod=0, iModaldataIextractnum=1, bModaldataBexpandshape=True, iModaldataIexpandnum=0, bModaldataBuseapprox=False, bModaldataBinclprsseff=False, bModaldataBmemorysave=False, bModaldataBrsvec=False, bModaldataBoutputdisplacements=False, bModaldataBoutputstrain=False, bModaldataBoutputstress=False, iReduceddataIprintnum=0, bSsdataBmemorysave=False, bSsdataBoutputheatflux=False, bSsdataBoutputtemperature=False, bSsdataBpivotscheck=True, bSsdataBsignleprecision=False, dSsdataFmultiplier=0.0, dSsdataFtempdiff=0.0, dSsdataFtollevel=0.0, iSsdataIadaptivedes=0, iSsdataIequationsolv=0, iSsdataInpoption=0, strAnsysVersion="", strCommandLineOption="", bOutputSOLVE=False, iSubspacedataIrigidmode=0, iSubspacedataIworksize=8, iSubspacedataInpadnum=4, iSubspacedataIblocknum=5, iSubspacedataImaxiteratcnt=0, iSubspacedataIminnshift=0, iSubspacedataIseqcheck=0, bTransientdataBtraneffect=True, iTransientdataIloadingtype=0, dTransientdataFmassmatrixmult=0.0, dTransientdataFstiffmatrixmult=0.0, bTransientdataBmidstep=False, dTransientdataFtolerancebisection=0.0, dTransientdataFtolerancetimestep=0.0, iTransientdataItimeinteralgor=0, iTransientdataItimeinter=0, dTransientdataFgamma=0.005, dTransientdataFalpha=0.25250625, dTransientdataFdelta=0.505, dTransientdataFalphaf=0.005, dTransientdataFalpham=0.0, bTransientdataBoutputtemperature=False, bTransientdataBoutputheatflux=False, crEdit=None)
