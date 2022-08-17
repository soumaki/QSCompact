#!/sbin/sh

###########################
# MMT Reborn Logic
###########################

############
# Config Vars
############

# Set this to true if you want to skip mount for your module
SKIPMOUNT="false"
# Set this to true if you want to clean old files in module before injecting new module
CLEANSERVICE="false"
# Set this to true if you want to load vskel after module info print. If you want to manually load it, consider using load_vksel function
AUTOVKSEL="true"
# Set this to true if you want store debug logs of installation
DEBUG="true"

############
# Replace List
############

# List all directories you want to directly replace in the system
# Construct your list in the following example format
REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"
# Construct your own list here
REPLACE="
/system/priv-app/AsusLauncherDev
/system/priv-app/Lawnchair
/system/priv-app/NexusLauncherPrebuilt
/system/product/priv-app/ParanoidQuickStep
/system/product/priv-app/ShadyQuickStep
/system/product/priv-app/TrebuchetQuickStep
/system/product/priv-app/NexusLauncherRelease
/system/product/overlay/PixelLauncherIconsOverlay
/system/system_ext/priv-app/NexusLauncherRelease
/system/system_ext/priv-app/DerpLauncherQuickStep
/system/system_ext/priv-app/TrebuchetQuickStep
/system/system_ext/priv-app/Lawnchair
/system/system_ext/priv-app/PixelLauncherRelease
/system/system_ext/priv-app/Launcher3QuickStep
"

############
# Permissions
############

# Set permissions
set_permissions() {
  set_perm_recursive "$MODPATH" 0 0 0777 0777
  set_perm_recursive "$MODPATH/system/product/overlay" 0 0 0777 0777
}

############
# Info Print
############

# Set what you want to be displayed on header of installation process
info_print() {
  ui_print ""
  ui_print "**********************************************"
  ui_print "• QS Compact - Weather Tiles"
  ui_print "• By @iamakima @LessContent"
  ui_print "**********************************************"
  ui_print ""
    
  sleep 2
}

############
# Main
############

# Change the logic to whatever you want
init_main() {  
  ui_print ""
  ui_print "[*] Lets start? Choose one option below"
  ui_print "Volume Up to choose the version"
  ui_print "Volume Down to confirm "
  ui_print ""
  
  sleep 0.5
  
  ui_print "[1] Classic (Original QS Compact Ideia)"
  ui_print "[2] SStyle(Tiles Estilo Android S)"
  
  ui_print ""
  ui_print "[*] Select which variant you want:"
  
  SM=1
  while true; do
    ui_print "  $SM"
    "$VKSEL" && SM="$((SM + 1))" || break
    [[ "$SM" -gt "5" ]] && SM=1
  done

  case "$SM" in
  "1") FCTEXTAD1="Classic";;
  "2") FCTEXTAD1="SStyle";;
  esac

  ui_print "[*] Selected: $FCTEXTAD1"
  ui_print ""
  
  if [[ "$FCTEXTAD1" == "Classic" ]]; then
    mv -f "$MODPATH/system/product/overlay/LessContentQC/LessContentQL.apk" "$MODPATH/system/product/overlay/LessContentQC/LessContentQSS.apk"
    rm -rf "$MODPATH/system/product/overlay/LessContentQS/LessContentQL.apk" "$MODPATH/system/product/overlay/LessContentQS/LessContentQSS.apk"

  elif [[ "$FCTEXTAD1" == "SStyle" ]]; then
    mv -f "$MODPATH/system/product/overlay/LessContentQC/LessContentQL.apk" "$MODPATH/system/product/overlay/LessContentQC/LessContentQSS.apk"
    rm -rf "$MODPATH/system/product/overlay/LessContentQS/LessContentQL.apk" "$MODPATH/system/product/overlay/LessContentQS/LessContentQSS.apk"
  fi
  
  
  ui_print "[*] Clearing system cache to make it work properly..."
  ui_print ""

  rm -rf "/data/system/package_cache"

  sleep 0.5

  ui_print "[*] Done!"
  ui_print ""

  sleep 0.5

  ui_print "Ok, done!"
  ui_print ""
  ui_print "[*] Reboot is required"

  sleep 2
}