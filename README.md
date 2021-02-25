# Primitives digger

![GitHub last commit](https://img.shields.io/github/last-commit/SEA-group/Primitives-Digger)
![GitHub issues](https://img.shields.io/github/issues-raw/SEA-group/Primitives-Digger)

By AstreTunes @ SEA group

These scripts can add a pair of vertex and indice sections into a bunch of *.primitives* files, you can use them to add a new renderSet. By default only a simple triangle is added.

## How to use
1. Put your *.primitives* files into `Queue/`
2. Open `Main.m`. In "%% Parameters" part, assign the new section name, toggle "wire" vertex type and toggle "list32" triangle list type. The "skinned" property will be detected by the script automaticaly. You can add several sections at once by adding multple items in *chunkList{}*.
3. Run `Main.m`
4. New *.primitives* files will appear in  `Output/`, original *.primitives* files will stay intact in `Queue/`.
