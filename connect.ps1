terraform output -raw tls_private_key > id_rsa

$publicip = terraform output public_ip_address

$hostname = $publicip.Trim('"')

ssh -i id_rsa amitgujar@$hostname
