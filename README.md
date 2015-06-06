Application Rails Cookbook
===================

This cookbook is used to deploy rails applications and can build the structure for initial git deployments as well as Capistrano deployments.

Requirements
------------

#### Tested Operating Systems

- Ubuntu 12.04 LTS
- Ubuntu 14.04 LTS

#### Rails Gems

- `foreman`: Foreman is required to create init scripts

Attributes
----------

| Key                                                   | Type    | Description                                           | Default                              |
|:------------------------------------------------------|:--------|:------------------------------------------------------|:-------------------------------------|
| `['application_rails']['packages']`                   | Array   | List of packages required to run application          | (A lot)                              |
| `['application_rails']['app_name']`                   | String  | The name for the application                          | `app`                                |
| `['application_rails']['server_name']`                | String  | The name for the web front-end                        | `_`                                  |
| `['application_rails']['web_install']`                | Boolean | Whether to install NGINX or not on the server         | `true`                               |
| `['application_rails']['upstream_server_name']`       | String  | Name of the socket to look for in `/tmp`              | Calculated(`app_name`)               |
| `['application_rails']['ruby_install']`               | Boolean | Whether to install Ruby or not on the server          | `true`                               |
| `['application_rails']['ruby_version']`               | String  | The version number of ruby to install on the server   | `2.1.2`                              |
| `['application_rails']['user']`                       | String  | User to use for the application deployments           | `deploy`                             |
| `['application_rails']['group']`                      | String  | Group to use for the application deployments          | `deploy`                             |
| `['application_rails']['user_uid']`                   | Integer | UID of the user used for application deployments      | `nil`                                |
| `['application_rails']['group_gid']`                  | Integer | GID of the group that the deployment user uses        | `nil`                                |
| `['application_rails']['user_home']`                  | String  | Home directory for the deployment user                | `/home/deploy`                       |
| `['application_rails']['user_shell']`                 | String  | Shell for the deployment user                         | `/bin/bash`                          |
| `['application_rails']['install_location']`           | String  | Location for the application to be installed          | Calculated(`user_home` + `app_name`) |
| `['application_rails']['rails_env']`                  | String  | The application's `RAILS_ENV` variable                | `production`                         |
| `['application_rails']['rails_secret_key_base']`      | String  | The secret key base for the rails application         | `nil`                                |
| `['application_rails']['install_capistrano']`         | Boolean | Set up capistrano folder structure for deployments?   | `true`                               |
| `['application_rails']['capistrano_shared_folders']`  | Array   | Shared folders for capistrano                         | `%w{}`                               |
| `['application_rails']['capistrano_shared_database']` | Boolean | Use shared database configuration with capistrano?    | `true`                               |
| `['application_rails']['git_integration']`            | Boolean | Use git to fetch the latest code for the application? | `false`                              |
| `['application_rails']['git_deploy_key']`             | String  | Git deployment key (for private repositories)         | `nil`                                |
| `['application_rails']['git_repository']`             | String  | URL of the repository for Git (only SSH tested)       | `nil`                                |
| `['application_rails']['git_revision']`               | String  | Revision of the code to use for the initial set up    | `HEAD`                               |
| `['application_rails']['database_install']`           | Boolean | Install the database on the server?                   | `false`                              |
| `['application_rails']['database_type']`              | String  | The type of the database to use options: (postgres)   | `postgres`                           |
| `['application_rails']['database_hostname']`          | String  | Hostname of the database to add in the app DB config  | `localhost`                          |
| `['application_rails']['database_username']`          | String  | Username of the database to add in the app DB config  | `root`                               |
| `['application_rails']['database_password']`          | String  | Password of the database to add in the app DB config  | `change_me123`                       |
| `['application_rails']['database_database']`          | String  | DB name of the database to add in the app DB config   | `app`                                |
| `['application_rails']['database_port']`              | String  | Port of the database to add in the app DB config      | `5432`                               |

Usage
-----
#### application_rails::default
TODO: Write usage instructions for each cookbook.

Just include `application_rails` in your node's `run_list` and override any of the attributes that you need to change in your Chef JSON:

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
Authors: Nikko Miu (miu2n@nikkomiu.com)
