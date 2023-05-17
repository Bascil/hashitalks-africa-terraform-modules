output "key_ring_name" {
    description = "Name of the keyring"
    value = google_kms_key_ring.key_ring.name
}

output "key_name" {
    description = "Name of the key"
    value = google_kms_crypto_key.key.name
}

