let
  users.daniel = "age1yubikey1qtl2qmcpwsuse7va9834n2uucyynjyvguzycwgwtfz7h0mjnf2fgypkdw6g";
  systems.fermata = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINmwznoO2y+DBjT8g0vYUaYyvTYfwqVFlIFtjtGBps4f";
  default = [users.daniel systems.fermata];
in {
  "home/secrets/wakatime.cfg.age".publicKeys = default;
  "home/secrets/sshconfig.age".publicKeys = default;
}
