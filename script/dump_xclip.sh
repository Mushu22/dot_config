#!/bin/bash
echo -n "clipboard: <"
xclip -selection clipboard -o
echo ">"

echo -n "primary: <"
xclip -selection primary -o
echo ">"

echo -n "secondary: <"
xclip -selection secondary -o
echo ">"


