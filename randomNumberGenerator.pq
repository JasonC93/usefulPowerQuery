//Used to generate random numbers while using recursion to ensure there are no duplicates committed
//Beware that it gets invoked each runtime in queries. If using in downstream queries, use another query that will take a result and make it static.

let    
    fxGenerateUniqueRandomNumbers_Exact = (count as number) as list =>
        let
            minValue = 1000000000000,
            maxValue = 1999999999999,

            // Recursive function to generate without duplicates
            Generate = (existing as list) =>
                let
                    newNumber = Number.RoundDown(Number.RandomBetween(minValue, maxValue)),
                    updatedList = if List.Contains(existing, newNumber) then existing else existing & {newNumber}
                in
                    if List.Count(updatedList) >= count then updatedList else @Generate(updatedList),

            Result = Generate({})
        in
            Result,

    barcodeList = Table.AddIndexColumn( Table.FromList( List.Transform( fxGenerateUniqueRandomNumbers_Exact( Product_Upload_Array_Size ), each Text.From( _ ) ), null, {"BARCODE"} ), "Index", 1, 1 )
  
in
    barcodeList
