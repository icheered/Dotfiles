# Shells

There is some issues getting some packages to work like Prisma.

Place `.envrc` in the project root containing:

```
use nix
```

Then place a `shell.nix` in the project root with the content from any .nix file in this directory. Then run `direnv allow` to enable direnv.

Now everytime you enter that directory you should get the shell.
