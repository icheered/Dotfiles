{
  config,
  pkgs,
  lib,
  ...
}:
let
  username = "tjbakker";
in
{
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    epson-escpr  # Basic Epson driver
    epson-escpr2
    gutenprint   # Additional printer drivers
    epsonscan2   # Scanner driver
  ];
  # Enable printer discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Printer Configuration
  # gutenprint.5.3://escp2-et2750be/expert
  # gutenprint.5.3://escp2-et2750/expert
  # gutenprint/5.3.4/en/orig/Epson-Expression_ET-2750_EcoTank.ppd
  # epson-inkjet-printer-escpr/Epson-ET-2850_Series-epson-escpr-en.ppd

  hardware.printers.ensurePrinters = [
  {
    name = "PaperPrinter";
    location = "Local Printer";
    deviceUri = "ipp://192.168.5.183:631/ipp/print";
    model = "epson-inkjet-printer-escpr/Epson-ET-2850_Series-epson-escpr-en.ppd";
    ppdOptions = {
      PageSize = "A4"; # Normal not Borderless : 4X6FULL
      Duplex = "DuplexNoTumble"; # DuplexTumble
      MediaType = "PLAIN_NORMAL";
      # Resolution = "1444x720dpi";
      # Quality = "High";
      # ColorModel = "RGB";
      # OutputOrder = "Reverse";
    };
  }
  {
    name = "PhotoPrinter";
    deviceUri = "ipp://192.168.5.183:631/ipp/print";
    model = "epson-inkjet-printer-escpr/Epson-ET-2850_Series-epson-escpr-en.ppd";
    ppdOptions = {
      PageSize = "T4X6FULL"; # Normal not Borderless : 4X6FULL
      Duplex = "None"; # DuplexTumble
      MediaType = "PMPHOTO_HIGH";
      Resolution = "1444x720dpi";
      # Quality = "High";
      # ColorModel = "RGB";
      # OutputOrder = "Reverse";
    };
  }
];
}
