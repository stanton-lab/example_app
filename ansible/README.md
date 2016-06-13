# How to use

First you need copy `config.yml.sample` to `config.yml` and set config variables.

You also need copy `hosts.sample` to `hosts` and specify the IP-address in `hosts`.

Then you need install general environment:

    ansible-playbook init.yml

And then install one of these environments:

## Rails + PostgreSQL environment:

    ansible-playbook rails-pg.yml
