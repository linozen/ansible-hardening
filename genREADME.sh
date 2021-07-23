#!/bin/sh

if [ -z "${ANSIBLE_V}" ]; then
  ANSIBLE_V=2.10
fi

{
echo "# Hardening - the Ansible role

An [Ansible](https://www.ansible.com/) role to make a CentOS, Debian, RHEL,
or Ubuntu server a bit more secure,
[systemd edition](https://freedesktop.org/wiki/Software/systemd/).

Requires Ansible >= ${ANSIBLE_V}.

Available on
[Ansible Galaxy](https://galaxy.ansible.com/konstruktoid/hardening).

\`\`\`console
Do not use this role without first testing in a non-operational environment.
\`\`\`

[CentOS 8](https://www.centos.org),
[Debian 10](https://www.debian.org/),
[RHEL 8](https://www.redhat.com/en/enterprise-linux-8) and
[Ubuntu 20.04](https://ubuntu.com/) are supported platforms.

[CentOS Stream](https://www.centos.org/centos-stream/),
[Debian 11](https://wiki.debian.org/DebianBullseye),
[Ubuntu 21.04](https://releases.ubuntu.com/21.04/) and
[Ubuntu 21.10](https://wiki.ubuntu.com/Releases) are in a testing phase.

## Dependencies

None.

## Examples

### Playbook

\`\`\`yaml
---
- hosts: localhost
  any_errors_fatal: true
  tasks:
    - name: include the hardening role
      include_role:
        name: konstruktoid.hardening
      vars:
        block_blacklisted: true
        sshd_admin_net:
          - 10.0.2.0/24
          - 192.168.0.0/24
          - 192.168.1.0/24
        suid_sgid_permissions: false
...
\`\`\`

### ansible-pull with git checkout

\`\`\`yaml
---
- hosts: localhost
  any_errors_fatal: true
  tasks:
    - name: install git
      become: 'yes'
      package:
        name: git
        state: present

    - name: checkout konstruktoid.hardening
      become: 'yes'
      ansible.builtin.git:
        repo: 'https://github.com/konstruktoid/ansible-role-hardening'
        dest: /etc/ansible/roles/konstruktoid.hardening
        version: master

    - name: include the hardening role
      include_role:
        name: konstruktoid.hardening
      vars:
        block_blacklisted: true
        sshd_admin_net:
          - 10.0.2.0/24
          - 192.168.0.0/24
          - 192.168.1.0/24
        suid_sgid_permissions: false
...
\`\`\`

## Note regarding Debian family UFW firewall rules

Instead of resetting \`ufw\` every run and by doing so causing network traffic
disruption, the role deletes every \`ufw\` rule without
\`comment: ansible managed\` task parameter and value.

The role also sets default deny policies, which means that firewall rules
needs to be created for any additional ports except those specified in
the \`sshd_port\` and \`ufw_outgoing_traffic\` variables.

## Task Execution and Structure

See [STRUCTURE.md](STRUCTURE.md) for a detailed map regarding all tasks
and the role structure.

## Role testing

See [TESTING.md](TESTING.md).
"
echo '## Role Variables with defaults'

for variables in $(find ./defaults -type f | sort); do
  echo; echo "### $variables"
  echo
  echo '```yaml'
  grep -vE '^#|---|\.\.\.' "$variables"
  echo '```'
done

echo
echo "## Recommended Reading

[Comparing the DISA STIG and CIS Benchmark values](https://github.com/konstruktoid/publications/blob/master/ubuntu_comparing_guides_benchmarks.md)

[Center for Internet Security Linux Benchmarks](https://www.cisecurity.org/cis-benchmarks/)

[Common Configuration Enumeration](https://nvd.nist.gov/cce/index.cfm)

[DISA Security Technical Implementation Guides](https://public.cyber.mil/stigs/downloads/?_dl_facet_stigs=operating-systems%2Cunix-linux)

[SCAP Security Guides](https://static.open-scap.org/)

[Security focused systemd configuration](https://github.com/konstruktoid/hardening/blob/master/systemd.adoc)

## Contributing

Do you want to contribute? Great! Contributions are always welcome,
no matter how large or small. If you found something odd, feel free to submit a
issue, improve the code by creating a pull request, or by
[sponsoring this project](https://github.com/sponsors/konstruktoid).

## License

Apache License Version 2.0

## Author Information

[https://github.com/konstruktoid](https://github.com/konstruktoid \"github.com/konstruktoid\")"
} > ./README.md

rm ./*.log ./*.html ./*.list

{
echo "# Task Execution and Structure

## Tasks

![Alt text](./images/ansible-role-hardening.svg)

## Structure
"

echo '```sh'
tree .
echo '```'
} > ./STRUCTURE.md
