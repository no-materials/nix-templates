# Nix templates

Templates are there to help you start your Nix project.

```console
$ nix flake init --template github:no-materials/nix-templates#rust-stable
```

or via specifying the destination directory

```console
$ nix flake new --template github:no-materials/nix-templates#rust-stable ./my-new-project
```

You can also use the template as a development shell:

```console
$ nix develop github:no-materials/nix-templates#rust-stable
```
