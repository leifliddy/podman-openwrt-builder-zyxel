#!/usr/bin/python3

import os


cur_dir                 = os.path.dirname(os.path.realpath(__file__))

image_name              = 'openwrt_build_env'
container_name          = 'openwrt_builder'
container_hostname      = 'openwrt_builder'
container_script        = '/root/scripts/01-build.openwrt.sh'

scripts_dir_host        = f'{cur_dir}/build.scripts'
scripts_dir_container   = '/root/scripts'
output_dir_host         = f'{cur_dir}/output'
output_dir_container    = '/output'
profiles_dir_host       = f'{cur_dir}/profiles'
profiles_dir_container  = '/root/profiles'

# used in debug output
podman_vol_str          = f'-v {scripts_dir_host}:{scripts_dir_container} -v {output_dir_host}:{output_dir_container} -v {profiles_dir_host}:{profiles_dir_container}'

# ensure bind mounted directories have the container_file_t label set
mount_dirs_selinux = [scripts_dir_host, output_dir_host, profiles_dir_host]

bind_volumes = []
bind_volumes.append({'source': f'{scripts_dir_host}', 'target': f'{scripts_dir_container}', 'type': 'bind'})
bind_volumes.append({'source': f'{output_dir_host}', 'target': f'{output_dir_container}', 'type': 'bind'})
bind_volumes.append({'source': f'{profiles_dir_host}', 'target': f'{profiles_dir_container}', 'type': 'bind'})
