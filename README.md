# TheCodeCrate's Devcontainer Features

A collection of DevContainer features for TheCodeCrate projects.

## Available Features

| Feature | Documentation | Description |
| ---  | --- | ---         |
| UV | [Official UV Docs](https://docs.astral.sh/uv/) | A fast Python package manager written in Rust. Replaces pip, poetry, virtualenv, and more. |
| Bash Aliases | [Bash Aliases](./src/bash-aliases) | Loads custom bash aliases from your project's `.devcontainer/etc/bash-aliases` directory. |

## Usage Examples

### UV Package Manager

Install UV in your devcontainer:

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/thecodecrate/devcontainer-features/uv:1": {}
    }
}
```

Verify installation:

```bash
uv --version
```

### Bash Aliases

Create a `.devcontainer/etc/bash-aliases` directory in your project and add your custom aliases:

```bash
# .devcontainer/etc/bash-aliases
alias hello="echo 'Hello, World!'"
```

Load the aliases in your devcontainer:

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/thecodecrate/devcontainer-features/bash-aliases:1": {}
    }
}
```
