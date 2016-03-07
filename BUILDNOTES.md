
# Building text-icu on Windows

Stack includes a copy of msys2 on Windows, which contains the pacman package manager, so we can run:

stack exec -- pacman -Sy mingw64/mingw-w64-x86_64-icu
stack build text-icu

Source: http://stackoverflow.com/a/34542892

# RDF4H

It has some weird depedency flags... see stack.yaml