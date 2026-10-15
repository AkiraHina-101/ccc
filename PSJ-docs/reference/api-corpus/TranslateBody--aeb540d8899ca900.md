# TranslateBody

TranslateBody TranslateBody Description Translate Body Syntax TranslateBody(cursor[] taBody, double[] tavdTranslate, cursor crCoord, bool bCreateNewBody, bool bcopyLBC, int iCopyCount) Inputs Cursor[] Target part cursor([3:Part ID]) Double[] Translation vector list Cursor Whether use local coordinate or not True = 27:*, False = 0:0 Bool Create New Part bool flag True = 1, False = 0 Bool LBC Copy bool flag True = 1, False = 0 Int Copy count Return Code 1 Succeeded 0 Failed Sample Code TranslateBody([3:1], [[0.01, 0, 0]], 0:0, 1, 0, 1)
