#!/bin/bash
# bootstrap-dev.sh
# Instala OpenCode + Gentle AI + perfiles SDD en una PC nueva.
#
# Uso: ./bootstrap-dev.sh
#   Cloná este repo en la máquina nueva y ejecutá este script.

set -e

echo "╔══════════════════════════════════════════════╗"
echo "║     🚀 Bootstrap Dev Environment             ║"
echo "╚══════════════════════════════════════════════╝"

# ─── OpenCode ───────────────────────────────────────
if ! command -v opencode &>/dev/null; then
  echo ""
  echo "==> Instalando OpenCode..."
  curl -fsSL https://opencode.jetpack.io/install.sh | bash
else
  echo "✅ OpenCode ya instalado"
fi

# ─── Gentle AI ──────────────────────────────────────
if ! command -v gentle-ai &>/dev/null; then
  echo ""
  echo "==> Instalando Gentle AI..."
  
  # Intenta brew primero, sino go install
  if command -v brew &>/dev/null; then
    brew tap Gentleman-Programming/homebrew-tap
    brew install gentle-ai
  else
    echo "   brew no disponible, usando go install..."
    go install github.com/gentleman-programming/gentle-ai/cmd/gentle-ai@latest
  fi
else
  echo "✅ Gentle AI ya instalado"
fi

# ─── SDD Ecosystem ──────────────────────────────────
echo ""
echo "==> Instalando SDD ecosystem en OpenCode..."
gentle-ai install --agent opencode --preset full-gentleman

# ─── Perfiles SDD ──────────────────────────────────
echo ""
echo "==> Aplicando perfiles SDD..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if [ -f sdd-profiles.json ]; then
  bash apply-sdd-profiles.sh
else
  echo "⚠️  No hay sdd-profiles.json. Exportalo primero con export-sdd-profiles.sh"
fi

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║     ✅  Listo!                               ║"
echo "║                                             ║"
echo "║  Abrí OpenCode y apretá Tab para cambiar     ║"
echo "║  entre perfiles SDD.                         ║"
echo "╚══════════════════════════════════════════════╝"
