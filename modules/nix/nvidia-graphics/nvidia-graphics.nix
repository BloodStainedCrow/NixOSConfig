{
  flake.modules.nixos.nvidia-graphics = {pkgs, config, ...}: {
    # "It is suggested to use the open source kernel modules on Turing or later GPUs (RTX series, GTX 16xx), and the closed source modules otherwise."
    # Try the closed source driver for high refresh rate gsync. If Free sync works thats fine too
    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;


      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
      # of just the bare essentials.
      # TODO: This might fix the sleep issues I was having
      # (It did not :/)
      # powerManagement.enable = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      open = false;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };


    # TODO: For now i will use x11 (disabling wayland) since nvidia does not properly support wayland :/
    services.displayManager.gdm.wayland = true;

    # Enable OpenGL
    hardware.graphics = {
      enable = true;
      # extraPackages = with pkgs; [
      #   # Add packages needed for Nouveau acceleration here
      #   # For example, Mesa for OpenGL:
      #   mesa
      #   mesa.drivers
      # ];
    };

    # programs.vtune.enable = true;

    # # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = ["nvidia"];
    # services.xserver.videoDrivers = ["nouveau"];


    # Ensure the Nouveau module is loaded
    # boot.kernelModules = [ "xf86_video_nouveau" ];

    # environment.systemPackages = with pkgs; [
    #  xorg.xf86videonouveau
    # ];


    # Blacklist the proprietary NVIDIA driver, if needed
    # boot.blacklistedKernelModules = [ "nvidia" "nvidia_uvm" "nvidia_drm" "nvidia_modeset" ];

    # # Configure Xorg to use the Nouveau driver
    # services.xserver = {
    #   enable = true;
    #   videoDrivers = [ "nouveau" ];

    #   # Optional: Configure display settings, if necessary
    #   # displayManager = {
    #   #   ...
    #   # };
    #   # desktopManager = {
    #   #   ...
    #   # };
    # };

    # # Enable hardware acceleration for Nouveau
    # hardware.opengl = {
    #   enable = true;
    #   extraPackages = with pkgs; [
    #     # Add packages needed for Nouveau acceleration here
    #     # For example, Mesa for OpenGL:
    #     mesa
    #     mesa.drivers
    #   ];
    # };

    # # Additional configurations if required
    # # For example, to manage power settings for Nouveau:
    # environment.etc."modprobe.d/nouveau.conf".text = ''
    #   options nouveau modeset=1
    # '';
  };
}