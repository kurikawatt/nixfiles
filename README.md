# Nixfiles

This is my daily NixOS configuration, I use it on both clients & servers.

If you ended up here, you either : try to help me (thanks) or looks for doing some stuff, anyways, take a look.

## Hosts

All hosts are named after Persona characters, except `euphausia` who comes from the best game of 2024 : Metaphor ReFantazio.

Secrets are stored using `sops` and the `sops-nix` modules.

### Clients

| Host | Model | Features |
| --- | --- | --- |
| `euphausia` | Framework 16 - AMD 7040 Series, RX 7700S GPU | SecureBoot, TPM2, Disk Encryption (disko) |
| `queen` | Custom | / |
| `aigis` | Dell Inspirion 5515 | / |

### Servers

| Host | Model | Features |
| --- | --- | --- |
| `metis` | Lenovo Thinkcentre M910Q | / |
| `fuuka` (unused) | Raspberry Pi 4B (8GB) | / |
| `chord` | Custom | / |
| `marian` (unused) | / | / |
| `violet` (unused) | OVH VPS | Some VPS stuffs, i guess |

## Services

I host a few services, often exposed as services on my tailnet.

- Attic Cache
- Jellyfin
- Prowlarr + Sonarr + Radarr + Deluge
- Restic Backups
- Syncthing