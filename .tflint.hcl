plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

# Google-specific rules: invalid machine types, regions, disk types...
plugin "google" {
  enabled = true
  version = "0.41.0"
  source  = "github.com/terraform-linters/tflint-ruleset-google"
}
