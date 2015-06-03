Application Rails Cookbook
===================
TODO: Enter the cookbook description here.

e.g.
This cookbook makes your favorite breakfast sandwich.

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
#### packages
- `toaster` - application_rails needs toaster to brown your bagel.

Attributes
----------

| Key                                                   | Type    | Description                                         | Default  |
|:------------------------------------------------------|:--------|:----------------------------------------------------|:---------|
| `['application_rails']['packages']`                   | Array   | List of packages required to run application        | (A lot)  |
| `['application_rails']['app_name']`                   | String  | The name for the application                        | `app`    |
| `['application_rails']['server_name']`                | String  | The name for the web front-end                      | `_`      |
| `['application_rails']['web_install']`                | Boolean | Whether to install NGINX or not on the server       | `true`   |
| `['application_rails']['upstream_server_name']`       | String  | Name of the socket to look for in `/tmp`            | `app`    |
| `['application_rails']['ruby_install']`               | Boolean | Whether to install Ruby or not on the server        | `true`   |
| `['application_rails']['ruby_version']`               | String  | The version number of ruby to install on the server | `2.1.2`  |
| `['application_rails']['user']`                       | String  | User to use for the application deployments         | `deploy` |
| `['application_rails']['group']`                      | String  | Group to use for the application deployments        | `deploy` |
| `['application_rails']['user_uid']`                   |         |                                                     |          |
| `['application_rails']['group_gid']`                  |         |                                                     |          |
| `['application_rails']['user_home']`                  |         |                                                     |          |
| `['application_rails']['user_shell']`                 |         |                                                     |          |
| `['application_rails']['install_location']`           |         |                                                     |          |
| `['application_rails']['rails_env']`                  |         |                                                     |          |
| `['application_rails']['rails_secret_key_base']`      |         |                                                     |          |
| `['application_rails']['install_capistrano']`         |         |                                                     |          |
| `['application_rails']['capistrano_shared_folders']`  |         |                                                     |          |
| `['application_rails']['capistrano_shared_database']` |         |                                                     |          |
| `['application_rails']['git_integration']`            |         |                                                     |          |
| `['application_rails']['git_deploy_key']`             |         |                                                     |          |
| `['application_rails']['git_repository']`             |         |                                                     |          |
| `['application_rails']['git_revision']`               |         |                                                     |          |
| `['application_rails']['database_install']`           |         |                                                     |          |
| `['application_rails']['database_type']`              |         |                                                     |          |
| `['application_rails']['database_hostname']`          |         |                                                     |          |
| `['application_rails']['database_username']`          |         |                                                     |          |
| `['application_rails']['database_password']`          |         |                                                     |          |
| `['application_rails']['database_database']`          |         |                                                     |          |
| `['application_rails']['database_port']`              |         |                                                     |          |

Usage
-----
#### application_rails::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `application_rails` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[application_rails]"
  ]
}
```

License and Authors
-------------------
Authors: TODO: List authors
