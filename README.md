# MSiBTY

MSiBTY stands for **My Setup is Better Than Yours**. It’s my collection of scripts and configuration files for bootstrapping a fresh development environment or updating an existing one on Arch Linux. The repository includes dotfiles, installation scripts, and configuration for a variety of tools and applications.

> Inspired by the Frontend Masters course [*My Dev Setup Is Better Than Yours*](https://frontendmasters.com/courses/developer-productivity-v2/) taught by [ThePrimeagen](https://github.com/ThePrimeagen).

## Environment

Currently supports **Arch Linux only** (Yes, I use Arch btw).

## Usage

There are two entry points:

- `env.sh` — applies system‑level settings and links/copies dotfiles
- `run.sh` — installs packages and applications

Both scripts accept a `--dry` flag and an optional `FILTER` argument:

```bash
./env.sh [--dry] [FILTER]
./run.sh [--dry] [FILTER]
```

### Options

- `--dry` — show the commands that would be executed without making any changes.
- `FILTER` — run only the steps whose names include this substring (useful for targeting a specific tool or group).

### Examples

```bash
# Preview everything without changing your system
./run.sh --dry

# Apply only the steps related to "neovim"
./env.sh neovim
./run.sh neovim
```

