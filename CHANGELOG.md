# v0.22
Added
- SSH CA trust installed on all hosts during bootstrap `ssh_ca_trust` role
- Vault configuration and seeding in `bootstrap.yml`
- Ephemeral SSH keys for Ansible with Vault, signed by Vault from `VAULT_TOKEN`
- Vault secret lookups in `group_vars` for day-1 runs 
