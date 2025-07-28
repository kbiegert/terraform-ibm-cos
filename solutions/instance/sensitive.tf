# Sensitive variable definition
variable "greeting" {
    description = "The sensitive greeting message to display"
    type        = string
    default     = null
    sensitive   = true
}

# Always trigger approach - uses conditional expression because Terraform cannot 
# interpolate null values directly in string templates. This avoids the error:
# "Cannot include a null value in a string template"
resource "terraform_data" "hello_world" {
    # Force replacement (and provisioner execution) every time using timestamp
    # triggers_replace causes resource recreation, which runs provisioners
    triggers_replace = [timestamp()]
    
    provisioner "local-exec" {
        command = var.greeting == null ? "echo 'Variable is NULL'" : "echo 'Variable has value: ${var.greeting}'"
    }
}

# always run with direct value echo
# Uses conditional expression to handle null safely in string interpolation
resource "terraform_data" "direct_value_echo" {
    # Force replacement (and provisioner execution) every time using timestamp
    # triggers_replace causes resource recreation, which runs provisioners
    triggers_replace = [timestamp()]
    
    provisioner "local-exec" {
        # Conditional expression prevents null interpolation error
        command = "echo 'Direct value: ${var.greeting == null ? "NULL" : var.greeting}'"
    }
}

# Outputs that describe what happened
output "execution_status" {
    value = var.greeting != null ? "Executed with sensitive value" : "Executed with null value"
    sensitive = true
}

output "variable_state" {
    value = var.greeting != null ? "Variable has a value" : "Variable is null"
    sensitive = true
}