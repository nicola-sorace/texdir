#!/bin/bash

CODE="/home/nicola/Documents/code/texdir"
SHELL="/bin/zsh -c"

# Creates a new LaTeX directory
function create_texdir {
  name="$1.texdir"
  
  echo "Creating new LaTeX directory \"$name\"..."
  if [ -d "./$name" ]; then
    >&2 echo "ERROR: Folder already exists"
    exit 1
  fi

  cp -r "$CODE/dir_template" "./$name"
  
  texdir=$(realpath $name)
}

# Asserts that the given path is a LaTeX directory
function assert_texdir {
  texdir=$1

  if [ -f "$texdir/document.tex" ] && [ -f "$texdir/compile.sh" ]; then
    return 0
  else
    return 1
  fi
}

# Starts an editor and live preview, after a delay
function delayed_doc_preview {
  sleep 5
  kitty --detach --directory "$texdir" $SHELL "$EDITOR $texdir/document.tex"
  zathura "$texdir/document.pdf" & disown
}

# Opens a LaTeX directory for editing
function edit_texdir {
  if [ $# -gt 0 ]; then
    texdir=$(realpath $1)
  else
    texdir=$(pwd)
  fi

  echo "Editing LaTeX directory at \"$texdir\"..."

  if ! assert_texdir $texdir; then
    >&2 echo "ERROR: This is not a valid LaTeX folder"
    exit 1
  fi

  $texdir/compile.sh & delayed_doc_preview
}

# Print usage to STDOUT
function show_help {
  echo "Usage:"
  echo "$0 [create/edit] [directory name]"
}


if [ $# -lt 1 ]; then
  show_help
  exit 1
fi

if [ "$1" = "create" ]; then
  if [ $# -lt 2 ]; then
    >&2 echo "ERROR: Please specify a name for the new document"
    show_help
    exit 1
  fi
  create_texdir $2
  exit 0
fi

if [ "$1" = "edit" ]; then
  edit_texdir $2
  exit 0
fi

show_help
exit 1
