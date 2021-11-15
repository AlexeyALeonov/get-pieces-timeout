param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)][array]$Lines
)

#################################
# Join two hashtables
#################################
# See https://stackoverflow.com/a/55090736
function Join-HashTableTree {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [hashtable]
        $SourceHashtable,

        [Parameter(Mandatory = $true, Position = 0)]
        [hashtable]
        $JoinedHashtable
    )

    $output = $SourceHashtable.Clone()

    foreach ($key in $JoinedHashtable.Keys) {
        $oldValue = $output[$key]
        $newValue = $JoinedHashtable[$key]

        $output[$key] =
        if ($oldValue -is [hashtable] -and $newValue -is [hashtable]) { $oldValue + $newValue }
        elseif ($oldValue -is [array] -and $newValue -is [array]) { $oldValue + $newValue }
        else { $newValue }
    }

    $output;
}

$report = @{}

$Lines | %{
    $line = $_ -split "`t";
    $body = $line[4] | ConvertFrom-Json;
    $date = $line[0]; 
    $operation = $line[3]; 
    $report = $report | Join-HashTableTree @{SatelliteID = $body."Satellite ID"; ($body."Piece ID") = @{($date) = $operation}}
}

$report | ConvertTo-Json
