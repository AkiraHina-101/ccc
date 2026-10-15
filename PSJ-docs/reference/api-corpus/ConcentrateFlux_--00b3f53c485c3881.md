# ConcentrateFlux()

ConcentrateFlux()

Description​

Create concentrate flux

Syntax​

ConcentrateFlux(String m_strName,double fflux,Cursor crTable,Cursor[] m_taTarget,Cursor m_crEdit)

Inputs​

1. String​

name of concentrate flux

2. Double​

value of concentrate flux

3. Cursor​

select table

4. Cursor[]​

targets

5. Cursor​

edit cursor

Return Code​

"1": The function can be executed

"0": The function cannot be executed

Sample Code​

ConcentrateFlux("Test",0.001,1:11,[1:11,2:12],1:11)
