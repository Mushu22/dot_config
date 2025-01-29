#!/bin/bash
echo -n "Reset clipboard" | xclip -selection clipboard -i
echo -n "Reset primary" | xclip -selection primary -i
echo -n "Reset secondary" | xclip -selection secondary -i
