# SDD Profiles

Perfiles SDD de Gentle AI para OpenCode — versionados y sync entre PCs.

## Workflow

### PC origen (donde ya tenés los perfiles configurados)

```bash
# 1. Exportar los perfiles actuales a sdd-profiles.json
./export-sdd-profiles.sh

# 2. Commitear
git add sdd-profiles.json
git commit -m "feat: export SDD profiles"
git push
```

### PC nueva

```bash
# 1. Clonar el repo
git clone <este-repo>
cd sdd-profiles

# 2. Bootstrap completo (instala OpenCode + Gentle AI + perfiles)
./bootstrap-dev.sh

# O manual si ya tenés OpenCode y Gentle AI:
./apply-sdd-profiles.sh
```

## Scripts

| Script | Qué hace |
|--------|----------|
| `export-sdd-profiles.sh` | Extrae solo los agentes de perfil SDD del `opencode.json` local |
| `apply-sdd-profiles.sh` | Inyecta los perfiles en el `opencode.json` de la máquina |
| `bootstrap-dev.sh` | Instalación completa + aplicación de perfiles |
| `sdd-profiles.json` | Los perfiles exportados (versionar en git) |

## ¿Cómo actualizar los perfiles?

1. En cualquier PC modificás los modelos con `gentle-ai sync --profile ...`
2. Corrés `./export-sdd-profiles.sh`
3. Commit + push del `sdd-profiles.json` actualizado
4. En las otras PCs: `git pull && ./apply-sdd-profiles.sh`
