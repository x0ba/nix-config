#!/usr/bin/env python3
"""Archive superseded user installations after Home Manager is active."""
import json
import shutil
import sys
from pathlib import Path

user_home = Path.home()
backup = Path(sys.argv[1]).expanduser().resolve() / "retired"
profile = Path("/etc/profiles/per-user/daniel/bin")
for name in ["git", "nvim", "atuin", "starship", "direnv", "uv", "skl", "codex", "cursor-agent"]:
    target = (profile / name).resolve()
    if not target.is_file() or not str(target).startswith("/nix/store/"):
        raise SystemExit(f"Nix replacement unavailable: {name}")
if not (user_home / ".zshrc").is_symlink():
    raise SystemExit("Home Manager shell configuration must be active first")

paths = [
    ".gitconfig", ".zprezto", ".zcompdump", ".config/zsh/prezto-compat",
    ".config/fish/conf.d/atuin.env.fish", ".config/fish/conf.d/rustup.fish",
    ".config/fish/conf.d/vite-plus.fish", ".config/fish/functions/fish_jj_prompt.fish",
    ".tcshrc", ".config/mise", ".local/share/mise",
    "Library/LaunchAgents/dev.mise.mise-history.plist",
    ".local/bin/mise", ".local/bin/fx", ".local/bin/uv", ".local/bin/uvx",
    ".local/bin/skl", ".local/bin/skl.lock", ".local/bin/codex",
    ".local/bin/codex-code-mode-host", ".local/bin/cursor-agent", ".local/bin/agent",
    ".local/share/cursor-agent", ".codex/packages/standalone",
    ".cargo/bin", ".cargo/env", ".cargo/.crates.toml", ".cargo/.crates2.json",
    ".rustup", ".sdkman", ".vite-plus", ".atuin/bin",
    "Library/pnpm/bin", "Library/pnpm/global", ".config/uv/uv-receipt.json",
    ".config/nvim/lua", ".config/nvim/lazy-lock.json", ".config/nvim/lazyvim.json",
    ".local/share/nvim/lazy", ".local/share/nvim/mason",
    ".config/opencode/opencode.jsonc", ".config/opencode/tui.jsonc",
    ".config/opencode/cli.json", ".config/opencode/node_modules",
    ".config/opencode/package.json", ".config/opencode/package-lock.json",
    ".config/asciinema/defaults.toml", ".config/spicetify",
]
backup.mkdir(parents=True, exist_ok=True, mode=0o700)
manifest = backup / "manifest.json"
archived = json.loads(manifest.read_text()) if manifest.exists() else []
for relative in paths:
    source = user_home / relative
    if not source.exists() and not source.is_symlink():
        continue
    if source.is_symlink() and str(source.resolve()).startswith("/nix/store/"):
        raise SystemExit(f"Refusing to archive a Nix-managed path: {source}")
    destination = backup / relative
    if destination.exists() or destination.is_symlink():
        raise SystemExit(f"Backup already exists: {destination}")
    destination.parent.mkdir(parents=True, exist_ok=True)
    shutil.move(str(source), str(destination))
    archived.append(relative)
    print(relative)
manifest.write_text(json.dumps(archived, indent=2) + "\n")
