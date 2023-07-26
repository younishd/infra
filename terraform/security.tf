resource "hcloud_ssh_key" "default" {
  name       = "younishd@lovelace"
  public_key = file("id_ed25519.pub")
}
