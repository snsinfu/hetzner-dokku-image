variable "image_id" {
}

data "hcloud_image" "main" {
  id = "${var.image_id}"
}

resource "hcloud_ssh_key" "primary" {
  name       = "primary key"
  public_key = "${file("sshkey.pub")}"
}

resource "hcloud_server" "main" {
  name        = "main"
  location    = "fsn1"
  server_type = "cx11"
  image       = "${data.hcloud_image.main.id}"
  ssh_keys    = ["${hcloud_ssh_key.primary.id}"]
}

output "ip" {
  value = "${hcloud_server.main.ipv4_address}"
}
