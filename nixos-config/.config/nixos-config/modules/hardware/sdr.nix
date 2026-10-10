{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.hardware.sdr;
in
{
  options.my.hardware.sdr.enable = lib.mkEnableOption "software defined radio tooling";

  config = lib.mkIf cfg.enable {
    hardware.rtl-sdr.enable = true;

    environment.systemPackages = with pkgs; [
      gnuradio
      hackrf # hackrf_info, hackrf_transfer, hackrf_sweep, hackrf_spiflash, etc.
      rtl-sdr # handy if you also have an RTL-SDR dongle around
      soapysdr-with-plugins # unified SDR abstraction layer (works with HackRF via SoapyHackRF)
      gqrx # waterfall/spectrum receiver GUI (uses gr-osmosdr/soapysdr under the hood)
      cubicsdr # alternative SDR GUI, good HackRF support
      inspectrum # offline signal analysis on IQ capture files
      urh # Universal Radio Hacker - protocol reverse engineering
      wsjtx # FT8/FT4/WSPR etc.
      sox # quick audio manipulation/playback of demodulated audio
    ];
  };
}
