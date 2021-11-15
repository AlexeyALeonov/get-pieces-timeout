# Get-PiecesTimeout.ps1

This script allows you to get pieces download/upload report based on the logs from the storagenode.

Perhaps it's better to use `jq` from the [wsl/wsl2](https://docs.microsoft.com/en-us/windows/wsl/) for performance reasons, see [Using bash/wsl](#using-bashwsl) below.

## Configure PowerShell execution policy
In the elevated PowerShell
```
Set-ExecutionPolicy RemoteSigned
```
If it would be not enought, then
```
Set-ExecutionPolicy Unrestricted
```

## Usage
```
@(sls "GET_AUDIT|GET_REPAIR" X:\storagenode3\storagenode.log) | .\Get-PiecesTimeout.ps1
```
or
```
.\Get-PiecesTimeout.ps1 @(sls "GET_AUDIT|GET_REPAIR" X:\storagenode3\storagenode.log)
```

# Using bash/wsl
See https://forum.storj.io/t/got-disqualified-from-saltlake/14848/97?u=alexey
```
cat /mnt/x/storagenode3/storagenode.log | grep 1wFTAgs9DP5RSnCqKV1eLf6N9wtk4EAtmN5DpSxcs8EjT69tGE | grep -E "GET_AUDIT|GET_REPAIR" | jq -R '. | split("\t") | (.[4] | fromjson) as $body | {($body."Satellite ID"): {($body."Piece ID"): {(.[0]): .[3]}}}' | jq -s 'reduce .[] as $item ({}; . * $item)'

```