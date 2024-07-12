let
  homes = {
    fermata = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAFFAuJa9TYB3IsHly1Z4WjQrr4cEkubNWQyhIClh6bH";
  };
  yubikeys._5c = "age1yubikey1qtl2qmcpwsuse7va9834n2uucyynjyvguzycwgwtfz7h0mjnf2fgypkdw6g";

  default = [yubikeys._5c] ++ (builtins.attrValues homes);
in {
  "serverip.age".publicKeys = default;
}
