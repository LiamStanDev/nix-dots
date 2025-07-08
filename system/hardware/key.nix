{
  # Keyd is low-level keyboard remapping software. It works for all different
  # desktops and windows managers.
  services.keyd.enable = true;
  services.keyd.keyboards = {
    default = {
      ids = ["*"]; # keyboard ID, or use "*" for all keyboards
      settings = {
        main = {
          capslock = "esc";
        };
      };
    };
  };
}
