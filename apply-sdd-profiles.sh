#!/bin/bash
# apply-sdd-profiles.sh
# Inyecta los perfiles SDD de sdd-profiles.json en el opencode.json local.
# Hace backup antes de modificar.
#
# Uso: ./apply-sdd-profiles.sh [opencode.json]
#   Si no se pasa ruta, busca en ~/.config/opencode/opencode.json

set -e

OPENCODE_JSON="${1:-$HOME/.config/opencode/opencode.json}"
PROFILES_FILE="sdd-profiles.json"

if [ ! -f "$PROFILES_FILE" ]; then
  echo "❌ No encuentro $PROFILES_FILE"
  echo "   ¿Ejecutaste primero export-sdd-profiles.sh en la PC origen?"
  exit 1
fi

if [ ! -f "$OPENCODE_JSON" ]; then
  echo "❌ No encuentro $OPENCODE_JSON"
  echo "   ¿Ya corriste 'gentle-ai install --agent opencode'?"
  exit 1
fi

# Backup
cp "$OPENCODE_JSON" "${OPENCODE_JSON}.bak.$(date +%Y%m%d-%H%M%S)"
echo "💾 Backup creado"

# Merge profiles into the agent section
jq --slurpfile profiles "$PROFILES_FILE" '
  .agent += $profiles[0]
' "$OPENCODE_JSON" > "${OPENCODE_JSON}.tmp" && mv "${OPENCODE_JSON}.tmp" "$OPENCODE_JSON"

PROFILE_COUNT=$(jq 'length' "$PROFILES_FILE")
echo "✅ $PROFILE_COUNT agentes inyectados en $OPENCODE_JSON"
echo "   Abrí OpenCode y apretá Tab para cambiar entre perfiles."
