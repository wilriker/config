# You can override some default right prompt options in your config.fish:
#     set -g theme_date_format "+%a %H:%M"

function __cmd_duration -S -d 'Show command duration'
    test "$CMD_DURATION" -lt 100; and return

    set -l duration
    if test "$CMD_DURATION" -lt 5000
        set duration $CMD_DURATION 'ms '
    else
        set -l one_second      1000
        set -l one_minute     60000
        set -l one_hour     3600000

        set duration (math "($CMD_DURATION%$one_minute)/$one_second") 's '

        if test "$CMD_DURATION" -ge $one_minute
            set_color $fish_color_error
            set duration (math "($CMD_DURATION%$one_hour)/$one_minute") 'm ' $duration
        end

        if test "$CMD_DURATION" -ge $one_hour
            set duration (math "$CMD_DURATION/$one_hour") 'h ' $duration
        end
    end

    echo -ns $duration
    set_color $fish_color_normal
    set_color $fish_color_autosuggestion
    echo -n $__left_arrow_glyph
end

function __timestamp -S -d 'Show the current timestamp'
    set -q theme_date_format; or set -l theme_date_format "+%c"

    echo -n ' '
    date $theme_date_format
end

function fish_right_prompt -d 'bobthefish is all about the right prompt'
    set -l __left_arrow_glyph \uE0B3

    set_color $fish_color_autosuggestion

    __cmd_duration
    __timestamp
    set_color normal
end
