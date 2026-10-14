resource "cloudflare_dns_record" "vpn_admin" {
  zone_id = var.cloudflare_zone_id
  name    = "vpn-gui"
  type    = "CNAME"
  content = "vpn.alftberg.net"
  proxied = false
  ttl     = 300
}
