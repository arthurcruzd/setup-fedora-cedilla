#!/usr/bin/env bash
#
# setup-fedora-cedilla.sh
# One-command setup for Portuguese ç + English contractions on Fedora + GNOME (Wayland)
# Uses fcitx5 (best for Electron apps) + custom ~/.XCompose
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/setup-fedora-cedilla.sh | bash
#
# Or clone and run locally:
#   ./setup-fedora-cedilla.sh
#
set -euo pipefail

echo "=========================================="
echo "  Fedora Cedilla + Contractions Setup"
echo "  (fcitx5 + Wayland + Electron friendly)"
echo "=========================================="
echo

# 1. Install fcitx5 if missing
if ! command -v fcitx5 &> /dev/null; then
    echo "→ fcitx5 not found. Installing..."
    sudo dnf install -y fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt
    echo "✓ fcitx5 installed"
else
    echo "✓ fcitx5 already installed"
fi

# 2. Create environment config (safely)
echo "→ Creating fcitx5 environment config..."
sudo mkdir -p /etc/environment.d
sudo tee /etc/environment.d/90-fcitx5.conf > /dev/null <<'EOF'
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
EOF
echo "✓ Environment variables set"

# 3. Backup and create ~/.XCompose
if [ -f ~/.XCompose ]; then
    BACKUP=~/.XCompose.backup.$(date +%Y%m%d-%H%M%S)
    cp ~/.XCompose "$BACKUP"
    echo "→ Backed up existing ~/.XCompose to $BACKUP"
fi

cat > ~/.XCompose << 'EOF'
include "%L"

# ============================================
# Portuguese cedilla - Mac-like behavior
# ============================================
<dead_acute> <c> : "ç"
<dead_acute> <C> : "Ç"

# ============================================
# English contractions (prevent ḿ, ń, ś, etc.)
# ============================================
<dead_acute> <m> : "'m"
<dead_acute> <M> : "'M"
<dead_acute> <t> : "'t"
<dead_acute> <T> : "'T"
<dead_acute> <s> : "'s"
<dead_acute> <S> : "'S"
<dead_acute> <l> : "'l"
<dead_acute> <L> : "'L"
<dead_acute> <v> : "'v"
<dead_acute> <V> : "'V"
<dead_acute> <d> : "'d"
<dead_acute> <D> : "'D"
<dead_acute> <r> : "'r"
<dead_acute> <R> : "'R"
<dead_acute> <n> : "'n"

# Extra letters for rare cases (o'clock, 'cause, etc.)
<dead_acute> <b> : "'b"
<dead_acute> <B> : "'B"
<dead_acute> <f> : "'f"
<dead_acute> <F> : "'F"
<dead_acute> <g> : "'g"
<dead_acute> <G> : "'G"
<dead_acute> <h> : "'h"
<dead_acute> <H> : "'H"
<dead_acute> <k> : "'k"
<dead_acute> <K> : "'K"
<dead_acute> <p> : "'p"
<dead_acute> <P> : "'P"
<dead_acute> <w> : "'w"
<dead_acute> <W> : "'W"
EOF
echo "✓ ~/.XCompose created with Portuguese + English support"

echo
echo "=========================================="
echo "  ✅ Setup complete!"
echo "=========================================="
echo
echo "Next steps:"
echo "  1. Log out completely and log back in"
echo "  2. Test in terminal and VS Code:"
echo "       ' + c   → ç"
echo "       I ' m   → I'm"
echo "       don ' t → don't"
echo
echo "If you want to revert later, just delete:"
echo "  /etc/environment.d/90-fcitx5.conf"
echo "  ~/.XCompose"
