# Add color to the prompt
function prompt  
{  
    $ESC = [char]27
    $reset = "$ESC[0m"
    $bg_dark_gray = "$ESC[48;2;18;18;18m"
    $fg_gray = "$ESC[38;2;224;224;224m"
    $fg_green = "$ESC[38;2;0;204;0m"
    $fg_blue = "$ESC[38;2;0;128;255m"
    #"PS $ESC[32m$($executionContext.SessionState.Path.CurrentLocation)$ESC[0m$('>' * ($nestedPromptLevel + 1)) "
    "${bg_dark_gray}${fg_gray}PS ${fg_blue}$($executionContext.SessionState.Path.CurrentLocation)${fg_gray}$('>' * ($nestedPromptLevel + 1))${reset} "
}
