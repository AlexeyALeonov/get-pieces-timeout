# get-pieces-timeout

This script allows to get pieces download/upload report based on the logs from the storagenode.

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
sls "GET_AUDIT|GET_REPAIR" X:\storagenode3\storagenode.log | Get-PiecesTimeout.ps1
```