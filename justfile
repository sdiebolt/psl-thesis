version := "0.1.0"
commit_hash := `git rev-parse --short HEAD`
typst := "typst"
imagemagick := "convert"

# Show this help message.
@help:
    just --list

# Symlink the package to the local package directory.
@local:
    rm -rf ~/.local/share/typst/packages/local/psl-thesis/{{version}}
    mkdir -p ~/.local/share/typst/packages/local/psl-thesis
    ln -s $(pwd) ~/.local/share/typst/packages/local/psl-thesis/{{version}}

# Build the template.
@template: local
    sed -i 's/@preview\/psl-thesis/@local\/psl-thesis/' template/main.typ
    {{typst}} compile template/main.typ
    sed -i 's/@local/@preview/' template/main.typ
    {{imagemagick}} -density 150 template/main.pdf[0] thumbnail.png
