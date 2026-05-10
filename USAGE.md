# Mini guía de uso

## 🖥️ En la PC con los perfiles configurados

Cuando crees o modifiques perfiles con `gentle-ai sync --profile ...`:

```bash
cd ~/sdd-profiles
./export-sdd-profiles.sh        # extrae perfiles a sdd-profiles.json
git add sdd-profiles.json
git commit -m "feat: update SDD profiles"
git push
```

## 🆕 En una PC nueva

Primera vez:

```bash
git clone https://github.com/nahuel893/sdd-profiles.git
cd sdd-profiles
./bootstrap-dev.sh               # instala OpenCode + Gentle AI + perfiles
```

## 📥 Actualizar perfiles en otra PC

```bash
cd ~/sdd-profiles
git pull
./apply-sdd-profiles.sh          # inyecta los perfiles actualizados
```

## ❓ ¿Qué hace cada script?

| Script | Qué hace |
|--------|----------|
| `export-sdd-profiles.sh` | Toma tu `opencode.json` local y extrae solo los agentes de perfil SDD |
| `apply-sdd-profiles.sh` | Toma el `sdd-profiles.json` y lo fusiona en tu `opencode.json` local (hace backup) |
| `bootstrap-dev.sh` | Automatiza: instalar OpenCode → instalar Gentle AI → aplicar perfiles |

## ⚠️ Notas

- `apply-sdd-profiles.sh` hace backup del `opencode.json` antes de tocarlo
- Si ejecutás `gentle-ai sync` sin `--profile`, los perfiles NO se borran — sync solo actualiza prompts y assets
- Si creás un perfil NUEVO con `gentle-ai sync --profile`, acordate de re-exportar y committear
