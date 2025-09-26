let
      //Just a sample source from the existing worknbook, set to whatever your source is.
    Source = Excel.CurrentWorkbook(){[Name="SizeRanges"]}[Content],

    //TODO => Include step to normalise the column names also. Standard Upper & Trim
    normaliseColNames = Table.TransformColumnNames( Source, each Text.Upper( Text.Trim( _ ) ) ),

    normaliseData = Table.TransformColumns(
        normaliseColNames,
        {
            { "SIZE RANGES", each Text.Trim( Text.From( _ ) ) }
        }
    ),

        //Assigns type text to all columns in the table
    desiredDataType = type text,
    listForAssignTypes = List.Zip( { Table.ColumnNames(normaliseData), List.Repeat( {desiredDataType}, Table.ColumnCount( normaliseData ))}),
    assignDataTypes = Table.TransformColumnTypes( normaliseData, listForAssignTypes )

in
    assignDataTypes
