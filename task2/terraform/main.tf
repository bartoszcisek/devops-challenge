resource "cloudscale_server" "web-worker01" {
  name = "web-worker01"
  flavor_slug         = "flex-4-1"
  image_slug          = "debian-12"
  volume_size_gb      = 10
  ssh_keys = [file("ssh_keys/id_rsa.pub")]
}


output "web-worker01-ipv4-address" {
  value = cloudscale_server.web-worker01.public_ipv4_address
}
