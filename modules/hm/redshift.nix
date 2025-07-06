{services, ...}:
{
services.redshift = {
  enable = true;

  temperature = {
    day = 5700;
    night = 3500;
  };

  latitude = "27.9880614";
  longitude = "86.92521";

  # Schedule settings
  # settings = {
  #   dawn-time = "5:30-6:00";
  #   dusk-time = "18:35-20:15";
  # };

  brightness = {
    day = "1";
    night = "0.8";
  };

  extraOptions = [
    # "-v"
    # "-m randr"
  ];
};
  }
