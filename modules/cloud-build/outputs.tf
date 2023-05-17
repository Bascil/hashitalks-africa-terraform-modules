output "trigger_name" {
    description = "Name of the trigger"
    value = google_cloudbuild_trigger.trigger.name
}

output "file_name" {
    description = "Name of the file"
    value = google_cloudbuild_trigger.trigger.filename
}

