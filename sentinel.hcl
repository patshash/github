import "module" "tfplan-functions" {
    source = "./common-functions/tfplan-functions.sentinel"
}

policy "prevent-recreate-of-resources" {
    source = "./prevent-recreate-of-resources.sentinel"
    enforcement_level = "hard-mandatory"
}
