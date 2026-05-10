#!/bin/bash
# export-sdd-profiles.sh
# Extrae solo los perfiles SDD (orquestadores + sub-agentes) del opencode.json
# y los guarda en sdd-profiles.json para versionarlos en git.
#
# Uso: ./export-sdd-profiles.sh [opencode.json]
#   Si no se pasa ruta, busca en ~/.config/opencode/opencode.json

set -e

OPENCODE_JSON="${1:-$HOME/.config/opencode/opencode.json}"

if [ ! -f "$OPENCODE_JSON" ]; then
  echo "❌ No encuentro $OPENCODE_JSON"
  exit 1
fi

# Auto-detecta los nombres de perfiles: busca todos los sdd-orchestrator-*
PROFILES=$(jq -r '[.agent | keys[] | select(startswith("sdd-orchestrator-")) | sub("^sdd-orchestrator-"; "")] | join("|")' "$OPENCODE_JSON")

if [ -z "$PROFILES" ]; then
  echo "❌ No se encontraron perfiles SDD en $OPENCODE_JSON"
  exit 1
fi

echo "📡 Perfiles detectados: $(echo "$PROFILES" | tr '|' ' ')"

jq --arg names "$PROFILES" '
  .agent | with_entries(
    select(.key | test("^sdd-(apply|archive|design|explore|init|onboard|propose|spec|tasks|verify|orchestrator)-(" + $names + ")$"))
  )
' "$OPENCODE_JSON" > sdd-profiles.json

ENTRIES=$(jq 'length' sdd-profiles.json)
echo "✅ Exportados $ENTRIES agentes a sdd-profiles.json"
