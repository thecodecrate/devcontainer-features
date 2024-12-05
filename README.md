# TheCodeCrate's Devcontainer Features

A collection of DevContainer features for TheCodeCrate projects.

## Available Features

| Feature | Documentation | Description |
| ---  | --- | ---         |
| UV | [Official UV Docs](https://docs.astral.sh/uv/) | A fast Python package manager written in Rust. Replaces pip, poetry, virtualenv, and more. |

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

