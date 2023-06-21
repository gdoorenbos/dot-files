# Adding a profile:
# * Check for profile:
#     Test-Item $profile
# * If false, create it:
#     New-item –type file –force $profile
# * Enable running scripts:
#     Set-ExecutionPolicy RemoteSigned

# Add color to the prompt
# Uses ANSI escape codes
function prompt {
    # format helpers
    # https://tintin.mudhalla.net/info/256color/
    $ESC = [char]27
    $reset = "$ESC[0m"
    $bg_dark_gray = "$ESC[48;2;28;28;28m"
    $fg_gray = "$ESC[38;2;192;192;192m"
    $fg_green = "$ESC[38;2;0;204;0m"
    $fg_blue = "$ESC[38;2;0;128;255m"
    $fg_red = "$ESC[38;2;255;87;87m"
    $newline = "${reset}`n"

    # data gathering
    $is_last_cmd_good = $?
    $date = $(Get-Date -format 'ddd MMM dd hh:mm tt')
    $curr_loc = $($executionContext.SessionState.Path.CurrentLocation)
    $nested_arrow = $('>' * ($nestedPromptLevel + 1))
    $last_cmd = $(if ($is_last_cmd_good) {[char]0x00b0} else {[char]0x00d7})

    # color application
    $bg_prompt = "${bg_dark_gray}"
    $shell = "${fg_gray}PS"
    $date = "${fg_gray}[${date}]"
    $curr_loc = "${fg_blue}${curr_loc}"
    $nested_arrow = "${fg_gray}${nested_arrow}"
    $last_cmd = "$(if ($is_last_cmd_good) {$fg_green} else {$fg_red})${last_cmd}"

    # put it all together
    "${bg_prompt}${last_cmd} ${shell} ${date} ${curr_loc}${newline}" `
    + "${bg_prompt}${nested_arrow}${reset} "
}

# returns the current powershell version
function get-ps-version {
    $PSVersionTable.PSVersion -join '.'
}

# helper function to reload the path without having to shutdown and reopen the window
function refresh-path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" `
    + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# helper for testing colors
# https://tintin.mudhalla.net/info/256color/
function test-color ($r, $g, $b) {
    $ESC = [char]27
    $reset = "$ESC[0m"
    $fg = "$ESC[38;2;${r};${g};${b}m"
    "${fg}abcdefgh${reset}"
}

# Measure runtime of command:
# Measure-Command { Command-Under-Test | Out-Default }
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/measure-command?view=powershell-5.1
