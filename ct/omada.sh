#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/build.func)

APP="Omada"
var_tags="tp-link;controller"
var_cpu="2"
var_ram="2048"
var_disk="8"
var_os="debian"
var_version="12"
var_unprivileged="1"

header_info "$APP"
variables
color
catch_errors

function update_script() {
  header_info
  check_container_storage
  check_container_resources
  if [[ ! -d /opt/tplink ]]; then
    msg_error "No ${APP} Installation Found!"
    exit
  fi
  
  omada_url="https://static.tp-link.com/2020/202007/20200713/Omada_SDN_Controller_v4.1.5_linux_x64.deb"
  omada_version="Omada_SDN_Controller_v4.1.5_linux_x64.deb"
  
  echo -e "Downloading Omada Controller 4.1.5"
  wget -qL ${omada_url}
  
  echo -e "Installing Omada Controller 4.1.5"
  dpkg -i ${omada_version}
  
  rm -rf ${omada_version}
  echo -e "Installed Omada Controller 4.1.5"
  exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${CREATING}${GN}${APP} setup has been successfully initialized!${CL}"
echo -e "${INFO}${YW} Access it using the following URL:${CL}"
echo -e "${TAB}${GATEWAY}${BGN}https://${IP}:8043${CL}"
