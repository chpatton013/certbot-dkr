FROM archlinux/base

RUN pacman --sync --refresh --noconfirm \
      certbot \
      certbot-apache \
      certbot-dns-cloudflare \
      certbot-dns-cloudxns \
      certbot-dns-digitalocean \
      certbot-dns-dnsimple \
      certbot-dns-dnsmadeeasy \
      certbot-dns-gehirn \
      certbot-dns-google \
      certbot-dns-linode \
      certbot-dns-luadns \
      certbot-dns-nsone \
      certbot-dns-ovh \
      certbot-dns-rfc2136 \
      certbot-dns-route53 \
      certbot-dns-sakuracloud \
      certbot-nginx \
 && mkdir --parents \
      /usr/local/etc/certbot \
      /etc/letsencrypt \
      /var/lib/letsencrypt \
      /var/log/letsencrypt
VOLUME \
      /usr/local/etc/certbot \
      /etc/letsencrypt \
      /var/lib/letsencrypt \
      /var/log/letsencrypt
EXPOSE 53 80 443 853
ENTRYPOINT ["/usr/bin/certbot"]
