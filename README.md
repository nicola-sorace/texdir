# TexDir (Early WIP)

This project provides a simple BASH script to facilitate working with LaTeX documents. Documents are treated as a 'LaTeX directory' rather than a single LaTeX file. This folder contains the '.tex' file, as well as the outputted PDF and any other relevant files. Current features are quickly creating a new document from a template, and quickly editing a document with a live preview.

# Setup

Make sure the `$EDITOR` environment variable is set to the desired editor.

Edit the `texdir.sh` with appropriate values for the current machine:

 - The `CODE` constant should point to the folder that contains the `dir_template` folder (this is the template that will be copied for new directories).

 - The `SHELL` constant is the shell to run the editor in (default script uses ZSH).

 - Change the `delayed_doc_preview` function to match the desired terminal emulator (default script uses Kitty).

# Usage

Run the script without arguments to see usage instructions.

To create a new document:

`texdir.sh create [document name]`

To edit a document:

`texdir.sh edit [LaTeX directory]`

The directory can be omitted if it is the current directory.

