# vps-builder

Deploy a Remnawave / Xray node to a VPS with Ansible.

## Setup

Create the local environment file and fill in the values:

```bash
cp .env.example .env
```

`.env` is local only and is not cloned from the repository, so create it on every machine.
Save it as UTF-8 without BOM. CRLF line endings are handled by `run.sh`.

| Variable | Purpose |
| --- | --- |
| `VPS_HOST` | Server IP address |
| `VPS_USER` | SSH user |
| `VPS_PASSWORD` | SSH password |
| `DOMAIN_NAME` | Domain for the SSL certificate |
| `ADMIN_EMAIL` | Email for Let's Encrypt |
| `NODE_SECRET_KEY` | Node secret key from the Remnawave panel |

Keep passwords and keys in single quotes (`VPS_PASSWORD='...'`) so bash does not interpret backslashes.

## Run

Run from WSL, Linux, or macOS (native Windows is not supported as an Ansible controller):

```bash
chmod +x run.sh
./run.sh
```

`run.sh` loads `.env` and runs `ansible-playbook -i hosts.ini playbook.yml`. Extra arguments are passed through, for example `./run.sh --check`.

## macOS

Install Ansible and `sshpass` (needed for password-based SSH on older Ansible versions):

```bash
brew install ansible sshpass
```

The full `ansible` package includes `community.general`, which provides the `ufw` module. If you use `ansible-core` instead, install the collection:

```bash
ansible-galaxy collection install community.general
```

`run.sh` works with the system bash 3.2 on macOS.

## Security

`.env` is listed in `.gitignore` and must never be committed or uploaded manually.
