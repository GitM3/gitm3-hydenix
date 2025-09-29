{ services, ... }:
{
  services.gammastep = {
    enable = true;
    temperature = {
      day = 5700;
      night = 3500;
    };
    latitude = "35.6945";
    longitude = "139.9827";
    tray = true;
  };
}
