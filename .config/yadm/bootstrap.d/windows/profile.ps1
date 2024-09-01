oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/powerlevel10k_rainbow.omp.json" | Invoke-Expression

Import-Module Terminal-Icons

Set-PSReadlineOption -MaximumHistoryCount 16284
Set-PSReadlineOption -PredictionSource HistoryAndPlugin
Set-PSReadlineOption -PredictionViewStyle ListView