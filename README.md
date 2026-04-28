# Fedora Cedilla Setup

One-command setup for Portuguese `ç` and English contractions on Fedora + GNOME Wayland.

It installs and configures `fcitx5`, then writes a custom `~/.XCompose` so:

- `' + c` produces `ç`
- `I ' m` produces `I'm`
- `don ' t` produces `don't`

## Run

```bash
./setup-fedora-cedilla.sh
```

After publishing this repository to GitHub, the raw install command will be:

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/setup-fedora-cedilla/main/setup-fedora-cedilla.sh | bash
```

## Revert

Delete these files:

```bash
sudo rm /etc/environment.d/90-fcitx5.conf
rm ~/.XCompose
```
